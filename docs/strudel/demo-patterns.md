# Demo Patterns (tested)

> [!NOTE]
> This is the **generic** build-a-beat arc, useful as a warm-up or a rescue. The session's
> actual centrepiece is the reggae teach-and-build demo:
> **[demo-reggae.md](./demo-reggae.md)**.

A 5-step arc that builds a track from one kick to a full groove. Each step is a small,
narratable change — perfect for "watch the agent add one layer at a time."

```mermaid
flowchart LR
    P1["1️⃣ kick"] --> P2["2️⃣ + snare/hats"] --> P3["3️⃣ + bassline"] --> P4["4️⃣ + melody"] --> P5["5️⃣ full groove"]
```

> [!NOTE]
> **Validation key:** ✅local = passed `validate_pattern_local` · ✅runtime = passed
> `validate_pattern_runtime` (real strudel.cc) · 🔊played = actually played and confirmed
> audible via `analyze` (2026-07-01).

Paste any of these into <https://strudel.cc> (Ctrl/Cmd+Enter to play, Ctrl/Cmd+. to stop),
or ask the agent for them by description.

---

## 1 — One kick (the "hello world")  ✅local
```js
sound("bd*4")
```
Talking point: four-on-the-floor. The whole quoted string is one looping cycle.

## 2 — A basic beat  ✅local 🔊played
```js
stack(
  sound("bd*4"),
  sound("~ sd ~ sd"),
  sound("hh*8").gain(0.4)
)
```
Talking point: `stack` = layers at once. Snare on 2 & 4, quieter hats. This is the one we
confirmed makes real sound through the MCP chain.

## 3 — Add a bassline  ✅local
```js
stack(
  sound("bd*4"),
  sound("~ sd ~ sd"),
  sound("hh*8").gain(0.4),
  note("c2 ~ c2 g1").sound("sawtooth").lpf(600)
)
```
Talking point: `note()` for pitch, `.sound("sawtooth")` for a synth voice, `.lpf(600)` to
tame the brightness.

## 4 — A melodic line with a scale  ✅runtime
```js
stack(
  sound("bd*4"),
  sound("hh*8").gain(0.4),
  n("0 2 4 6 4 2").scale("C:minor").sound("triangle").delay(0.4).room(0.3)
)
```
Talking point: scale degrees + `.scale()` = melody without music theory. Add `.delay`/`.room`
for space.
> Note: fails the *local* validator (no `.scale`), works on real strudel.cc. See primer.

**Explicit-notes fallback** (if you want something that also passes local validation) ✅local:
```js
stack(
  sound("bd*4"),
  sound("hh*8").gain(0.4),
  note("c4 eb4 g4 bb4 g4 eb4").sound("triangle").delay(0.4).room(0.3)
)
```

## 5 — Full groove (the "wow")  ✅local
```js
stack(
  sound("bd(3,8)"),
  sound("~ cp").room(0.2),
  sound("hh*16").gain(saw.range(0.2, 0.6)),
  note("<c2 eb2 g1 f2>").sound("sawtooth").lpf(sine.range(300, 1200).slow(4))
)
```
Talking point: Euclidean kick `bd(3,8)`, a clap with reverb, hats that swell (`saw.range`),
and a bass whose filter slowly opens (`sine.range(...).slow(4)`). Try `setcpm(130)` on top.

---

## Suggested live script (the story)

1. "Initialize Strudel." → browser opens.
2. "Play a four-on-the-floor kick." → pattern 1.
3. "Add a snare on 2 and 4, and some hi-hats." → pattern 2. *(now it grooves)*
4. "Add a sawtooth bassline." → pattern 3.
5. "Give me a minor-key melody with some reverb." → pattern 4.
6. "Make it a full techno groove and set the tempo to 130." → pattern 5.
7. "Stop." → silence. Take a bow.

Each step is one sentence to the agent → one audible change. That *is* the MCP lesson.

---

## Inspiration: what real artists do with Strudel

