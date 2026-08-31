# Slides — the Slidev deck

The workshop deck. **26 slides**, source of truth is [`slides.md`](slides.md) — one markdown
file. Everything else here supports it.

| Path | What |
| --- | --- |
| `slides.md` | The deck. Slides separated by `---`, speaker notes in `<!-- -->` |
| `components/` | Vue components used by slides — notably `StrudelPad.vue` |
| `components/strudelPresets.js` | The Strudel snippets the pads play |
| `styles/` | Deck CSS overrides |
| `dist/` | Build output — the offline copy you present from. Not in git |

## Quick reference

| I want to… | Command | Notes |
| --- | --- | --- |
| Edit + preview live | `npm run dev` | Opens <http://localhost:3030>, hot-reloads on save |
| Read my speaker notes | <http://localhost:3030/presenter> | Dev mode only. **Use this on the day** |
| Make the offline copy | `npm run build` | → `dist/`. **Slow — allow ~10 minutes** |
| Present the offline copy | `npx serve dist` | ⚠️ must be *served*, not opened as a file |
| Export a PDF backup | `npm run export` | Needs an extra download first — see below |
| Jump to a slide while presenting | press `g` | Type the number, Enter |

## Install (first time only)

```bash
cd slides
npm install
```

Node 22+, same as the MCP server. Versions are **pinned on purpose**: `@slidev/cli` at
`52.19.1` and `@strudel/repl` at `1.3.0`. Don't upgrade them the week of the workshop.

## 1. Write and preview — `npm run dev`

```bash
npm run dev          # → http://localhost:3030
```

Hot-reloads as you save `slides.md`. This is the mode you author in, and the **only** mode
with presenter view.

### Navigation keys

Verified against the pinned Slidev 52.19.1:

| Key | Does |
| --- | --- |
| `Space` · `→` · `PageDown` | Next **click** (steps through `v-click` reveals) |
| `↓` · `Shift`+`→` | Next **slide** (skips remaining clicks) |
| `Shift`+`Space` · `←` · `PageUp` | Back one click |
| `↑` · `Shift`+`←` | Back one slide |
| `o` or `` ` `` | Overview — all slides at once. `Esc` to close |
| `g` | Go to slide number |
| `d` | Toggle dark mode |

> [!WARNING]
> **There is no `p` shortcut for presenter mode** in this version. Open
> <http://localhost:3030/presenter> directly, or use the toolbar button that appears when
> you hover the bottom-left corner. Presenter view gives you the notes, a next-slide
> preview, and a timer — on a second screen while the audience sees `:3030`.

> [!CAUTION]
> `d` and `o` are single-letter shortcuts bound to the **window**. That is exactly why
> `StrudelPad` traps keystrokes — see [the rehearsal items](#️-rehearsal-items--do-not-skip)
> below. Typing `sound("bd*4")` anywhere unprotected would flip dark mode and open the
> overview mid-demo.

## 2. Build the offline copy — `npm run build`

```bash
npm run build        # → slides/dist/
```

Produces a self-contained static site. **Do this the day before**, not on the morning.

> [!IMPORTANT]
> **It is slow.** On this machine the build sits on `transforming...` for several minutes
> with no visible progress and near-zero CPU before finishing — it looks hung and isn't.
> Budget ~10 minutes and don't kill it. Piping it through `tail` hides all output; run it
> plain so you can see the phase it's on.

### Opening `dist/` — it must be served

`dist/` is a single-page app. **Double-clicking `dist/index.html` will show a blank page**
(a `file://` page can't load the app's module bundles). Serve it instead:

```bash
npx serve dist                     # → http://localhost:3000
# or, no download needed:
python3 -m http.server -d dist 8080
```

