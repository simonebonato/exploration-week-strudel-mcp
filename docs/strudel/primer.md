# Strudel Primer — the teaching arc

Two parts, deliberately separated:

1. **[The 15-minute arc](#part-1--the-15-minute-arc)** — what you actually teach. *One
   idea*, landed properly.
2. **[Reference](#part-2--reference)** — everything else, for you, and for students who
   want more. **Do not teach this part.** It's a lookup table, not a lesson.

> [!IMPORTANT]
> The goal of the intro is **not** that students can write Strudel. It's that they can
> **read** what the agent writes. That's the prerequisite for directing it — and it's the
> whole thesis of the session: you can't direct an AI well in a domain you understand
> nothing about.

---

# Part 1 — The 15-minute arc

## Step 0: make a noise before you explain anything (1 min)

Open <https://strudel.cc>, type this, hit **Ctrl/Cmd+Enter**:

```js
sound("bd*4")
```

Then **Ctrl/Cmd+.** to stop. That's the whole interface: type, Ctrl+Enter to play,
Ctrl+. to stop. Nothing else needs explaining yet.

## Step 1: the one idea — a cycle (5 min)

> **Anything in quotes is a pattern that fills exactly one loop. Whatever you put in it
> splits that loop evenly.**

This is the entire lesson. Build it up live, one line at a time, playing each:

```js
sound("bd")           // one kick, filling the whole loop
sound("bd sd")        // kick then snare — half the loop each
sound("bd sd hh cp")  // four things — a quarter each
sound("bd*4")         // shorthand: kick, four times
sound("bd ~ sd ~")    // ~ is a rest. Silence takes a slot too.
```

**The move that makes it click:** ask the room *"what happens if I add one more thing?"*
before you do it. `"bd sd hh"` — everything gets faster, because three things still have
to fit in the same loop. That's the whole model. Nothing is "a beat"; everything is a
share of one loop.

Two more, if the room is with you:

```js
sound("[bd sd] hh")   // brackets = a group squeezed into one slot
sound("bd(3,8)")      // 3 hits spread over 8 slots — an instant groove
```

Don't explain Euclidean rhythms. Just play it and say *"that's three hits spread as evenly
as possible over eight slots — it's how half of all dance music is built."*

## Step 2: layers (3 min)

> **`stack()` plays patterns at the same time. That's how a track is built.**

```js
stack(
  sound("bd*4"),        // kick
  sound("~ sd ~ sd"),   // snare on 2 and 4
  sound("hh*8")         // hats
)
```

Add one line at a time, playing after each. Three lines and it sounds like actual music —
that's the moment the room leans in.

## Step 3: one knob (2 min)

> **A `.something()` on the end changes how it sounds.**

Teach exactly one, and `.gain()` is the right one because the fix is audible and obvious:

```js
stack(
  sound("bd*4"),
  sound("~ sd ~ sd"),
  sound("hh*8").gain(0.4)   // ← hats were too loud
)
```

Then mention — don't demonstrate — that there are dozens: `.room()` for reverb, `.lpf()`
to make it darker, `.delay()` for echo. **And that they never need to memorise any of them,
because they can ask.**

## Step 4: hand it over (2 min)

> *"That's everything I'm going to teach you about Strudel. From here you ask the agent —
> including asking it to teach you."*

Live, in front of them:

> "Explain what `sound("hh*8").gain(0.4)` does, line by line."

> "How do I add reverb?"

That transition **is** the lesson. You've just modelled the behaviour you want for the next
90 minutes.

## What you did NOT teach, on purpose

`note()`, scales, signals, `<>` alternation, tempo, samples, every effect. All of it is in
Part 2 and all of it is one question away. Teaching it costs 20 minutes and buys nothing —
they can't retain it, and they don't need to.

---

# Part 2 — Reference

Lookup material. For you, and for students who go digging.

## Mini-notation

| Notation | Meaning |
|---|---|
| `"bd sd"` | kick, then snare — half a cycle each |
| `"bd*4"` | kick four times |
| `"bd ~ sd ~"` | `~` is a rest (silence) |
| `"[bd sd] hh"` | group `[..]` fits into one slot |
| `"<bd sd>"` | alternate: `bd` on cycle 1, `sd` on cycle 2 |
| `"bd(3,8)"` | Euclidean: 3 hits spread over 8 steps |
| `"[bd,hh*4]"` | comma = at the same time (a chord, or parallel drums) |

## Two ways to make sound

```js
sound("bd sd hh")   // named samples: bd=kick, sd=snare, hh=hihat, cp=clap...
note("c e g")       // pitched notes (also c4, eb3, etc.)
```

`s(...)` is short for `sound(...)`, `n(...)` is a numeric index. Pick a synth voice with
`.sound("sawtooth")` (also `triangle`, `square`, `sine`).

## Shaping knobs

| Method | Effect |
|---|---|
| `.gain(0.4)` | volume (0–1-ish) |
| `.lpf(600)` | low-pass filter cutoff in Hz (darker as it drops) |
| `.room(0.3)` | reverb |
| `.delay(0.4)` | echo |
| `.slow(2)` / `.fast(2)` | stretch / compress time |
| `.pan(0.2)` | left/right placement |

## Signals (movement without effort)

`sine`, `saw`, `square`, `tri`, `rand` are continuous signals. `.range(min,max)` maps them.

```js
sound("hh*16").gain(saw.range(0.2, 0.6))          // hats swell each cycle
note("c2").lpf(sine.range(300, 1200).slow(4))     // slow filter sweep
```

## Scales (melody without theory)

```js
n("0 2 4 6 4 2").scale("C:minor").sound("triangle")
```

`n(...)` picks scale **degrees** (0 = root); `.scale()` maps them to notes. Swap in
`"E:major"`, `"D:dorian"`, etc.

> [!WARNING]
> The MCP's **local** validator (`validate_pattern_local`) doesn't implement `.scale()` and
> will wrongly report an error. The real strudel.cc runtime handles it fine — verify with
> `validate_pattern_runtime` or by just playing it. See `logs/install-log.md`.

## Tempo

`setcpm(n)` at the top — **c**ycles **p**er **m**inute, where one cycle ≈ one bar. So for a
BPM in 4/4, divide by 4:

```js
setcpm(130/4)   // ~130 BPM techno
setcpm(75/4)    // ~75 BPM reggae
```

Or use the MCP `set_tempo` tool.

## How this maps to the MCP

When a student says *"add a hi-hat,"* the agent calls `edit_pattern` to rewrite this code
and `playback` to loop it. Everything above is exactly what the agent manipulates — which
is why students seeing *code they could have typed themselves* is the point, not a
side effect.

---

## Next

- Tested patterns to play or fall back to: **[demo-patterns.md](./demo-patterns.md)**
- The live reggae demo, step by step: **[demo-reggae.md](./demo-reggae.md)**
- Prompts to hand students: **[prompts.md](./prompts.md)**
- Real tracks with source: [awesome-strudel](https://github.com/terryds/awesome-strudel)
