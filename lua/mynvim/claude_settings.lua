-- ~/.config/nvim/lua/config/claude_settings.lua
-- On startup:
--   * ~/.claude/enforced-prompt.md, ~/.claude/output-styles/mentor.md,
--     ~/.claude/hooks/caveman.py and ~/.claude/skills/caveman/SKILL.md
--     are OVERWRITTEN with the content below.
--   * ~/.claude/settings.json is MERGED: our permission rules and our
--     UserPromptSubmit hook are added if missing. Everything else in the file
--     (OpenAPPA's hooks, plugins, rules Claude saved) is left untouched.

local M = {}

local claude_dir = vim.fn.expand("~/.claude")
local settings_path = claude_dir .. "/settings.json"
local prompt_path = claude_dir .. "/enforced-prompt.md"
local hook_command = "cat ~/.claude/enforced-prompt.md"
local style_path = claude_dir .. "/output-styles/mentor.md"

-- true  = Claude teaches and reviews, but cannot edit or create files
-- false = normal Claude Code (it codes for you)
local mentor_mode = true

-- true = terse "caveman" replies (default level below), switchable per session
local caveman_enabled = true
local caveman_default = "full" -- lite | full | ultra
local caveman_hook_path = claude_dir .. "/hooks/caveman.py"
local caveman_skill_path = claude_dir .. "/skills/caveman/SKILL.md"
local caveman_command = "python3 ~/.claude/hooks/caveman.py"

-- UserPromptSubmit hook: tracks the level per session and injects the rules
-- on every prompt, so the style can't drift in long sessions.
local caveman_hook = [==[
import json, re, sys, time
from pathlib import Path

DEFAULT = "__DEFAULT__"

COMMON = """CAVEMAN MODE ACTIVE (level: {level}). Applies to this reply.
Terse. All technical substance stays; only fluff dies.
Drop filler (just/really/basically/actually/simply), pleasantries
(sure/certainly/happy to), hedging. Technical terms exact. Errors quoted exact.
Code blocks, commit messages, PR text: write normal.
Pattern: [thing] [action] [reason]. [next step].
Bad: "Sure! I'd be happy to help. The issue is likely caused by..."
Good: "Bug in auth middleware. Expiry check uses `<` not `<=`. Fix:"
Auto-clarity: write normal, full sentences for security warnings, irreversible
or destructive actions, multi-step sequences where order matters, or when the
user asks to clarify or repeats a question. Resume caveman after that part.
Do not mention caveman mode unless the level just changed."""

LEVELS = {
    "lite": "LITE: no filler or hedging, but keep articles and full sentences. "
            "Professional, tight.",
    "full": "FULL: drop articles, fragments OK, short synonyms "
            "(big not extensive, fix not 'implement a solution for').",
    "ultra": "ULTRA: full rules plus abbreviations (DB/auth/config/req/res/fn/impl), "
             "no conjunctions, arrows for causality (X -> Y), one word when one "
             "word is enough.",
}

try:
    data = json.load(sys.stdin)
except Exception:
    data = {}
prompt = (data.get("prompt") or "").strip().lower()
session = re.sub(r"[^\w-]", "", data.get("session_id") or "default") or "default"

state_dir = Path.home() / ".claude" / "caveman-state"
state_dir.mkdir(parents=True, exist_ok=True)
for old in state_dir.iterdir():  # forget sessions older than 2 days
    if time.time() - old.stat().st_mtime > 2 * 86400:
        old.unlink(missing_ok=True)

state = state_dir / session
level = state.read_text().strip() if state.exists() else DEFAULT
changed = False

m = re.match(r"^/?caveman(?:\s+(lite|full|ultra|off))?\s*$", prompt)
if m:
    level, changed = (m.group(1) or "full"), True
elif re.fullmatch(r"(stop caveman|normal mode)[.!]?", prompt):
    level, changed = "off", True

state.write_text(level)

if level == "off":
    if changed:
        print("Caveman mode off. Reply normally from now on and confirm in one short sentence.")
    sys.exit(0)

print(COMMON.format(level=level))
print(LEVELS.get(level, LEVELS["full"]))
if changed:
    print(f"Level just set to {level}. Confirm in a few words, nothing else.")
]==]

-- Makes /caveman [lite|full|ultra|off] a real slash command.
-- The hook above does the actual switching.
local caveman_skill = [==[
---
name: caveman
description: Switch terse caveman reply mode. Usage /caveman lite|full|ultra|off
argument-hint: "[lite|full|ultra|off]"
disable-model-invocation: true
---

The caveman level is set by a hook, which already saw this command and added
the rules for the new level to your context. Confirm the new level in a few
words. Do nothing else.
]==]

-- Injected on every prompt via the UserPromptSubmit hook
local enforced_prompt = [[
# Rules
- Always answer in English.
- Never commit without asking me first.
- Run the tests after every change.
- Never add "Co-Authored-By" or "Generated with Claude Code" lines to commits or PRs.
]]

-- Rules that must always be present (added, never removed)
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

local function remove_value(list, value)
    for i = #list, 1, -1 do
        if list[i] == value then table.remove(list, i) end
    end
end

local function has_hook(entries, command)
    for _, entry in ipairs(entries) do
        for _, hook in ipairs(entry.hooks or {}) do
            if hook.command == command then return true end
        end
    end
    return false
end

local function remove_hook(entries, command)
    for i = #entries, 1, -1 do
        local hooks = entries[i].hooks or {}
        for j = #hooks, 1, -1 do
            if hooks[j].command == command then table.remove(hooks, j) end
        end
        if #hooks == 0 then table.remove(entries, i) end
    end
end

local function add_hook(entries, command)
    if not has_hook(entries, command) then
        table.insert(entries, { hooks = { { type = "command", command = command } } })
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
    local prompt_hooks = settings.hooks.UserPromptSubmit
    add_hook(prompt_hooks, hook_command)
    if caveman_enabled then
        add_hook(prompt_hooks, caveman_command)
    else
        remove_hook(prompt_hooks, caveman_command)
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

    local style_dir = vim.fn.fnamemodify(style_path, ":h")
    if vim.fn.isdirectory(style_dir) == 0 then
        vim.fn.mkdir(style_dir, "p", tonumber("700", 8))
    end

    if caveman_enabled then
        local files = {
            [caveman_hook_path] = caveman_hook:gsub("__DEFAULT__", caveman_default),
            [caveman_skill_path] = caveman_skill,
        }
        for path, content in pairs(files) do
            local dir = vim.fn.fnamemodify(path, ":h")
            if vim.fn.isdirectory(dir) == 0 then
                vim.fn.mkdir(dir, "p", tonumber("700", 8))
            end
            if read_file(path) ~= content and write_file(path, content) then
                table.insert(updated, vim.fn.fnamemodify(path, ":~"))
            end
        end
    elseif vim.uv.fs_stat(caveman_skill_path) then
        -- Mode off: remove the /caveman command so it doesn't linger
        vim.fn.delete(vim.fn.fnamemodify(caveman_skill_path, ":h"), "rf")
        table.insert(updated, "removed /caveman")
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
