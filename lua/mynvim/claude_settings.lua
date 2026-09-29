-- ~/.config/nvim/lua/config/claude_settings.lua
-- Cria ~/.claude/settings.json com permissões restritivas, se ainda não existir.
-- Nunca sobrescreve um arquivo existente.
--
-- Rodar para instalar
-- npm install -g @anthropic-ai/claude-code
-- claude   # faz login na primeira execução

local M = {}

local settings_path = vim.fn.expand("~/.claude/settings.json")

-- JSON escrito à mão para ficar legível (vim.json.encode não indenta na 0.11)
local default_settings = [[
{
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)",
      "Read(~/.ssh/**)",
      "Read(~/.aws/**)",
      "Read(~/.gnupg/**)",
      "Read(~/.config/gh/**)",
      "Bash(curl:*)",
      "Bash(wget:*)",
      "Bash(sudo:*)",
      "Bash(rm -rf:*)",
      "Bash(ssh:*)",
      "Bash(scp:*)"
    ],
    "ask": [
      "Bash(git push:*)",
      "WebFetch"
    ],
    "allow": [
      "Bash(git status)",
      "Bash(git diff:*)",
      "Bash(git log:*)"
    ]
  }
}
]]

function M.ensure()
    if vim.uv.fs_stat(settings_path) then
        vim.notify("Claude Code: settings.json já existe " .. settings_path, vim.log.levels.INFO)
        return -- já existe, não mexe
    end

    local dir = vim.fn.fnamemodify(settings_path, ":h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p", tonumber("700", 8))
    end

    local ok = vim.fn.writefile(vim.split(default_settings, "\n", { trimempty = true }), settings_path)
    if ok == 0 then
        vim.uv.fs_chmod(settings_path, tonumber("600", 8))
        vim.notify("Claude Code: settings.json criado em " .. settings_path, vim.log.levels.INFO)
    else
        vim.notify("Claude Code: falha ao criar " .. settings_path, vim.log.levels.ERROR)
    end
end

-- Executa depois que o Neovim terminar de iniciar, para não atrasar o startup
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.schedule(M.ensure)
    end,
})

return M
