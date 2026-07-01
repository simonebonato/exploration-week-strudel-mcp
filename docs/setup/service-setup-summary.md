# Service Setup Summary (macOS + Windows)

One page covering **every service**, on **both platforms**. macOS steps are verified
(2026-07-01). **Windows steps are written from docs and NOT yet tested** — verify on a
Windows machine before the event.

> Legend: ✅ verified on this machine · 🪟 Windows, not yet verified

---

## 0. Prerequisites (all clients, both platforms)

| | macOS ✅ | Windows 🪟 |
|---|---|---|
| **Node.js 22+** | `brew install node` or nvm | Installer from [nodejs.org](https://nodejs.org), or `winget install OpenJS.NodeJS`, or nvm-windows |
| Check | `node -v` (need v22+) | `node -v` in PowerShell |
| **Audio** | speakers/headphones | speakers/headphones |

## 1. One-time install (both platforms — same commands)

```bash
npm install -g @williamzujkowski/live-coding-music-mcp
npx playwright install chromium
```

- The global bin `live-coding-music-mcp` must be on PATH.
  - macOS (nvm): `~/.nvm/versions/node/<ver>/bin/` ✅
  - Windows: `%APPDATA%\npm\live-coding-music-mcp.cmd` (npm adds this to PATH). 🪟
- The Playwright "install your dependencies first" warning is harmless — Chromium still
  downloads.
- **Windows only:** no extra system deps needed (unlike Linux). If Chromium fails to launch,
  install the [VC++ redistributable] and retry. 🪟

---

## 2. Per-service registration

### Claude Code — ✅ verified
Same on both platforms:
```bash
claude mcp add strudel live-coding-music-mcp
claude mcp list            # expect: strudel ... ✔ Connected
```
Tools load at session start → open a **new** session to use them.
Full guide: [claude-code.md](./claude-code.md).

### Codex (OpenAI) — ✅ verified on macOS
```bash
codex mcp add strudel -- live-coding-music-mcp
codex mcp list             # expect: strudel ... enabled
```
Config file written to:
- macOS/Linux: `~/.codex/config.toml` ✅
- Windows: `%USERPROFILE%\.codex\config.toml` 🪟

The block looks like:
```toml
[mcp_servers.strudel]
command = "live-coding-music-mcp"
```
> On Windows, if you hand-edit any path in Codex/MCP JSON/TOML, use **forward slashes**.
Full guide: [codex.md](./codex.md).

### Antigravity CLI (Google) — ✅ verified on macOS  ← the free Google client
No `mcp` subcommand; it reads a config file. Command is `agy`.

Config file:
- macOS/Linux: `~/.gemini/config/mcp_config.json` ✅
- Windows: `%USERPROFILE%\.gemini\config\mcp_config.json` 🪟

Contents (strict JSON, no comments):
```json
{
  "mcpServers": {
    "strudel": { "command": "live-coding-music-mcp", "args": [] }
  }
}
```
Verify: `agy -p "List your strudel MCP tools."` → should list init/edit_pattern/playback/...
Full guide: [antigravity-cli.md](./antigravity-cli.md).

### Gemini CLI — ⚠️ deprecated for free accounts
Replaced by Antigravity CLI on 2026-06-18 for free/unpaid tiers. Only relevant on a **paid**
plan, where MCP config lives in `~/.gemini/settings.json` (Windows:
`%USERPROFILE%\.gemini\settings.json`) under `mcpServers`. See [gemini-cli.md](./gemini-cli.md).

### Claude Desktop (optional alternative to Claude Code)
Edit the desktop config, then restart the app:
- macOS: `~/Library/Application Support/Claude/claude_desktop_config.json`
- Windows: `%APPDATA%\Claude\claude_desktop_config.json` 🪟
```json
{ "mcpServers": { "strudel": { "command": "live-coding-music-mcp" } } }
```

---

## 3. Free / no-subscription options (for students)

Three €0 ways to drive the same server, including fully-local models — see
[free-and-local-options.md](./free-and-local-options.md). (Local paths not yet tested.)

---

## 4. Quick sanity checklist (run before the demo, per machine)

1. `node -v` → v22+ ✔
2. `live-coding-music-mcp` resolves on PATH ✔
3. Client shows the server connected/enabled ✔
4. From a fresh session: "Initialize Strudel and play a kick" → **Chromium opens + sound** ✔
5. If the browser window dies mid-demo → re-run "Initialize Strudel" (`init`) to relaunch.

## 5. Windows verification TODO (before the event)
- [ ] Node 22+ installs and `live-coding-music-mcp` lands on PATH.
- [ ] `npx playwright install chromium` succeeds; Chromium launches visibly.
- [ ] Claude Code / Codex / Antigravity each connect on Windows.
- [ ] Audio actually plays from the Chromium window on Windows.
