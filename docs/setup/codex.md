# Strudel MCP in Codex (OpenAI Codex CLI)  ✅ verified 2026-07-01

> Verified on **codex-cli 0.137.0**: `codex mcp add` worked and `codex mcp list` shows
> `strudel` as `enabled`. Live *audio* from Codex not yet exercised (audio confirmed via
> Claude Code) — see `logs/todo.md`, slice 3.

## 1. One-time install (if not done yet)

```bash
npm install -g @williamzujkowski/live-coding-music-mcp
npx playwright install chromium
```

## 2. Register the server with Codex

**Option A — command:**

```bash
codex mcp add strudel -- live-coding-music-mcp
```

**Option B — edit `~/.codex/config.toml`** (or a project-scoped `.codex/config.toml`):

```toml
[mcp_servers.strudel]
command = "live-coding-music-mcp"
# args = []                 # none needed
# startup_timeout_sec = 20  # bump if the browser is slow to launch
```

> Note the underscore: Codex uses `[mcp_servers.<name>]` (not `mcpServers`).

## 3. Confirm

```bash
codex mcp list
```

Expected (verified):

```
Name     Command                Args  Env  Cwd  Status   Auth
strudel  live-coding-music-mcp  -     -    -    enabled  Unsupported
```

Then start Codex and ask it to initialize Strudel and play a pattern.

> ⚠️ On this machine `~/.codex/config.toml` is a **symlink into the dotfiles repo**
> (`~/dotfiles/ai/codex/config.toml`), so `codex mcp add` writes the `[mcp_servers.strudel]`
> block there. Review/commit that dotfile deliberately. To keep dotfiles clean instead, put
> the block in a project-scoped `.codex/config.toml`.

## 4. Use it

Same prompts as any client: "Initialize Strudel", "play a kick pattern", "set tempo 128",
"stop". Codex calls the same MCP tools (`init`, `edit_pattern`, `playback`, ...).

## Troubleshooting / to verify

- [ ] Confirm the installed Codex version supports `codex mcp add` (older builds only read
      `config.toml`).
- [ ] If tools don't load, restart Codex and re-check `~/.codex/config.toml`.
- [ ] Browser audio needs a user gesture — click once in the Chromium window if silent.

## Reference
- Codex MCP docs: <https://developers.openai.com/codex/mcp>
- Codex config reference: <https://developers.openai.com/codex/config-reference>
