# Strudel Primer (just enough to teach with)

Strudel is live-coding music in the browser. You write a little JavaScript-ish code, press
a key, and it loops immediately. For our demo, **the agent writes this code via the MCP
server** — but you should understand it so you can narrate what's happening.

Play it yourself at <https://strudel.cc>. In the REPL:
- **Ctrl/Cmd + Enter** = play / update the pattern
- **Ctrl/Cmd + .** = stop

## The one core idea: patterns in "mini-notation"

Anything in quotes is a **pattern** that fills one cycle (one loop). Space-separated items
share the cycle equally.

| Mini-notation | Meaning |
|---|---|
| `"bd sd"` | kick, then snare — each takes half a cycle |
| `"bd*4"` | kick four times (four-on-the-floor) |
| `"bd ~ sd ~"` | `~` is a rest (silence) |
| `"[bd sd] hh"` | group `[..]` fits into one slot |
| `"<bd sd>"` | alternate: `bd` on cycle 1, `sd` on cycle 2 |
| `"bd(3,8)"` | Euclidean: 3 hits spread over 8 steps (a classic groove) |

## Two ways to make sound

```js
sound("bd sd hh")   // named samples: bd=kick, sd=snare, hh=hihat, cp=clap...
note("c e g")       // pitched notes (also c4, eb3, etc.)
```
`s(...)` is short for `sound(...)`, `n(...)` is a numeric index. You can pick a synth voice
with `.sound("sawtooth")` (also `triangle`, `square`, `sine`).

## Stacking layers

`stack(...)` plays multiple patterns at once — this is how you build a track:

```js
stack(
  sound("bd*4"),        // kick
  sound("~ sd ~ sd"),   // snare on 2 and 4
  sound("hh*8")         // hats
)
```

## Shaping the sound (a few high-value knobs)

| Method | Effect |
|---|---|
| `.gain(0.4)` | volume (0–1-ish) |
| `.lpf(600)` | low-pass filter cutoff in Hz (darker as it drops) |
| `.room(0.3)` | reverb |
| `.delay(0.4)` | echo |
| `.slow(2)` / `.fast(2)` | stretch / compress time |

## Signals (movement without effort)

`sine`, `saw`, `square`, `tri`, `rand` are continuous signals. `.range(min,max)` maps them.
Great for filter sweeps and evolving volume:

```js
sound("hh*16").gain(saw.range(0.2, 0.6))          // hats swell each cycle
note("c2").lpf(sine.range(300, 1200).slow(4))     // slow filter sweep
```

## Scales (melody without knowing theory)

```js
n("0 2 4 6 4 2").scale("C:minor").sound("triangle")
```
`n(...)` picks scale **degrees** (0 = root), `.scale("C:minor")` maps them to notes. Change
`"C:minor"` to `"E:major"`, `"D:dorian"`, etc.

> [!WARNING]
> Gotcha we hit: the MCP's **local** validator (`validate_pattern_local`) doesn't
> implement `.scale()` and will wrongly report an error. The **real** strudel.cc runtime
> supports it fine — verify scale/advanced patterns with `validate_pattern_runtime` or by
> just playing them. See `logs/install-log.md`.

## Tempo

Default is 120 BPM-ish. Set it with `setcpm(130)` at the top in the REPL, or via the MCP
`set_tempo` tool. (`cpm` = cycles per minute; one cycle ≈ one bar.)

## How this maps to the MCP demo

When you ask the agent "add a hi-hat," it calls `edit_pattern` to rewrite this code and
`playback` to loop it. The concepts above are exactly what the agent is manipulating — so
the students see *code they could have typed themselves* being written by the agent.

Tested, ready-to-play examples: [demo-patterns.md](./demo-patterns.md).
Real-world tracks, tutorials & sample banks:
[awesome-strudel](https://github.com/terryds/awesome-strudel).
