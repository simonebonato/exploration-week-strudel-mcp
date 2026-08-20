# TODO — running task log

Status legend: [ ] todo · [~] in progress · [x] done · [!] blocked · [–] dropped

> **Restructured 2026-08-20** after the reframe grill. Slices below are the *new* plan;
> completed bring-up work is compressed into "Done already". See
> `docs/prd/2026-08-20-agent-literacy-reframe.md`.

## Done already (bring-up, 2026-07-01 → 08-18)

- [x] Node 22+ verified (v22.22.2); server v4.0.0 + Chromium 1228 installed
- [x] Audio proven end-to-end via Claude Code — `analyze` confirmed bass energy at ~86Hz
- [x] Claude Code registered + connected; Codex registered + enabled
- [x] Strudel primer + 5 demo patterns (`docs/strudel/`)
- [x] Per-client setup docs drafted (`docs/setup/`)

## Slice A — Windows dry-run  ← **highest priority, gates everything**
- [ ] On a real Windows machine, from zero: Node → server@4.0.0 → Chromium → sound
- [ ] Both clients: Claude Code **and** Codex
- [ ] Confirm or correct the `cmd /c live-coding-music-mcp` note in
      `docs/setup/service-setup-summary.md`
- [ ] Record every failure into `docs/setup/recovery-playbook.md` as it happens

## Slice B — Student front door
- [x] `docs/student/START-HERE.md` — ONE page: install → register → verify → first prompts
      → seed ideas → "nothing works?" box. No git knowledge assumed.
- [ ] Decide the short URL students get told/emailed
- [x] Pre-work email draft → `docs/student/pre-work-email.md` (needs the live URL + the
      confirmed agent name before sending)
- [ ] Move or privatise `logs/` before anything is published — it contains the FHNW budget
      discussion and vendor failure notes
- [x] Archived antigravity-cli / gemini-cli / free-and-local-options → `docs/setup/archive/`

## Slice C — Teaching content
- [x] Strudel intro rebuilt on ONE idea (the cycle) — `docs/strudel/primer.md` is now
      Part 1 (the 15-min arc, what you teach) + Part 2 (reference, what you don't)
- [x] Prompt library written: `docs/strudel/prompts.md` — three modes, ambitious examples
      - [ ] **Run every prompt at least once against a real agent before shipping it**
- [x] "Three levels of machine perception" segment — in prompts.md, START-HERE.md, the
      deck, and as demo step 6
- [x] Save-your-work rule documented everywhere
- [ ] **Verify the URL hash actually round-trips** (copy a playing pattern's URL, open it
      in a clean browser profile, confirm it replays)
- [x] Strudel interactive tutorial + docs linked from START-HERE.md
- [ ] Find + add a live-coding YouTube video (someone competent, actually performing)
- [ ] Optional appendix: how to record system audio (OBS, both OSes) — NOT workshop time

## Slice D — Core demo (reggae, live)
- [x] Exact prompt sequence written → `docs/strudel/demo-reggae.md`
- [x] Fallback pattern written for each step (in demo-reggae.md; `patterns/` is gitignored)
- [ ] **Play-test every fallback pattern — none has been heard yet**
- [x] Scripted what you SAY during each agent pause (latency = the teaching slot)
- [ ] Rehearse end-to-end on the demo machine

## Slice E — Slidev deck
- [x] Scaffolded `slides/` (slides.md + package.json pinned to 52.19.1 + README)
- [ ] `cd slides && npm install`
- [ ] `npx skills add slidevjs/slidev` (installs for Claude Code + Codex)
- [x] Live strudel.cc iframe slides in the deck (using `layout: iframe-right`)
- [ ] Swap to a raw `<iframe … allow="autoplay">` on the slides that must make noise
- [ ] Rehearse: mouse-click to advance on iframe slides (the clicker will not work there)
- [ ] `slidev build` → offline check with wifi off
- [ ] Warm the Strudel sample cache online: play every sound you plan to demo

## Slice F — Verify + de-risk
- [ ] Play a pattern from **Codex** end-to-end (only Claude Code has proven audio)
- [ ] Verify what `analyze` and `audio_capture` actually return — the "three levels"
      segment claims capabilities that need re-checking before you teach them
- [x] Investigated non-Node / smaller install (2026-08-20). Findings in AGENTS.md:
      Node is unavoidable · keep the global install (npx breaks Codex's 10s timeout) ·
      `--no-shell` and the bundled playwright CLI are free wins, now in the docs ·
      Windows needs the absolute-`node` form, NOT `cmd /c`
- [ ] **Decide by ~2026-08-25:** publish an AGPL fork with a one-line `channel:` patch to
      drop the ~180 MB Chromium download per student? Mechanism verified working against
      system Chrome and Edge. Otherwise drop the idea.
- [ ] Re-verify playwright/browser revision before the day — `^1.52.0` floats (today:
      1.62.1 / chromium-1234, was 1.61.1 / 1228)
- [ ] Room logistics: speaker for the showcase, headphones rule, wifi allows npm +
      Playwright download + strudel.cc

## Dropped (2026-08-20)
- [–] Antigravity CLI leg — did not survive testing
- [–] Local models (Ollama + Goose/ollmcp) — FHNW funds the plans; the free path is moot
- [–] Free-tier research as a supported path (`docs/setup/free-and-local-options.md` →
      keep as reference, not a supported route)
- [–] Mission ladder — replaced by ambitious seeds + a volunteer showcase
- [–] Feeding audio to the LLM — supported clients don't accept audio input

## Open questions
- [ ] Which machine hosts the presenter demo? (verify audio activation there)
- [ ] Which plan does FHNW actually buy, and by when? Gates the pre-work email.
- [ ] Do we want `ai_assist` (needs a Gemini API key)? Probably not now — optional.
