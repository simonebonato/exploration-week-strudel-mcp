# Rehearsal — how to test this yourself

Nine tests, in dependency order. Each has an **exact pass criterion** — if you can't state
the pass, you haven't tested it.

Legend: 🔴 blocking (workshop fails without it) · 🟡 important · ⚪ nice to have

> [!IMPORTANT]
> **Record the model AND the effort level with every result.** "It worked" is not evidence
> unless you know what it worked *on*. A pass on a big model at high effort does not
> transfer to a student on defaults.
>
> Most results so far: **Claude Sonnet, high effort, via Claude Code** (2026-08-20).
> The one exception is the important one — **test 2b passed on Sonnet at *low* effort**,
> below the default. See below.

| # | Test | Priority | Time | Status |
|---|---|---|---|---|
| 1 | Your own machine, end to end | 🔴 | 10 min | ✅ 2026-07-01 (Claude Code) |
| 2 | Codex audio parity | 🟡 | 10 min | ⬜ |
| 2b | **Student conditions: default effort** | 🔴 | 20 min | ✅ 2026-08-20 · Sonnet/**low** — passed |
| 3 | Does `analyze` do what the deck claims? | 🟡 | 15 min | ✅ 2026-08-20 · Sonnet/high — analyze passes, audio_capture broken |
| 4 | Play-test every reggae pattern | 🔴 | 30 min | ✅ 2026-08-20 · Sonnet/low — sketches **replaced** with heard patterns |
| 5 | URL round-trip (the save button) | 🔴 | 5 min | ✅ 2026-08-20 · Sonnet/high |
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

## 2b 🔴 Student conditions — default effort

Everything so far was run on **Sonnet at high effort**. Students will arrive on whatever
the default is. If the demo only works because you raised the effort, your rehearsal proved
something the room can't reproduce.

Set effort back to default (`/effort` in Claude Code), start a **fresh** session, and run
the core reggae prompt from [`strudel/demo-reggae.md`](strudel/demo-reggae.md) exactly as
written.

**Pass:** the agent still teaches-and-builds one instrument at a time, still honours *"wait
for me before continuing"*, and still produces something recognisably reggae.

**If it degrades:** you have three options, in order of preference —
1. Tell students to raise effort as part of setup (one line in `START-HERE.md`)
2. Make the prompts more explicit to compensate (`prompts.md`)
3. Ask FHNW for the tier that behaves well by default

Whichever it is, **decide before the pre-work email goes out** — it may add a setup step.

⚪ Also worth one run at default effort: two or three prompts from
[`strudel/prompts.md`](strudel/prompts.md), especially a GIVE ME OPTIONS one. "Wait for me
before continuing" is the instruction that degrades first.

### ✅ Result, 2026-08-20 · Claude Sonnet, **low** effort

The core reggae prompt ran **perfectly** — teach-and-build one instrument at a time, the
"wait for me" instruction honoured, recognisably reggae. Run at **low** effort, which is
*below* the Claude Code default, so this is a stronger pass than the test asked for: if it
works at low, a student on defaults is not on thinner ice than the rehearsal was.

**Consequence: no setup step needed.** Do *not* tell students to raise effort in
`START-HERE.md` or the pre-work email, and don't ask FHNW for a higher tier on these
grounds. The blocker on the pre-work email is cleared.

Still untested at low effort: the ⚪ item above — two or three `prompts.md` prompts,
especially a GIVE ME OPTIONS one.

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

### ✅ Result, 2026-08-20 · Claude Sonnet, high effort

`analyze` **passes, convincingly.** On a live kick it returned `average 14.2, peak 225,
peakFrequency 43Hz, bass 208, treble 7, isPlaying true`. Source inspection confirms it is
real DSP on the real audio signal (a Web Audio `AnalyserNode` tapped into Strudel's output
graph), not an inference from the pattern code. The "it can measure the output" claim is
safe to teach — and stronger than expected.

`audio_capture` **fails** — *"Audio capture not connected."* It's structurally broken in
v4.0.0: lazy injection misses the one-shot `GainNode.connect` interception. **Removed from
the wording in `AGENTS.md`/`CLAUDE.md`. Don't name it to students.**

Also don't use `analyze`'s `brightness` field — it compares an FFT-bin-index centroid
against Hz-scale thresholds, so it reports `"dark"` for essentially everything. Full
caveats in `AGENTS.md` § analyze caveats.

---

## 4 🔴 Play-test every reggae pattern

~~**Nothing in [`strudel/demo-reggae.md`](strudel/demo-reggae.md) has ever been heard.**~~
**Resolved by replacement, not by play-testing — see the result below.**

**Pass, per pattern:** it runs without error, *and* it sounds like what the script claims —
in particular:
- the drums should feel like the downbeat is **missing** (one drop)
- the chords should land clearly **between** the beats (skank)
- with the skank muted it should stop sounding like reggae

**Fix the file as you go.** Likely suspects: sample names (`rim` vs `sd`), whether the
chords need `.clip()` to sound staccato, and whether `setcpm(75/4)` feels right.

### ✅ Result, 2026-08-20 · Claude Sonnet, low effort

**Done the better way: the sketches were replaced, not fixed.** The four strudel.cc URLs
were copied out of the passing test-2b run and are now the fallback ladder in
`demo-reggae.md`. The hand-written C-minor sketches are gone. Every fallback in that file is
now code that was **generated by the agent and heard on this machine** — and the fallback
move is now *open a URL*, which is faster and unmistypeable.

The one-drop and skank claims in the script survive contact with the real output:
`s("~ ~ [bd sd] ~")` puts kick and snare together on beat 3 with slot 1 empty, and the skank
is `struct("~ x ~ x ~ x ~ x")` — every `x` on an "and". Both are readable by a student who
sat through the primer, which is the whole point.

**Two carry-overs, both in `demo-reggae.md`:**
- The agent built **bass before skank**, the opposite of the script's step order. Order isn't
  pinned by the prompt, so expect drift; the script now says so.
- The patterns have **no `setcpm`** — default tempo, faster than reggae's usual ~75 BPM. It
  read as reggae anyway. `setcpm(75/4)` is the fix if you want it, **untested**.
- ⬜ Still to do: **open each of the four URLs cold** from a fresh window to confirm they
  replay outside the session they were born in. 5 minutes. (Test 5 proved the mechanism, so
  this is a spot-check, not a real risk.)

> ⚠️ For future runs: nothing is persisted automatically. `pattern_store` only writes when
> explicitly asked, and `patterns/` is gitignored. **Copy the URL during the run or the
> patterns are gone.**

⚪ Also worth doing: patterns 3, 4 and 5 in [`strudel/demo-patterns.md`](strudel/demo-patterns.md)
have never been heard either — only #2 was.

---

## 5 🔴 URL round-trip (the save button)

You tell students in three places that copying the URL saves their work. Prove it.

1. Build something in strudel.cc, play it
2. Copy the URL
3. Open a **private/incognito window**, paste, load

**Pass:** the same code appears and plays the same thing.

### ✅ Result, 2026-08-20 · Claude Sonnet, high effort

**Passed.** The save-your-work rule in `START-HERE.md`, `prompts.md` and the deck is sound.

---

## 6 🟡 Every prompt against a live agent

Run each prompt in [`strudel/prompts.md`](strudel/prompts.md) once. You're not looking for
perfection — you're looking for prompts that **reliably produce something interesting**.

**Pass, per prompt:** the agent does roughly what the prompt implies, in under ~3 turns.
**Record the model and effort** you ran them on — and ideally spot-check the weakest ones at
default effort too (see test 2b).
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

- [ ] **Turn wifi off.** Deck still works? (The Strudel iframe *and* the slides 8–11 pads
      won't — that's expected and confirmed; check nothing else breaks)
- [ ] Wifi on: **play every sound in the demo** so samples cache
- [ ] On slide 6, click into the Strudel iframe and type. Does it accept text and play?
- [ ] Now try to advance with your **clicker**. It will not work *on that slide*. Practise
      the recovery: click the text column, then arrow keys
- [ ] Press `p` for presenter view — are the speaker notes there?
- [ ] Practise the switch from deck → agent window → back for the reggae demo

**The live pads on slides 8–11** (added 2026-08-20 — see [`../slides/README.md`](../slides/README.md)):

- [ ] **Open all four pads and play a chip on each, on wifi**, on the machine and browser
      profile you'll present from. They fetch samples from GitHub on first play and have
      **no** offline cache — verified: blocked network = nothing happens at all
- [ ] **Play-test every chip** in `slides/components/strudelPresets.js`. 16 snippets, and
      they are played live in front of the room. The `.room()` / `.lpf()` ones on slide 11
      are the least certain
- [ ] Open a pad **before** you need it — the first one loads the whole Strudel engine
- [ ] Slide 11: click `hats too loud` then `.gain(0.4)` back to back. That contrast **is**
      the slide — if it doesn't land audibly, fix the gain values
- [ ] Type into a pad on stage at least once (slide 8's speaker note asks you to). Confirm
      the deck does **not** jump slides or flip dark mode while you type

**Pass:** you can get through the whole deck — the iframe slide and all four pads — without
fumbling navigation, and every chip makes the sound the slide claims.

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
