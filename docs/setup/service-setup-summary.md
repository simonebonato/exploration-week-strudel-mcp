# Service Setup Summary (macOS + Windows)

Every service, both platforms, one page.

> [!WARNING]
> macOS steps are **verified** (2026-07-01). **Windows steps are written from docs and NOT
> yet tested** — a dry-run on real Windows hardware is planned before the event.
>
> Legend: ✅ verified on this machine · 🪟 Windows, not yet verified

## 0. Prerequisites (all clients, both platforms)

| | macOS ✅ | Windows 🪟 |
| --- | --- | --- |
| **Node.js 22+** | `brew install node@22` or nvm | [nodejs.org](https://nodejs.org) installer, `winget install OpenJS.NodeJS.LTS`, or nvm-windows |
| Check | `node -v` (need v22+) | `node -v` in PowerShell |
| **Audio** | speakers/headphones | speakers/headphones |

## 1. One-time install (same commands on both platforms)

```bash
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0
npx playwright install chromium
```

The global bin `live-coding-music-mcp` must be on PATH:

| | Location |
| --- | --- |
| macOS (nvm) ✅ | `~/.nvm/versions/node/<ver>/bin/` |
| Windows 🪟 | `%APPDATA%\npm\live-coding-music-mcp.cmd` (npm adds this to PATH) |

> [!NOTE]
> The Playwright *"install your dependencies first"* warning is harmless — Chromium still
> downloads. On Windows, if Chromium fails to launch, install the VC++ redistributable and
> retry. 🪟

> [!IMPORTANT]
> **Windows `.cmd` gotcha** — the classic *"works on Mac, fails on Windows"* MCP failure.
> On Windows, npm installs the server as `live-coding-music-mcp.cmd` — a `.cmd` script,
> not a real program — and some MCP clients **cannot launch `.cmd` files** directly. The
> fix is always the same idea: launch it *through* the Windows shell (`cmd /c ...`). 🪟
>
> | Client | Windows-safe registration | Full example |
> | --- | --- | --- |
> | Claude Code | `claude mcp add strudel -- cmd /c live-coding-music-mcp` | [guide](./claude-code.md#-windows-if-the-server-wont-start) |
> | Codex (`config.toml`) | `command = "cmd"` · `args = ["/c", "live-coding-music-mcp"]` | [guide](./codex.md#-windows-if-the-server-wont-start) |
> | Antigravity (`mcp_config.json`) | `"command": "cmd", "args": ["/c", "live-coding-music-mcp"]` | [guide](./antigravity-cli.md#-windows-if-the-server-wont-start) |

## 2. Per-service registration

### Claude Code — ✅ verified (audio proven)

Same on both platforms:

```bash
claude mcp add strudel live-coding-music-mcp
claude mcp list            # expect: strudel ... ✔ Connected
```

Tools load at session start → open a **new** session. Full guide:
[claude-code.md](./claude-code.md).

### Codex (OpenAI) — ✅ verified on macOS

```bash
codex mcp add strudel -- live-coding-music-mcp
codex mcp list             # expect: strudel ... enabled
```

| Config file | Path |
| --- | --- |
| macOS/Linux ✅ | `~/.codex/config.toml` |
| Windows 🪟 | `%USERPROFILE%\.codex\config.toml` |

```toml
[mcp_servers.strudel]
command = "live-coding-music-mcp"
```

Full guide: [codex.md](./codex.md).

### Antigravity CLI (Google) — ✅ verified on macOS · the free Google client

No `mcp` subcommand; it reads a config file. Command is `agy`.

| Config file | Path |
| --- | --- |
| macOS/Linux ✅ | `~/.gemini/config/mcp_config.json` |
| Windows 🪟 | `%USERPROFILE%\.gemini\config\mcp_config.json` |

```json
{
  "mcpServers": {
    "strudel": { "command": "live-coding-music-mcp", "args": [] }
  }
}
```

Verify: `agy -p "List your strudel MCP tools."` → lists init/edit_pattern/playback/...
Full guide: [antigravity-cli.md](./antigravity-cli.md).

### Gemini CLI — ⚠️ deprecated for free accounts

Replaced by Antigravity CLI on 2026-06-18 for free/unpaid tiers. Only relevant on a
**paid** plan (`~/.gemini/settings.json`, Windows `%USERPROFILE%\.gemini\settings.json`).
See [gemini-cli.md](./gemini-cli.md).

### Claude Desktop (optional alternative to Claude Code)

Edit the config, then restart the app:

| | Path |
| --- | --- |
| macOS | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Windows 🪟 | `%APPDATA%\Claude\claude_desktop_config.json` |

```json
{ "mcpServers": { "strudel": { "command": "live-coding-music-mcp" } } }
```

## 3. Free / no-subscription options (for students)

Three €0 ways to drive the same server, including fully-local models — see
[free-and-local-options.md](./free-and-local-options.md). (Local paths not yet tested.)

## 4. Pre-demo sanity checklist (per machine)

1. `node -v` → v22+ ✔
2. `live-coding-music-mcp` resolves on PATH ✔
3. Client shows the server connected/enabled ✔
4. Fresh session: *"Initialize Strudel and play a kick"* → **Chromium opens + sound** ✔
5. Browser window died mid-demo? → ask for *"Initialize Strudel"* again (`init` relaunches).
   More: [recovery-playbook.md](./recovery-playbook.md).

## 5. Windows verification TODO (before the event)

- [ ] Node 22+ installs; `live-coding-music-mcp` lands on PATH.
- [ ] `npx playwright install chromium` succeeds; Chromium launches visibly.
- [ ] Claude Code / Codex / Antigravity each connect (with or without `cmd /c`).
- [ ] Audio actually plays from the Chromium window.
