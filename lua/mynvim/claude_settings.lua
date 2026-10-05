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
local hook_command = "cat ~/.claude/enforced-prompt.md"

-- Injected on every prompt via the UserPromptSubmit hook
local enforced_prompt = [[
# Rules
- Always answer in English.
- Never commit without asking me first.
- If is specified, only change the mentioned file.
- Always ask questions before making any changes.
- Never add "Co-Authored-By" or "Generated with Claude Code" lines to commits or PRs
- Never push the commits.
]]

local required_permissions = {
    deny = {
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
        "Bash(scp:*)",
    },
    ask = {
        "Bash(git push:*)",
        "WebFetch",
    },
    allow = {
        "Bash(git status)",
        "Bash(git diff:*)",
        "Bash(git log:*)",
    },
}

local function read_file(path)
    local f = io.open(path, "r")
    if not f then return nil end
    local content = f:read("*a")
    f:close()
    return content
end

local function write_file(path, content)
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

local function add_unique(list, value)
    if not vim.tbl_contains(list, value) then
        table.insert(list, value)
    end
end

local function merge_settings(settings)
    -- Disable the Co-Authored-By trailer and the PR footer
    settings.attribution = { commit = "", pr = "" }
    settings.includeCoAuthoredBy = false -- older versions

    settings.permissions = settings.permissions or {}
    for kind, rules in pairs(required_permissions) do
        settings.permissions[kind] = settings.permissions[kind] or {}
        for _, rule in ipairs(rules) do
            add_unique(settings.permissions[kind], rule)
        end
    end

    settings.hooks = settings.hooks or {}
    settings.hooks.UserPromptSubmit = settings.hooks.UserPromptSubmit or {}
    local present = false
    for _, entry in ipairs(settings.hooks.UserPromptSubmit) do
        for _, hook in ipairs(entry.hooks or {}) do
            if hook.command == hook_command then present = true end
        end
    end
    if not present then
        table.insert(settings.hooks.UserPromptSubmit, {
            hooks = { { type = "command", command = hook_command } },
        })
    end
    return settings
end

local function sync_settings()
    local raw = read_file(settings_path)
    local settings = {}
    if raw and raw:match("%S") then
        local ok, decoded = pcall(vim.json.decode, raw)
        if not ok or type(decoded) ~= "table" then
            -- Never overwrite a file we can't parse; it may hold other tools' config
            vim.notify("Claude Code: " .. settings_path .. " is not valid JSON, skipped", vim.log.levels.WARN)
            return false
        end
        settings = decoded
    end

    local before = raw and vim.json.encode(settings) or nil
    local after = vim.json.encode(merge_settings(settings))
    if before == after then
        return false
    end
    return write_file(settings_path, after .. "\n")
end

function M.sync()
    if vim.fn.isdirectory(claude_dir) == 0 then
        vim.fn.mkdir(claude_dir, "p", tonumber("700", 8))
    end

    local updated = {}
    if sync_settings() then table.insert(updated, "settings.json") end
    if read_file(prompt_path) ~= enforced_prompt and write_file(prompt_path, enforced_prompt) then
        table.insert(updated, "enforced-prompt.md")
    end

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
