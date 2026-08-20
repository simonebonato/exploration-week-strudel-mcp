# AGENTS.md — Strudel MCP Exploration

Durable project facts. Read this first.

## What this project is

A knowledge base + working setup for an **Exploration Week workshop that teaches agent
literacy through a creative domain**, using [Strudel](https://strudel.cc/) (live-coding
music in the browser) as that domain.

**Thesis (decided 2026-08-20): you cannot direct an AI well in a domain you understand
nothing about.** So the workshop gives students *just enough* Strudel to read what the
agent writes, *just enough* music vocabulary to ask for things, and a set of ambitious
creative seeds so they know what's even possible. Then it gets out of the way.

**MCP is the mechanism, and it is taught — but it is not the subject.** MCP is what lets
you point an agent at a piece of software you barely know. That lesson is the bridge to
the week's other station (Blender), which is why it earns explicit teaching time.

- **Presenter/owner:** Simone Bonato
- **Audience:** students, beginners to LLMs/agents. Mixed backgrounds — assume no
  programming and no music-production knowledge.
- **Timeline:** Exploration Week workshop, **early September 2026**. ~2 hours.
- **Sibling station:** Blender (someone else's). Same underlying lesson, different software.
- **Format:** hands-on — students install and drive the MCP from their **own laptops
  (mixed Windows/macOS)**, with pre-work install before the day.
- **Funding (decided 2026-08-20):** free tiers proved unworkable. **FHNW provides paid
  plans.** This supersedes the earlier "nobody must pay" goal.

See the current PRD: [docs/prd/2026-08-20-agent-literacy-reframe.md](docs/prd/2026-08-20-agent-literacy-reframe.md)
(supersedes [2026-07-01](docs/prd/2026-07-01-strudel-mcp-teaching-demo.md), kept for history.)

## Session shape (decided 2026-08-20)

Front-loaded teaching, then long open exploration. The front half carries all the weight.

| Slot | Content |
| --- | --- |
| ~15–20 min | **What Strudel is.** One idea taught properly: a quoted string is a pattern that fills exactly one cycle. `"bd sd"` = half each. `"bd*4"` = quarters. `"bd ~ sd ~"` — a rest is just a slot. Then `stack()`, then one effect. Stop. Goal: they can *read* what the agent writes. |
| ~10 min | **Agent + MCP workflow, and its limits.** What MCP is and why it matters (→ Blender). The three levels of what the agent can perceive (below). |
| ~10–15 min | **Core demo, live.** "Teach me reggae AND build it with me, one instrument at a time." |
| Rest | **Open exploration** with the seed prompts. Presenter circulates. |
| Last 15 min | **Showcase** — volunteers play ~30 sec on the room speaker. Hard stop. Announced at the start so the free hour has a deadline. |

**The core demo is run live, and the agent's latency IS the teaching slot.** Send the
prompt, then talk while it works ("reggae's whole identity is the guitar landing on the
OFFbeat — listen for what's missing on beat 1"). Every step has a pre-saved pattern in
`patterns/` to paste in 5 seconds if the agent flops, so failure costs nothing visible.

## The three levels (how to teach "can the AI hear it?")

Colleagues' feedback said flatly "the LLM cannot hear the Strudel output." **That is false
for this server** and a curious student will catch it. Teach the true version:

1. **It READS your code** — perfectly.
2. **It can MEASURE the output** — via `analyze`, `audio_capture`, `query_pattern_events`.
   Is it playing? Where is the energy? Too bassy? (Proven 2026-07-01: `analyze` reported
   bass energy at ~86Hz — the kick.)
3. **It cannot JUDGE it.** No taste, no ears.

→ **You are the ears.** Feedback must be descriptive, not evaluative: "the drums feel too
busy," not "that sounds bad." This transfers directly to Blender ("it can't see your
render").

## The prompt library: three modes (decided 2026-08-20)

Students struggle more with *what to make* than with Strudel. Three memorable modes,
4–5 **ambitious** examples each — ambitious on purpose, to show the ceiling:

| Mode | Shape |
| --- | --- |
| **MAKE** | "Build me a reggae track." The one they'd find alone. |
| **TEACH ME** | "I recognise reggae but don't know what defines it — explain it, then help me build it." Also: "explain what this line does." |
| **GIVE ME OPTIONS** | "At each step, offer three changes, explain what each does musically, and wait for me to pick." |

GIVE ME OPTIONS is the genuinely transferable skill — the move from vending machine to
collaborator. It's the same three words at the Blender station.

## Saving work (decided 2026-08-20)

**The URL is the save button.** strudel.cc encodes the whole pattern into the page URL
(base64 in the hash). "Save" = copy the URL, paste it anywhere. Zero setup, identical on
both OSes, and the code *is* the music — it replays exactly.

One rule to teach: *when you like it, paste the URL somewhere before you keep editing.*
The agent can do it too ("save this version as reggae-v2"). Audio recording is an optional
appendix link, **not** workshop time — cross-platform system-audio capture is a 20-minute
tar pit.

Side effect: the same URL form preloads a pattern into a slide.

## Core technical facts (verified 2026-07-01)

- **Strudel makes sound only in a browser** (Web Audio API). No headless audio-from-CLI.
  Anything that produces sound must drive a browser.
- **Music target:** strudel.cc online. Simplest path. Works offline as a PWA after first
  load. No local Strudel clone needed. ⚠️ The app caches on first visit but **samples cache
  only when actually played** — play every sound you plan to demo while online.
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

## Install: what can and cannot be removed (researched 2026-08-20)

**Node cannot be eliminated.** Neither Claude Code nor Codex exposes a reusable JS runtime
(both are compiled binaries). Bun/Deno are unsupported by Playwright and cost more than
they save. Docker is dead on arrival — Docker Desktop runs containers in a Linux VM with
no audio passthrough on Win/macOS. A hosted/remote MCP server plays the music into the
wrong room. **The browser must run on the student's own machine; that is the load-bearing
constraint.**

**Keep the global install; do NOT register `npx`.** Measured: cold `npx` start = **12.2 s**
to first tool response, against Codex's **10 s** default `startup_timeout_sec`. Warm it's
~1.1 s and works offline (pinning `@4.0.0` avoids per-spawn registry hits), but the first
launch — student laptop, school wifi — is exactly when it fails. It also saves no download.
Plus `npx` on Windows hits [openai/codex#16229](https://github.com/openai/codex/issues/16229)
(open).

**Two free wins, now in the docs:**
1. `--no-shell` skips the headless shell: **−95 MB macOS / −115 MB Windows.** Safe only
   because we run headed — breaks if anyone sets `config.json → headless: true`.
2. Use the server's **bundled** playwright CLI, not `npx playwright`. The server depends on
   `playwright@^1.52.0` — a **floating** range — so `npx playwright` can download a
   different browser revision than the server looks for. The bundled CLI always matches,
   and avoids duplicating ~45 MB into `~/.npm/_npx`.

**Windows registration: absolute `node` + absolute `dist/index.js`.** `cmd /c` is *not* a
reliable fix (it converts "not found" into "timed out"). Both clients have open upstream
bugs spawning `.cmd` shims: Codex [#16229](https://github.com/openai/codex/issues/16229),
Claude Code [#82791](https://github.com/anthropics/claude-code/issues/82791) (updated
2026-08-19). Let the CLI write the config — hand-edited TOML mangles Windows backslashes.

**The one big remaining win (optional, ~180 MB/student):** the server hardcodes
`chromium.launch()` with no `channel`/`executablePath`, and no env var or config key
overrides it. A **one-line patch** adding `channel: process.env.STRUDEL_BROWSER_CHANNEL`
was verified end-to-end against system Chrome *and* Edge with an empty Playwright browser
directory (`init` → `edit_pattern` → `playback` → `analyze: isSilent false`). Shipping it
cleanly means publishing an AGPL fork or landing the patch upstream. **Not started —
decide by ~2026-08-25 or drop it.** (The registry-symlink hack was tested and *fails* on
macOS; don't chase it.)

⚠️ `playwright` floats at `^1.52.0`; a fresh install today resolves **1.62.1** with browser
revision **chromium-1234** (CLAUDE.md previously said 1.61.1 / 1228). Any pre-seeded
browser cache can go stale under you.

## Supported clients (narrowed 2026-08-20)

FHNW funds the plans, so students no longer arrive with "whatever free thing they had."
**Two supported clients**; the point is that the server doesn't care which.

| Client | Status | Command / config |
| --- | --- | --- |
| **Claude Code** | ✅ supported | `claude mcp add strudel live-coding-music-mcp` |
| **Codex** | ✅ supported | `codex mcp add strudel -- live-coding-music-mcp` → `~/.codex/config.toml` |
| ~~Antigravity CLI~~ | ❌ **dropped 2026-08-20** | Did not survive testing; see presenter notes. Doc archived. |
| ~~Gemini CLI~~ | ❌ dropped | Deprecated for free tier 2026-06-18. |

⚠️ On this machine `~/.codex/config.toml` is a **symlink into the dotfiles repo**
(`~/dotfiles/ai/codex/config.toml`). `codex mcp add` writes there — review before committing.

⚠️ On **Windows**, register with **absolute `node` + absolute `dist/index.js`** — not the
bare bin name, not `npx`, not `cmd /c`. See the install section above and
`docs/setup/service-setup-summary.md`.

⚠️ Each client spawns its **own** server instance → its **own** Chromium window. Run one
client at a time.

## Slide deck: Slidev (decided 2026-08-20)

`@slidev/cli` — **pin 52.19.1**, same discipline as the MCP server pin.

- **strudel.cc is framable** — no `X-Frame-Options`, no `frame-ancestors`. Verified by
  driving a headed browser and typing into the embedded editor: text accepted,
  Ctrl+Enter played, audio ran under default autoplay policy. `crossOriginIsolated` is
  false inside the frame and Strudel degrades silently — still makes sound.
- `layout: iframe-right` → half slide text, half live Strudel. The text column is your
  click-target to regain keyboard nav.
- Slidev **ships its own MCP server** (`slidev mcp slides.md`, or HTTP on `:3030/__mcp`)
  and an official agent skill: `npx skills add slidevjs/slidev` — installs for Claude Code
  *and* Codex in one command. So the deck is itself a second, quieter MCP example.
- `<Youtube id="…" />`, Mermaid, PlantUML and LaTeX are built in. `slidev build` → offline
  static SPA.

⚠️ **Three rehearsal items:**
1. **Your clicker will stop working on iframe slides.** Keyboard events don't cross into a
   cross-origin iframe — so nothing steals your typing, but you also lose slide nav while
   focus is in Strudel. Advance those slides by mouse-click.
2. Slidev's iframe layout sets no `allow=` attribute. Write a raw
   `<iframe … allow="autoplay">` for slides that must make noise.
3. **The MCP cannot drive the slide's iframe.** It drives its own Playwright Chromium
   window — a different browser context. The agent segment happens in that window, on
   every deck tool that exists. Arguably correct pedagogically (students should watch a
   real browser being driven), but choose it deliberately.

Rejected: Gamma (best AI visuals, live-embed claims unsupported by its own docs and
contradicted by its feature board), Canva (provider allow-list; Education is K-12 only),
Figma Slides (no arbitrary web embed), Tome (dead — shut down 2025-04-30), Plus AI
("live" embeds are auto-refreshing screenshots). Runner-up: Quarto revealjs.

## Machine state (this demo machine, updated 2026-08-18)

- Node v22.22.2, npm 10.9.7 — meets Node 22+ requirement.
- MCP server installed globally (v4.0.0); Chromium 1228 installed (Playwright 1.61.1).
- Claude Code: `strudel` server **connected** ✅; audio proven end-to-end (`analyze`
  confirmed sound, 2026-07-01).
- Codex 0.137.0: `strudel` registered, `enabled` ✅ (live audio not yet tested).
- Windows: **nothing verified yet** — dry-run planned before the event.

## Where things live

| Path | What | Audience |
| --- | --- | --- |
| `AGENTS.md` / `CLAUDE.md` | Durable facts (byte-identical apart from the title — keep in sync) | agents |
| `docs/student/START-HERE.md` | **The single student front door.** One page, one URL | 🎓 students |
| `docs/run-of-show.md` | **What you do on the day**, minute by minute | presenter |
| `docs/rehearsal.md` | **How to test it yourself** — 9 tests with pass criteria | presenter |
| `docs/student/pre-work-email.md` | Draft email to send ~1 week ahead | presenter |
| `docs/strudel/prompts.md` | **Prompt library** — the three modes | 🎓 students |
| `docs/strudel/primer.md` | Part 1 = the 15-min teaching arc · Part 2 = reference | presenter |
| `docs/strudel/demo-reggae.md` | **The core demo script** — prompts, what to say in each pause, fallbacks | presenter |
| `docs/strudel/demo-patterns.md` | Tested patterns, the generic build-a-beat arc | presenter |
| `slides/` | The Slidev deck (+ its rehearsal gotchas in `slides/README.md`) | presenter |
| `docs/setup/` | Per-platform, per-client setup detail · `archive/` = dropped clients | both |
| `docs/prd/` | PRDs (2026-08-20 is current; 2026-07-01 superseded) | presenter |
| `logs/` | **Presenter-only** working notes: install log, TODO, costs, meetings | presenter |

⚠️ **Privacy:** the repo is student-facing. `logs/` contains the FHNW budget discussion
and vendor failure notes. Keep those out of anything published, or move them private.

## Key decisions

1. Online strudel.cc, not a local clone. Reason: simplest path. (2026-07-01)
2. Reuse the existing MCP server, don't build our own (revisit only if it blocks us). (2026-07-01)
3. Play & control live (browser automation), not just generate code text. (2026-07-01)
4. Pin the MCP server to v4.0.0 until re-verified. (2026-08-18)
5. Hands-on format: students install (pre-work) and drive from their own mixed-OS laptops. (2026-08-18)
6. **Reframe: the subject is agent literacy through a creative domain, not MCP and not
   music.** MCP is taught as the mechanism that transfers to Blender. (2026-08-20)
   *Supersedes the old "the real subject is MCP + agents, not music."*
7. **Session shape = front-loaded teaching, then long open exploration** with ambitious
   seeds. The earlier "open-ended gets boring in 10 minutes" finding is **retracted** —
   it went flat because the seeding was thin, not because open-endedness fails. The
   mission ladder is dropped; the volunteer showcase survives. (2026-08-20)
   *Supersedes decision 6 of 2026-08-18.*
8. **FHNW pays for the plans.** Free tiers and the local-model (Ollama/Goose) safety net
   are both dropped. (2026-08-20)
9. **Two supported clients: Claude Code + Codex.** Antigravity dropped after failing
   testing. The "three vendors" hard requirement is retired. (2026-08-20)
10. **Teach the three levels of machine perception**, not the false "the LLM can't hear
    it." (2026-08-20)
11. **Prompt library = three modes: MAKE / TEACH ME / GIVE ME OPTIONS.** (2026-08-20)
12. **Saving = copy the strudel.cc URL.** Audio recording is an optional appendix, not
    workshop content. (2026-08-20)
13. **Deck = Slidev, pinned 52.19.1**, with live strudel.cc iframes. (2026-08-20)
14. **One repo, one student front door** (`docs/student/START-HERE.md`), presenter
    material clearly separated. No git knowledge assumed. (2026-08-20)
15. **Dropped: feeding audio to the LLM** (old item 16). Claude Code and Codex don't accept
    audio input. The idea survives as the "describe the sound in words" lesson. (2026-08-20)

## Conventions

- Keep durable facts here, not in chat. Update this file as facts change.
- Log progress and gotchas in `logs/`.
- PRDs in `docs/prd/<YYYY-MM-DD>-<slug>.md`.
