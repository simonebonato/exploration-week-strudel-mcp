# Setup Guides

How to connect the **Strudel live-coding MCP server** to an agentic CLI. This is the
practical core of the student session.

## The big idea

You run a small local program (the **MCP server**). Your AI agent (Claude Code, Codex, or
Gemini CLI) talks to it. The server drives a real **Chromium browser** pointed at
[strudel.cc](https://strudel.cc/), typing music code and pressing play. So when you ask the
agent for "a techno beat," a browser window makes actual sound.

```
You  ─▶  Agent CLI  ─▶  MCP server  ─▶  Chromium ─▶  strudel.cc ─▶ 🔊 sound
        (Claude Code /   (live-coding-      (Playwright)
         Codex / Gemini)  music-mcp)
```

Same server, three different agents. Only the *way you register the server* differs.

## Prerequisites (all clients)

| Need | Why | Check |
|---|---|---|
| **Node.js 22+** and npm 10+ | runs the MCP server | `node -v` · `npm -v` |
| **The MCP server** | the bridge | see below |
| **Chromium** (via Playwright) | makes the sound | installed with the server |
| **Speakers/headphones** | to hear it | — |
| Internet (first run) | loads strudel.cc | works offline after first load |

### One-time install (do this once per machine)

```bash
npm install -g @williamzujkowski/live-coding-music-mcp
npx playwright install chromium
```

> ⚠️ The Playwright step prints a "install your project's dependencies first" warning.
> Ignore it — Chromium still downloads. This is expected for a globally-installed tool.

> 📋 Prefer one page covering **every service on macOS + Windows**? See
> [service-setup-summary.md](./service-setup-summary.md).

## Then pick your agent

Three different vendors, same server:

- **Anthropic** → [Claude Code](./claude-code.md) — ✅ verified connected
- **OpenAI** → [Codex](./codex.md) — ✅ registered (`enabled`), live play pending
- **Google** → [Antigravity CLI](./antigravity-cli.md) — ⏳ pending (successor to Gemini CLI)
  - [Gemini CLI](./gemini-cli.md) — ⚠️ deprecated for free accounts (June 18, 2026)

**Want a free / no-subscription setup (for students)?** →
[free-and-local-options.md](./free-and-local-options.md) — three ways to drive this same
server for €0, including fully-local models via Ollama / LM Studio.

## Good to know

- The server opens a **visible browser window** on purpose — you (and students) see the
  code and hear the result. Don't run it headless for a demo.
- Each agent starts its **own** copy of the server and its **own** browser window. Run
  **one agent at a time** during a demo to avoid confusion.
- The server is **experimental** software. It works, but expect occasional rough edges —
  rehearse before presenting.
