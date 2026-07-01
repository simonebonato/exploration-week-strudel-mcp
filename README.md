# Strudel MCP — Teaching Demo

Connecting an **MCP server to agentic coding CLIs**, using [Strudel](https://strudel.cc)
live-coding music as the tangible, audible example. You type a request to an AI agent, and a
browser makes music.

**The real subject is MCP + agents, not music.** Strudel is the fun vehicle that makes the
idea click for students.

- **Owner:** Simone Bonato · **Audience:** students new to MCP/agents
- **Hard requirement:** same MCP server working live across **three vendors' agent CLIs**.

## Prerequisite: Node.js 22+ (this gives you `npm` and `npx` too)

Everything below runs on Node.js. **You only install Node — `npm` and `npx` come bundled
with it**, so there's nothing separate to install for those.

| Platform | Easiest way to get Node 22+ |
|---|---|
| **macOS** | [nvm](https://github.com/nvm-sh/nvm): `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh \| bash` then `nvm install 22` — or `brew install node@22` — or the installer at [nodejs.org](https://nodejs.org) |
| **Windows** | Installer (LTS) from [nodejs.org](https://nodejs.org), or `winget install OpenJS.NodeJS.LTS`, or [nvm-windows](https://github.com/coreybutler/nvm-windows) |
| **Linux** | [nvm](https://github.com/nvm-sh/nvm) (as above), or your distro's package manager |

Then check all three are present (Node **22 or newer**):

```bash
node -v    # e.g. v22.22.2  (must be 22+)
npm -v     # e.g. 10.9.7
npx -v     # e.g. 10.9.7
```

If `node -v` shows an older version, upgrade before continuing (with nvm: `nvm install 22 &&
nvm use 22`). New to the terminal? On macOS open **Terminal**, on Windows open **PowerShell**.

## Quick start

```bash
# 1. Install the MCP server + the browser it drives (Node 22+ required)
npm install -g @williamzujkowski/live-coding-music-mcp
npx playwright install chromium

# 2. Register it with your agent (pick one)
claude mcp add strudel live-coding-music-mcp        # Claude Code
codex mcp add strudel -- live-coding-music-mcp       # Codex
# Antigravity CLI: add to ~/.gemini/config/mcp_config.json (see docs)

# 3. Ask the agent: "Initialize Strudel and play a four-on-the-floor kick."
```

Full, per-client instructions (macOS + Windows): [docs/setup/](docs/setup/).

## Where things are

| Path | What |
|---|---|
| [`CLAUDE.md`](CLAUDE.md) | Durable project facts — read first |
| [`docs/prd/`](docs/prd/) | Product requirements (the plan) |
| [`docs/setup/`](docs/setup/) | Per-client setup guides + cross-platform summary + free/local options |
| [`docs/strudel/`](docs/strudel/) | Strudel primer + tested demo patterns + live script |
| [`logs/`](logs/) | Running logs: install steps, TODO, costs/quota |

## Status (updated 2026-07-01)

| Piece | State |
|---|---|
| MCP server installed (+ Chromium) | ✅ on this Mac |
| Audio proven end-to-end | ✅ via Claude Code (`analyze` confirmed sound) |
| Claude Code | ✅ connected |
| Codex | ✅ registered (`enabled`) |
| Antigravity CLI (`agy`) — the free Google client | ✅ server + tools listed |
| Gemini CLI | ⚠️ deprecated for free accounts (June 18, 2026) → use Antigravity |
| Strudel knowledge base | ✅ primer + 5 tested patterns |
| Free/local options for students | ✅ researched & documented (local not yet tested) |
| Windows setup | ✍️ documented, **not yet verified** (before event) |
| Cross-client audio parity (Codex, Antigravity) | ⬜ pending |
| Full rehearsal + recovery playbook | ⬜ pending |

## Key facts

- Strudel makes sound **only in a browser** (Web Audio). The MCP server drives a **visible
  Chromium** window pointed at strudel.cc — good for teaching.
- MCP server: `@williamzujkowski/live-coding-music-mcp` (stdio) — same command for every
  client. Node 22+.
- Each client spawns its **own** server + browser → run **one client at a time**.

See [`CLAUDE.md`](CLAUDE.md) for the full set of durable facts and decisions.