> [!TIP]
> **[awesome-strudel](https://github.com/terryds/awesome-strudel)** — a curated collection
> of real Strudel tracks (covers of Grimes, Radiohead, New Order, ...), tools, tutorials,
> and sample banks. Great for students: open a track, hear it, read its code, steal ideas.
> Also a good source of snippets to hand the agent as a starting point ("make something
> like this").

---

## Bonus: the three-moods trio (tested 2026-08-21) 🔊played

Produced by the ⭐ MAKE prompt *"three versions of the same track, three moods — hopeful,
anxious, exhausted. Same tempo, same key."* Rated the best prompt in the library.

**Use it as the payoff for the "what makes a track sound sad?" teaching prompt.** Tempo and
key are held fixed across all three, so everything you hear differing is the *other* levers:
kick density, filter cutoff, note length (`.clip()`), reverb, and how much silence is left.

| Mood | Open |
| --- | --- |
| 🙂 hopeful | [play](https://strudel.cc/#c3RhY2soCiAgcygiYmQgfiB%2BIGJkIH4gfiBzZCB%2BIikuZ2FpbigwLjg1KSwKICBzKCJoaCo4IikuZ2FpbigwLjMpLAogIG5vdGUoIjxjMyBmMyBnMyBjMz4iKS5zKCJzYXd0b290aCIpLmxwZig3MDApLmdhaW4oMC44KSwKICBub3RlKCI8W2M0LGU0LGc0XSBbZjQsYTQsYzVdIFtnNCxiNCxkNV0gW2M0LGU0LGc0XT4iKQogICAgLnMoImdtX2VwaWFubzEiKS5jbGlwKDEuMikuZ2FpbigwLjUpLnJvb20oMC40KSwKICBub3RlKCI8ZTUgZzUgYzYgZTU%2BIikucygic2luZSIpLmNsaXAoMC44KS5nYWluKDAuMykucm9vbSgwLjUpCikK) |
| 😰 anxious | [play](https://strudel.cc/#c3RhY2soCiAgcygiYmQgfiBiZCB%2BIHNkIGJkIH4gc2QiKS5nYWluKDAuOSksCiAgcygiaGgqMTYiKS5nYWluKDAuMjUpLnNvbWV0aW1lc0J5KDAuNCwgeCA9PiB4LnNwZWVkKDEuNSkpLAogIG5vdGUoIjxjMyBkYjMgZzMgYzM%2BIikucygic2F3dG9vdGgiKS5scGYoNDAwKS5nYWluKDAuODUpLmRpc3RvcnQoMC4yKSwKICBub3RlKCI8W2M0LGViNCxnYjRdIFtkYjQsZjQsYWI0XSBbZzQsYmI0LGRiNV0gW2M0LGViNCxnYjRdPiIpCiAgICAucygiZ21fZXBpYW5vMSIpLmNsaXAoIjwwLjE1IDAuMjUgMC4xNSAwLjM%2BIikuZ2FpbigwLjUpLmZhc3QoMiksCiAgbm90ZSgifiB%2BIFtjNiBkYjZdIH4gfiBlYjYgfiBbZ2I1IGRiNl0iKS5zKCJzaW5lIikuY2xpcCgwLjE1KS5nYWluKDAuMykKKQ%3D%3D) |
| 😮‍💨 exhausted | [play](https://strudel.cc/#c3RhY2soCiAgcygiYmQgfiB%2BIH4gfiB%2BIHNkIH4iKS5nYWluKDAuNiksCiAgcygiaGggfiB%2BIGhoIH4gfiB%2BIH4iKS5nYWluKDAuMiksCiAgbm90ZSgiPGMyIH4gfiBmMj4iKS5zKCJzYXd0b290aCIpLmxwZigyNTApLmdhaW4oMC42KS5yZWxlYXNlKDAuNCksCiAgbm90ZSgiPFtjNCxlNCxnNF0gfiB%2BIFtmNCxhNCxjNV0%2BIikKICAgIC5zKCJnbV9lcGlhbm8xIikuY2xpcCgiPDIgMC4zIDEuNSAwLjQ%2BIikuZ2FpbigwLjM1KS5scGYoNjAwKS5yb29tKDAuNikKKQ%3D%3D) |

Talking point: play *exhausted* straight after *anxious*. Same notes underneath — the drums
thin out, the filter closes, the chords get long. That contrast is the whole "what makes it
sad" lesson in about fifteen seconds.

## Bonus: a sectioned arrangement (tested 2026-08-21) 🔊played

Where a long GIVE ME OPTIONS session ended up — trip-hop with a real
verse → chorus → breakdown contour built on `arrange()`, not a single loop:

**[play](https://strudel.cc/#YXJyYW5nZSgKICBbOCwgc3RhY2soCiAgICBub3RlKCJjNCBlYjQgZzQgZWI0Iikuc2xvdygyKS5zKCJwaWFubyIpLnJvb20oMC40KS5zaXplKDQpLmdhaW4oMC44KSwKICAgIG5vdGUoIn4gZzQgfiB%2BIGViNCB%2BIGM0IH4iKS5zKCJwaWFubyIpLmNsaXAoMC4zKS5nYWluKDAuNSkucm9vbSgwLjMpLAogICAgbm90ZSgiYzIgfiB%2BIGMyIH4gfiB%2BIH4iKS5zKCJzYXd0b290aCIpLmxwZigyMDApLmdhaW4oMC44KS5yb29tKDAuMikuY2xpcCgwLjQpLmF0dGFjaygwLjAxKSwKICAgIHMoImJkIH4gfiBiZCB%2BIH4gfiB%2BIikuYmFuaygidHI5MDkiKS5kaXN0b3J0KDAuMykuZ2FpbigwLjk1KSwKICAgIHMoIn4gfiB%2BIH4gY3AgfiB%2BIH4iKS5iYW5rKCJ0cjkwOSIpLmdhaW4oMC43KS5yb29tKDEpLAogICAgcygiaGgqOCIpLmJhbmsoInRyOTA5IikuZ2FpbigwLjE1KS5scGYoMjAwMCkKICApXSwKICBbOCwgc3RhY2soCiAgICBub3RlKCJjNCBlYjQgZzQgZWI0Iikuc2xvdygyKS5zKCJwaWFubyIpLnJvb20oMC40KS5zaXplKDQpLmdhaW4oMC44KSwKICAgIG5vdGUoIn4gZzQgfiB%2BIGViNCB%2BIGM0IH4iKS5zKCJwaWFubyIpLmNsaXAoMC4zKS5nYWluKDAuNikucm9vbSgwLjMpLAogICAgbm90ZSgiYzIgfiB%2BIGMyIH4gfiB%2BIH4iKS5zKCJzYXd0b290aCIpLmxwZigyMDApLmdhaW4oMC44KS5yb29tKDAuMikuY2xpcCgwLjQpLmF0dGFjaygwLjAxKSwKICAgIG5vdGUoIltjNCxlYjQsZzRdKjIiKS5zKCJzaW5lIikuYXR0YWNrKDAuMDIpLnJlbGVhc2UoMC4yKS5scGYoOTAwKS5nYWluKDAuNCkucm9vbSgwLjQpLnNpemUoNCksCiAgICBzKCJiZCB%2BIH4gYmQgfiB%2BIH4gfiIpLmJhbmsoInRyOTA5IikuZGlzdG9ydCgwLjMpLmdhaW4oMSksCiAgICBzKCJ%2BIH4gfiB%2BIGNwIH4gfiB%2BIikuYmFuaygidHI5MDkiKS5nYWluKDAuOCkucm9vbSgwLjMpLAogICAgcygiaGgqOCIpLmJhbmsoInRyOTA5IikuZ2FpbigwLjYpLmxwZigyMDAwKQogICldLAogIFs0LCBzdGFjaygKICAgIG5vdGUoIltjNCxlYjQsZzRdKjIiKS5zKCJzaW5lIikuYXR0YWNrKDEuNSkucmVsZWFzZSgyKS5scGYoMzAwKS5nYWluKDAuMykucm9vbSgwLjg1KS5zaXplKDYpCiAgKV0sCikK)**

Talking point: `arrange([8, ...], [8, ...], [4, ...])` = eight cycles of this, then eight of
that, then four of the other. The agent reached for it **unprompted** when asked to give a
loop "an actual arrangement" — a good moment to point out that it knows more Strudel than
the fifteen-minute primer taught you.
