# Gemini CLI — deprecated for this demo ⚠️

> [!CAUTION]
> **ARCHIVED 2026-08-20 — not a supported path.** Deprecated for free accounts on
> 2026-06-18, then dropped entirely. Supported clients are Claude Code and Codex.
> See [`README.md`](./README.md).

**Use [Antigravity CLI](./antigravity-cli.md) instead** as the Google-vendor client.

## Why

- Gemini CLI is/was **free** with a personal Google account (~60 req/min, 1000 req/day) —
  no paid subscription needed.
- **2026-03-25:** free tier restricted to Gemini **Flash** models (no Pro).
- **2026-06-18:** per the official [Gemini CLI quota page](https://geminicli.com/docs/resources/quota-and-pricing/),
  *"Unpaid tier and Google One users: Gemini CLI will be replaced by **Antigravity CLI**."*

Since the presenter uses a free (no-subscription) Google account, the demo's Google leg is
**Antigravity CLI**, not Gemini CLI. The MCP concept is identical — only the registration
file/command differs.

> If you specifically need Gemini CLI on a **paid** (Pro/Ultra) account, its MCP config
> lived in `~/.gemini/settings.json` under an `mcpServers` object with the same
> `{ "command": "live-coding-music-mcp" }` entry. Antigravity uses
> `~/.gemini/config/mcp_config.json` instead.
