# AGENTS.md — Strudel MCP Exploration

Durable project facts. Read this first.

## What this project is

A knowledge base + working setup for teaching students **how to connect an MCP server to
agentic coding CLIs**, using [Strudel](https://strudel.cc/) live-coding music as the
tangible, audible example.

**The demo's real subject is MCP + agents, not music.** Strudel is the fun vehicle that
makes MCP click: you type to an agent, and a browser makes music.

- **Presenter/owner:** Simone Bonato
- **Audience:** students, beginners to MCP/agents
- **Timeline:** Exploration Week workshop, **early September 2026**
- **Format (decided 2026-08-18):** hands-on — students install and drive the MCP from
  their **own laptops (mixed Windows/macOS)**, with pre-work install before the day.
- **Hard requirement:** the same MCP server must work in **three vendors' agent CLIs** —
  this is *coverage* (students arrive with whichever agent they already use), not a stage
  demo. No manual paste-in fallback (rehearsal is the insurance).
  - Anthropic → **Claude Code**, OpenAI → **Codex**, Google → **Antigravity CLI**.
  - ⚠️ Google leg changed: **Gemini CLI was replaced by Antigravity CLI on 2026-06-18** for
    free/unpaid accounts. The presenter has no paid sub → use **Antigravity CLI**.

See the full PRD: [docs/prd/2026-07-01-strudel-mcp-teaching-demo.md](docs/prd/2026-07-01-strudel-mcp-teaching-demo.md)

## Core technical facts (verified 2026-07-01)

- **Strudel makes sound only in a browser** (Web Audio API). No headless audio-from-CLI.
  Anything that produces sound must drive a browser.
- **Music target:** strudel.cc online. Simplest path. Works offline as a PWA after first
  load. No local Strudel clone needed.
- **MCP server:** `@williamzujkowski/live-coding-music-mcp` **pinned to v4.0.0** (bin:
  `live-coding-music-mcp`). Older name `@williamzujkowski/strudel-mcp-server` is stale — do
  not use it. Pinned because the package is experimental; re-verify before unpinning.
  - Drives strudel.cc via **Playwright + Chromium** (auto-installed).
  - Opens a **visible Chromium window** by default — good for teaching; also needed for
    reliable audio activation on some machines. Do NOT run headless for the demo.
  - Needs **Node 22+**. This machine: Node v22.22.2, npm 10.9.7. ✅
  - **stdio** transport → works with any MCP client.
  - **Gemini API key optional** (only the `ai_assist` tool needs it).
  - Explicitly **experimental** ("not for production", "expect rough edges").
  - ~27 tools: init, edit_pattern, get_pattern, playback, set_tempo, pattern_store,
    compose, generate_rhythm, music_theory, transform/effect/shape, analyze, session,
    import/export_midi, diagnostics, etc.

## How each client adds the server (all use the same stdio command)

| Client | Command / config |
| --- | --- |
| Claude Code | `claude mcp add strudel live-coding-music-mcp` |
| Codex | `codex mcp add strudel -- live-coding-music-mcp` → writes `~/.codex/config.toml` |
| Antigravity CLI | edit `~/.gemini/config/mcp_config.json` → `mcpServers.strudel` |
| ~~Gemini CLI~~ | deprecated for free tier (2026-06-18); was `~/.gemini/settings.json` |

⚠️ On this machine `~/.codex/config.toml` is a **symlink into the dotfiles repo**
(`~/dotfiles/ai/codex/config.toml`). `codex mcp add` writes there — review before committing.

⚠️ On **Windows**, npm global bins are `.cmd` shims; some MCP clients can't spawn them
directly — register the server as `cmd /c live-coding-music-mcp` if it fails to start.
See `docs/setup/service-setup-summary.md`.

⚠️ Each client spawns its **own** server instance → its **own** Chromium window. Run one
client at a time during the demo.

## Machine state (this demo machine, updated 2026-08-18)

- Node v22.22.2, npm 10.9.7 — meets Node 22+ requirement.
- MCP server installed globally (v4.0.0); Chromium 1228 installed (Playwright 1.61.1).
- Claude Code: `strudel` server **connected** ✅; audio proven end-to-end (`analyze`
  confirmed sound, 2026-07-01).
- Codex 0.137.0: `strudel` registered, `enabled` ✅ (live audio not yet tested).
- Antigravity CLI (`agy`): installed, signed in, all 26 strudel tools listed ✅ (live
  audio not yet tested).
- Windows: **nothing verified yet** — dry-run planned before the event.

## Where things live

- `AGENTS.md` / `CLAUDE.md` — durable facts (keep in sync).
- `docs/prd/` — PRDs.
- `docs/setup/` — per-platform, per-client setup guides (student-facing).
- `docs/strudel/` — primer + tested demo patterns.
- `logs/` — running logs: what was done, install notes, open to-dos, meeting notes.

## Key decisions

1. Online strudel.cc, not a local clone. Reason: simplest path. (2026-07-01)
2. Reuse the existing MCP server, don't build our own (revisit only if it blocks us). (2026-07-01)
3. Play & control live (browser automation), not just generate code text. (2026-07-01)
4. No paste-in fallback; de-risk via a full rehearsal on the demo machine. (2026-07-01)
5. Hands-on format: students install (pre-work) and drive from their own mixed-OS laptops. (2026-08-18)
6. Engagement = missions + finale showcase; last rung shifts curiosity to MCP itself
   (Inspector, unused tools, "what else could MCP drive?"). (2026-08-18)
7. Pin the MCP server to v4.0.0 until re-verified. (2026-08-18)

## Conventions

- Keep durable facts here, not in chat. Update this file as facts change.
- Log progress and gotchas in `logs/`.
- PRDs in `docs/prd/<YYYY-MM-DD>-<slug>.md`.