> [!NOTE]
> **The built deck is offline-capable except the Strudel pads**, which fetch sample maps
> from the network on first play. Full detail in
> [⚠️ The pads need network](#️-the-pads-need-network--the-offline-build-does-not-cover-them)
> below. Warm them online before you present.

## 3. Export a PDF — `npm run export`

A PDF is your last-resort fallback: no build server, no network, no Vue, just pages.

> [!WARNING]
> **Not ready out of the box.** Export renders slides through a headless browser, and
> `playwright-chromium` is **not currently installed** in this folder. The first run will
> stop and ask for it. Install it deliberately, ahead of time:
>
> ```bash
> npm i -D playwright-chromium      # extra download, ~100–200 MB
> npm run export                    # → slides-export.pdf
> ```

Useful variants:

```bash
npx slidev export --dark                  # match the theme you present in
npx slidev export --with-clicks           # one page per v-click step, not per slide
npx slidev export --format png            # → PNG per slide, for the report/email
npx slidev export --range 1-12            # just part 1
```

> [!CAUTION]
> **A PDF cannot play anything.** The Strudel pads, the strudel.cc iframe and the YouTube
> embed all render as dead rectangles. The PDF is a fallback for the *talk*, not for the
> demo — if you're down to the PDF, the demo runs from the pre-saved URLs in
> [`../docs/strudel/demo-reggae.md`](../docs/strudel/demo-reggae.md).

## 4. Editing the deck

Slides are separated by a line containing only `---`. Per-slide options go in a frontmatter
block right after the separator:

````markdown
---
layout: statement
---

# A big centred line

---

# A normal slide

Content here.

<div v-click class="pt-8">

This appears on the next click.

</div>

<!--
Speaker note. Only visible in presenter view.
-->
````

- **Layouts used in this deck:** `default`, `center`, `section`, `statement`, `iframe-right`.
- **Reveal step by step** with `v-click` on any element.
- **Styling is UnoCSS/Tailwind classes** in raw `<div>`s — match what's already there.
- **Leave a blank line** around markdown inside a `<div>`, or it won't render as markdown.
- Renumbering: the questions-before-exploration slides are **21–22** and the closer is **26**;
  [`../docs/run-of-show.md`](../docs/run-of-show.md) references slide numbers, so if you
  insert slides in the middle, fix them there too.

## Let your agent edit the deck

Slidev ships its own MCP server, plus an official agent skill. This is a second, quieter
MCP example — the same "you type, the browser changes" shape as Strudel.

```bash
npx skills add slidevjs/slidev                                   # Claude Code + Codex
claude mcp add --transport http slidev http://localhost:3030/__mcp   # dev server running
```

Then: *"Add a slide after the three-modes one showing the seed prompts."*

## Live Strudel pads (slides 8–11)

Slides 8–11 — *Build it up · Two more · Layers · One knob* — each carry a `<StrudelPad>`:
a small Strudel REPL docked into the slide, so you can play the examples **without leaving
the deck**. Click **▶ Live Strudel** bottom-right: it opens the pad **and auto-plays the
first snippet**. Click any chip to switch snippets. The editor is live — edit it, then click
▶ to play or ■ to stop.

Snippets live in [`components/strudelPresets.js`](components/strudelPresets.js), one named
set per slide. To add a set: add a key there, then `<StrudelPad preset="yourkey" />` in
`slides.md`. **Don't** pass code inline in the markdown — double quotes can't be escaped
inside a Vue attribute and the build fails.

This is **not** an iframe to strudel.cc. It's the `@strudel/repl` web component
(`<strudel-editor>`, pinned **1.3.0**) running in the deck's own page, which is what makes
instant snippet-swapping and real ▶/■ buttons possible. Three consequences:

- **Editors are created only when you open a pad.** Opening the first one takes a moment
  while the Strudel engine loads. Open one early to warm it.
- **Only one pad plays at a time** (the component's `solo` mode) — opening another or
  hitting ▶ elsewhere stops the previous one.
- **It is a different Strudel build from strudel.cc.** Fine for these five-token examples;
  don't assume exotic functions match.

### ⚠️ The pads need network — the offline build does not cover them

`slidev build` produces an offline SPA, **but the pads are an exception.** Strudel fetches
its sample maps from `raw.githubusercontent.com` on first play and there's no service worker
caching them. **Verified 2026-08-20:** with external requests blocked, clicking a chip does
nothing at all — the scheduler never starts.

**Mitigation:** open all four pads and play at least one chip on each **while you have
wifi**, on the machine and browser profile you'll present from. Same rule as the strudel.cc
sample cache, different mechanism. If the wifi dies, slide 6's strudel.cc iframe is the
PWA-cached fallback.

## ⚠️ Rehearsal items — do not skip

1. **Your clicker will not work on slide 6 (the strudel.cc iframe).** Keyboard events don't
   cross into a cross-origin iframe. Nothing steals your typing (good), but you also lose
   slide navigation while focus is in Strudel. **Advance that slide by mouse-click** — click
   the text column first, then arrow keys work again.

   **The pads on slides 8–11 are different and safer.** They're in the deck's own page, so
   `StrudelPad` traps keydown/keyup at the panel root. This is load-bearing, not decorative:
   Slidev binds its shortcuts to `window` via `useMagicKeys` and its ignore-list is only
   `INPUT`/`TEXTAREA`/`BUTTON`/`A` — CodeMirror is a **contenteditable div**, so without the
   trap, typing `sound("bd*4")` would fire `d` (dark mode) and `o` (overview) mid-demo.
   **Verified 2026-08-20:** pressing `d` outside a pad flips the deck to dark; typing the
   same character inside a pad changes nothing but the code. Click the slide (not the pad)
   to get arrow keys back.

2. **Add `allow="autoplay"` for slides that must make noise.** The `layout: iframe-right`
   used here sets no `allow=` attribute. Audio worked in testing anyway, but if a slide
   must be reliable, write the iframe by hand:

   ```html
   <iframe src="https://strudel.cc/" allow="autoplay"
           style="width:100%;height:75vh;border:0"></iframe>
   ```

3. **The MCP cannot drive the slide's iframe.** The Strudel MCP server drives its *own*
   Playwright Chromium window — a different browser context. The reggae demo happens in
   that window, not in the deck. This is true of every deck tool; plan the switch.

4. **Warm the sample cache online.** strudel.cc caches the app on first visit, but samples
   cache only when actually played. Play every sound in the demo while you still have wifi.

5. **Preload a pattern into a slide** with `https://strudel.cc/#<base64-of-the-code>` — the
   same URL form students use to save their work.

## Speaker notes

Every `<!-- ... -->` block in `slides.md` is a presenter note. To read them while
presenting, open **presenter view** at <http://localhost:3030/presenter> (dev mode only).
**There is no `p` keyboard shortcut** in the pinned version — use the URL or the toolbar
button. The reggae demo's full script lives in
[`../docs/strudel/demo-reggae.md`](../docs/strudel/demo-reggae.md).
