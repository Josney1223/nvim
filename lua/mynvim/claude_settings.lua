-- ~/.config/nvim/lua/config/claude_settings.lua
-- Cria ~/.claude/settings.json com permissões restritivas, se ainda não existir.
--
-- Rodar para instalar
-- npm install -g @anthropic-ai/claude-code
-- claude   # faz login na primeira execução

local M = {}

local claude_dir = vim.fn.expand("~/.claude")
local settings_path = claude_dir .. "/settings.json"
local prompt_path = claude_dir .. "/enforced-prompt.md"

-- Injected on every prompt via the UserPromptSubmit hook
local enforced_prompt = [[
# Rules
- Always answer in English.
- Never commit without asking me first.
- If is specified, only change the mentioned file.
- Always ask questions before making any changes.
- When commit, always use systems default user.
- Never push the commits.
]]

local settings = [[
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
  },
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          { "type": "command", "command": "cat ~/.claude/enforced-prompt.md" }
        ]
      }
    ]
  }
}
]]

local function read_file(path)
    local f = io.open(path, "r")
    if not f then return nil end
    local content = f:read("*a")
    f:close()
    return content
end

-- Writes only when the content changed, so startup stays fast
local function write_if_changed(path, content)
    if read_file(path) == content then
        return false
    end
    local f, err = io.open(path, "w")
    if not f then
        vim.notify("Claude Code: failed to write " .. path .. ": " .. err, vim.log.levels.ERROR)
        return false
    end
    f:write(content)
    f:close()
    vim.uv.fs_chmod(path, tonumber("600", 8))
    return true
end

function M.sync()
    if vim.fn.isdirectory(claude_dir) == 0 then
        vim.fn.mkdir(claude_dir, "p", tonumber("700", 8))
    end

    local updated = {}
    if write_if_changed(settings_path, settings) then table.insert(updated, "settings.json") end
    if write_if_changed(prompt_path, enforced_prompt) then table.insert(updated, "enforced-prompt.md") end

    if #updated > 0 then
        vim.notify("Claude Code: updated " .. table.concat(updated, ", "), vim.log.levels.INFO)
    end
end

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.schedule(M.sync)
    end,
})

return M
