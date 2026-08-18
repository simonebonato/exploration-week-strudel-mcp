# Strudel MCP in Antigravity CLI (Google)

**Status: ✅ installed, signed in, all 26 tools listed (2026-07-01) — live audio pending.**

> [!NOTE]
> **Why Antigravity, not Gemini CLI?** On **2026-06-18** Google replaced Gemini CLI with
> **Antigravity CLI** for free/unpaid and Google One tiers. It's what a no-subscription
> Google account uses now — free, running Gemini **Flash**-class models (fine for MCP
> tool-calling). History: [gemini-cli.md](./gemini-cli.md).

## Setup in 3 steps

```bash
# 1. One-time install (skip if done)
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0
npx playwright install chromium
# ...plus Antigravity CLI itself: https://antigravity.google/docs  (command: agy)
```

**2. Register the server** — unlike Claude Code/Codex there is **no `add` command**
(no `agy mcp add`); you edit a JSON config file. Two locations work:

| Scope | File |
| --- | --- |
| **Global** (recommended for the workshop) | `~/.gemini/config/mcp_config.json` |
| Workspace (this project only) | `.agents/mcp_config.json` in the project folder |

Create the file (and folders) if missing:

```json
{
  "mcpServers": {
    "strudel": { "command": "live-coding-music-mcp", "args": [] }
  }
}
```

**3. Confirm** — two ways:

- **Interactive MCP manager:** inside a session, type **`/mcp`** and press Enter → an
  overlay shows live connection status per server, can **reload the config** (no restart
  needed after editing), and shows connection logs.
- Non-interactive check:

```bash
agy -p "Do you have an MCP server named 'strudel'? List its tools."
# -> "Yes." + the full tool list (init, edit_pattern, playback, ...)
```

> [!WARNING]
> - `mcp_config.json` is **strict JSON** — no comments, no trailing commas.
> - `command` must resolve on PATH (`which live-coding-music-mcp`).
> - **Windows:** if the server won't start, use `"command": "cmd",
>   "args": ["/c", "live-coding-music-mcp"]` ([why](./service-setup-summary.md)).
> - No API key needed — a Gemini key is only for the optional `ai_assist` tool.

## Use it

Start an interactive session with `agy`, then just ask:

| You type | What happens |
| --- | --- |
| "Initialize Strudel." | Chromium opens at strudel.cc (`init`) |
| "Play a four-on-the-floor kick." | pattern written + played (`edit_pattern`, `playback`) |
| "Add a hi-hat and set the tempo to 128." | layer added (`edit_pattern`, `set_tempo`) |
| "Stop." | silence (`playback`) |

> [!TIP]
> **Code changed but the music didn't?** Press **`update`** top right in the strudel.cc
> window (or Ctrl/Cmd+Enter) — [screenshot](../assets/strudel-update-button.png).

> [!CAUTION]
> **Free-tier quota is metered and can run out mid-session** (it happened during testing,
> 2026-07-01 — see `logs/costs-and-quota.md`). It resets daily. Don't bet an
> uninterrupted live demo on it.

## Still to verify

- [ ] A pattern actually **plays + makes sound** driven from Antigravity (only tool
      listing confirmed so far).
- [ ] Free (Flash) tier reliably drives **multi-step** tool calls in a live run.

## Reference

- Antigravity MCP docs: <https://antigravity.google/docs/mcp>
- Community config guide: <https://devengoratela.com/2026/05/configuring-mcp-servers-and-skills-for-antigravity-cli-and-ide/>
