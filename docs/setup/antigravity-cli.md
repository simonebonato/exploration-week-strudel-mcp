# Strudel MCP in Antigravity CLI (Google)  ✅ verified 2026-07-01

> **CLI command on this machine:** `agy` (`~/.local/bin/agy`). There is **no** `agy mcp`
> subcommand — MCP servers are loaded from the config file below and surfaced inside a
> session. Verified: `agy -p "list your strudel MCP tools"` returned all 26 tools.

> **Why Antigravity, not Gemini CLI?** As of **June 18, 2026**, Google replaced Gemini CLI
> with **Antigravity CLI** for free/unpaid and Google One tiers. Antigravity CLI is the
> free successor and is what a no-subscription Google account uses now. See
> `docs/setup/gemini-cli.md` for the short history.
>
> Written from official + community docs. **Not yet installed on this machine** — must be
> verified live before the session (`logs/todo.md`, slice 4).

## 0. Cost

Free with a personal Google account (part of the Gemini→Antigravity transition). Free tier
runs **Gemini Flash**-class models, which is plenty for MCP tool-calling / driving Strudel.

## 1. One-time install (if not done yet)

```bash
npm install -g @williamzujkowski/live-coding-music-mcp
npx playwright install chromium
```

Then install Antigravity CLI itself (see Google's docs: <https://antigravity.google/docs>).

## 2. Register the server

Antigravity (CLI + IDE) share **one** MCP config file:

```
~/.gemini/config/mcp_config.json
```

Create it (and the `~/.gemini/config/` folder) if missing, then add:

```json
{
  "mcpServers": {
    "strudel": {
      "command": "live-coding-music-mcp",
      "args": []
    }
  }
}
```

Rules:
- `command` must be on PATH (`which live-coding-music-mcp`).
- **No inline comments** — `mcp_config.json` is strict JSON.
- Known rough edge (per community docs): env-var expansion for API keys has been flaky;
  we don't need any keys here (Gemini API key is only for the optional `ai_assist` tool).

## 3. Confirm & use

Quick non-interactive check (what we used):

```bash
agy -p "Do you have an MCP server named 'strudel'? List its tools."
# -> "Yes." + the full tool list (init, edit_pattern, playback, ...)
```

Or just start an interactive session (`agy`) and prompt as with any client:

- "Initialize Strudel."
- "Play a four-on-the-floor kick and set tempo to 128."
- "Stop."

## Still to verify before the demo

- [x] Antigravity CLI installed + signed in (free Google account).  ✅ 2026-07-01
- [x] `strudel` server loads and tools are listed.  ✅ 2026-07-01
- [ ] A pattern actually **plays + makes sound** when driven from Antigravity (only the
      tool listing is confirmed so far; audio was confirmed via Claude Code).
- [ ] Confirm the free (Flash) tier reliably drives multi-step tool calls during a live run.

## Reference
- Antigravity MCP docs: <https://antigravity.google/docs/mcp>
- Community guide (config format): <https://devengoratela.com/2026/05/configuring-mcp-servers-and-skills-for-antigravity-cli-and-ide/>
