# PRD: Strudel MCP — Teaching Demo Across Agentic CLIs

> [!WARNING]
> **SUPERSEDED 2026-08-20** by
> [`2026-08-20-agent-literacy-reframe.md`](2026-08-20-agent-literacy-reframe.md).
> Kept for history. The framing here ("the subject is MCP, not music"), the three-client
> requirement, and the free-tier assumption have all been retired. The technical facts in
> §2 remain accurate.

- **Date:** 2026-07-01
- **Owner:** Simone Bonato
- **Status:** Superseded (see banner)

> **Update 2026-07-01:** The Google-vendor client changed from **Gemini CLI** to
> **Antigravity CLI** — Google replaced Gemini CLI for free/unpaid accounts on
> 2026-06-18. See R4 / §7. Claude Code and Codex are both registered and connected.

## 1. Context & Problem

This repo collects knowledge about using [Strudel](https://strudel.cc/) (a browser-based,
JavaScript port of TidalCycles for live-coding music) **and** serves as the basis for a
student session.

The session's real subject is **not music** — it is **how to connect an MCP server to
agentic coding CLIs**. Strudel is the tangible, fun, audible example that makes the
abstract MCP concept click. Students should walk away knowing how to add an MCP server to
Claude Code, Codex, and Gemini CLI.

## 2. Key Facts (verified against docs, 2026-07-01)

- Strudel makes sound **only in a browser** via the Web Audio API. There is no headless
  "audio-from-CLI" mode. Anything that produces sound must drive a browser.
- Chosen music target: **strudel.cc online** (simplest path; also works offline as a PWA
  after first load). No local clone of Strudel needed.
- Chosen MCP server: **`@williamzujkowski/live-coding-music-mcp` v4.0.0**
  (bin: `live-coding-music-mcp`). Renamed from the older `strudel-mcp-server`.
  - Drives strudel.cc via **Playwright + Chromium** (auto-installed).
  - Runs a **visible/headed** Chromium window by default — desirable for teaching, and
    required for reliable audio-context activation on some systems.
  - Node **22+** required. Machine verified: Node v22.22.2, npm 10.9.7. ✅
  - Gemini API key is **optional** (only for the `ai_assist` tool).
  - stdio transport → works with any MCP client.
  - Explicitly **experimental**: "not recommended for production," "expect rough edges."

## 3. Users

- **Primary:** Students at the session — beginners to MCP/agents.
- **Secondary:** Simone (presenter) — must run it live, reliably, across three clients.

## 4. Goals

1. Get `live-coding-music-mcp` working live in **Claude Code**, **Codex**, and
   **Gemini CLI** — same server, three clients.
2. Produce clear, reproducible **setup docs** (per client) students can follow.
3. Build a **Strudel starter knowledge base** (concepts + a few demo patterns) so the
   presenter can actually make music on demand.
4. A **rehearsal** that proves the live path end-to-end before the session.

## 5. Non-Goals

- Building our own MCP server (reuse the existing one; revisit only if it blocks us).
- Local Strudel hosting / custom sample banks (out of scope unless a need appears).
- A manual paste-in "fallback" demo — decision: demo runs through the MCP live.
  (Rehearsal is the risk mitigation, not a fallback.)

## 6. Requirements

| # | Requirement | Priority |
|---|-------------|----------|
| R1 | Install the MCP server + Chromium; verify `init` opens Strudel and plays a pattern | Must |
| R2 | Wire it into Claude Code (`claude mcp add`) and confirm tools are callable | Must |
| R3 | Wire it into Codex (`~/.codex/config.toml` / `codex mcp add`) and confirm | Must |
| R4 | Wire it into Antigravity CLI (`~/.gemini/config/mcp_config.json`) and confirm | Must |
| R5 | Per-client setup docs in the repo (copy-paste steps, screenshots optional) | Must |
| R6 | Strudel concept primer + 3–5 tested demo patterns | Should |
| R7 | Full-session rehearsal script (what to type, expected sound/behavior) | Should |
| R8 | Document known rough edges + quick recovery steps for live failures | Should |

## 7. Open Risks

- **Experimental server + live-only + three clients** = the core risk. Mitigation: R7
  rehearsal + R8 recovery notes.
- **Concurrent clients** each spawn their own server → their own Chromium window. Demo
  one client at a time.
- **Cross-client parity:** a tool that works in Claude Code should be re-verified in
  Codex/Gemini rather than assumed (different MCP client implementations).
- **API-driven audio activation:** headed browser may need a user gesture on some
  machines; verify during rehearsal on the actual demo machine.

## 8. Vertical Slices (candidate issues)

1. **Bring-up:** install server + Chromium, run `init`, play one pattern, hear sound.
2. **Claude Code integration** + doc.
3. **Codex integration** + doc.
4. **Gemini CLI integration** + doc.
5. **Knowledge base:** Strudel primer + demo patterns (tested).
6. **Rehearsal + recovery playbook.**

Each slice is done when its acceptance check passes on the actual demo machine.

## 9. Test / Verification Strategy

- **Bring-up:** manual — `init` opens Chromium at strudel.cc, a known pattern is audible.
- **Per client:** from that client, ask the agent to play a specific pattern; confirm the
  Strudel editor updates and audio plays. Stop/tempo tools verified too.
- **Knowledge base:** each demo pattern pasted into strudel.cc must run without error and
  sound as intended.
- **Rehearsal:** run the entire session flow once, on the demo machine, in each client.
