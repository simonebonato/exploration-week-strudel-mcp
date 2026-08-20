# Rehearsal — how to test this yourself

Nine tests, in dependency order. Each has an **exact pass criterion** — if you can't state
the pass, you haven't tested it.

Legend: 🔴 blocking (workshop fails without it) · 🟡 important · ⚪ nice to have

| # | Test | Priority | Time | Status |
|---|---|---|---|---|
| 1 | Your own machine, end to end | 🔴 | 10 min | ✅ done 2026-07-01 (Claude Code only) |
| 2 | Codex audio parity | 🟡 | 10 min | ⬜ |
| 3 | Does `analyze` do what the deck claims? | 🟡 | 15 min | ⬜ |
| 4 | Play-test every reggae pattern | 🔴 | 30 min | ⬜ |
| 5 | URL round-trip (the save button) | 🔴 | 5 min | ⬜ |
| 6 | Every prompt against a live agent | 🟡 | 60 min | ⬜ |
| 7 | **Windows dry-run** | 🔴 | 90 min | ⬜ |
| 8 | Deck rehearsal | 🔴 | 30 min | ⬜ |
| 9 | Full timed dress rehearsal | 🔴 | 2 h | ⬜ |

---

## 1 🔴 Your own machine, end to end

```bash
node -v                                   # v22+
which live-coding-music-mcp               # resolves
claude mcp list                           # strudel ... ✔ Connected
```

Fresh session → *"Initialize Strudel and play a four-on-the-floor kick."*

**Pass:** a Chromium window opens by itself, and you **hear** a kick.

---

## 2 🟡 Codex audio parity

Only Claude Code has proven audio. Codex is registered but never heard.

```bash
codex mcp list        # strudel ... enabled
```

Fresh Codex session → *"Initialize Strudel and play a four-on-the-floor kick."*

**Pass:** you hear it from Codex too.
**If it fails:** you're down to one supported client — update the docs and the pre-work
email before they go out.

---

## 3 🟡 Does `analyze` do what the deck claims?

The deck, `prompts.md` and `START-HERE.md` all tell students the agent can **measure** the
sound. That's based on one `analyze` result from 2026-07-01. `audio_capture` has never been
run at all. **Don't teach a capability you haven't seen.**

With something playing, ask the agent:

> Call `analyze` and show me the raw result. Then call `audio_capture` and show me what it
> returns.

**Pass:** `analyze` returns something recognisably about the sound (playing/silent,
loudness, frequency energy) — enough to honestly say "it can measure it."
**If `audio_capture` is broken or returns nothing useful:** remove it from the wording in
`AGENTS.md` and the deck. Say "it can measure the sound" and only name the tool that works.

---

## 4 🔴 Play-test every reggae pattern

**Nothing in [`strudel/demo-reggae.md`](strudel/demo-reggae.md) has ever been heard.** Paste
each of the five code blocks into strudel.cc and listen.

**Pass, per pattern:** it runs without error, *and* it sounds like what the script claims —
in particular:
- the drums should feel like the downbeat is **missing** (one drop)
- the chords should land clearly **between** the beats (skank)
- with the skank muted it should stop sounding like reggae

**Fix the file as you go.** Likely suspects: sample names (`rim` vs `sd`), whether the
chords need `.clip()` to sound staccato, and whether `setcpm(75/4)` feels right.

⚪ Also worth doing: patterns 3, 4 and 5 in [`strudel/demo-patterns.md`](strudel/demo-patterns.md)
have never been heard either — only #2 was.

---

## 5 🔴 URL round-trip (the save button)

You tell students in three places that copying the URL saves their work. Prove it.

1. Build something in strudel.cc, play it
2. Copy the URL
3. Open a **private/incognito window**, paste, load

**Pass:** the same code appears and plays the same thing.
**If it fails:** the entire save-your-work story collapses and needs replacing before the
pre-work email goes out.

---

## 6 🟡 Every prompt against a live agent

Run each prompt in [`strudel/prompts.md`](strudel/prompts.md) once. You're not looking for
perfection — you're looking for prompts that **reliably produce something interesting**.

**Pass, per prompt:** the agent does roughly what the prompt implies, in under ~3 turns.
**Delete or rewrite anything that flops.** A prompt that fails in front of a beginner
teaches them the tool doesn't work.

Pay special attention to the GIVE ME OPTIONS ones — "wait for me before continuing" is the
instruction agents most often ignore. If it barrels ahead, reword until it doesn't.

---

## 7 🔴 Windows dry-run — **the highest-priority item**

Nothing on Windows has ever been verified. Borrow a machine. Use a **clean** user account
or a fresh npm prefix, so you're testing the student experience and not your own.

Follow [`student/START-HERE.md`](student/START-HERE.md) **literally**, exactly as written,
without using anything you know. That's the test.

```powershell
node -v
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0
node "$(npm root -g)\@williamzujkowski\live-coding-music-mcp\node_modules\playwright\cli.js" install chromium --no-shell
npm root -g
claude mcp add strudel -- node "C:\...\@williamzujkowski\live-coding-music-mcp\dist\index.js"
claude mcp list
```

Then the same for Codex.

**Pass:** both clients connect, Chromium opens, and sound is **audible** — not merely
`isSilent: false`.

Check specifically:
- [ ] Does the bare-name registration fail as predicted? (If it works, simplify the docs!)
- [ ] Does the absolute-`node` form work?
- [ ] Codex `startup_timeout_sec` — does the default 10 s suffice, or is 60 needed?
- [ ] Any VC++ redistributable prompt when Chromium launches?
- [ ] **Time the whole thing.** That number sets your straggler-fix budget.

**Write every failure into [`setup/recovery-playbook.md`](setup/recovery-playbook.md) as it
happens** — not afterwards from memory.

---

## 8 🔴 Deck rehearsal

```bash
cd slides && npm run build          # then open slides/dist/index.html
```

Present from the **built** deck, not the dev server.

- [ ] **Turn wifi off.** Deck still works? (The Strudel iframes won't — that's expected and
      fine; check nothing else breaks)
- [ ] Wifi on: **play every sound in the demo** so samples cache
- [ ] On slide 5, click into the Strudel iframe and type. Does it accept text and play?
- [ ] Now try to advance with your **clicker**. It will not work. Practise the recovery:
      click the text column, then arrow keys
- [ ] Press `p` for presenter view — are the speaker notes there?
- [ ] Practise the switch from deck → agent window → back for the reggae demo

**Pass:** you can get through the whole deck, including both live-Strudel slides, without
fumbling navigation.

---

## 9 🔴 Full timed dress rehearsal

Run the entire [`run-of-show.md`](run-of-show.md) alone, out loud, with a timer. Yes, out
loud — silent read-throughs hide every pacing problem.

**Pass:** you finish inside 2 hours **and** the teaching segments fit their slots. The
usual failure is the Strudel intro running to 30 minutes.

Note actual timings. If the intro overruns, cut from Part 1 step 3 (`stack()`), not from
the demo.

---

## The gating question before you send the pre-work email

> **Can a person who is not me, on a machine that is not mine, following only
> `START-HERE.md`, get to audible sound?**

Until test 7 answers yes, the email doesn't go out.
