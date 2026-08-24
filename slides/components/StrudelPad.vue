<!--
  StrudelPad — a small live Strudel REPL docked into a slide.

  Uses @strudel/repl's <strudel-editor> web component (NOT an iframe to strudel.cc),
  so snippets swap instantly and we get real ▶ / ■ buttons on the slide.

  Two things this component exists to handle, both learned the hard way — see
  slides/README.md before changing them:

  1. Slidev's shortcuts fire on `window` via useMagicKeys, and its ignore-list is only
     INPUT/TEXTAREA/BUTTON/A. CodeMirror is a *contenteditable div*, so typing
     `sound("bd*4")` would trigger `o` (overview) and `d` (dark mode) mid-demo.
     Fix: stop keydown/keyup propagation at the panel root.
  2. The web component inserts its editor as a *sibling* of itself, so it needs a
     dedicated host element and the instance has to be polled for after upgrade.
-->
<script setup>
import { computed, nextTick, onBeforeUnmount, ref, shallowRef } from 'vue'
import { presets } from './strudelPresets'

const props = defineProps({
  // name of a set in strudelPresets.js — the normal way to use this
  preset: { type: String, default: '' },
  // or pass snippets inline: [{ label: 'bd*4', code: '...' }]
  snippets: { type: Array, default: () => [] },
  // shown before any chip is clicked
  code: { type: String, default: '' },
  label: { type: String, default: 'Live Strudel' },
})

const open = ref(false)
const loading = ref(false)
const playing = ref(false)
const active = ref(-1)
const error = ref('')
const host = ref(null)
const el = shallowRef(null)

const items = computed(() => (props.preset ? presets[props.preset] : props.snippets) || [])
const initial = props.code || items.value[0]?.code || 'sound("bd*4")'

async function ensureEditor() {
  if (el.value) return el.value
  loading.value = true
  error.value = ''
  try {
    // client-only: pulls in the whole Strudel engine, so never at slide-mount time
    await import('@strudel/repl')
    await nextTick()
    // built imperatively so Vue never tries to resolve <strudel-editor> as a component
    const node = document.createElement('strudel-editor')
    node.setAttribute('code', initial)
    host.value.appendChild(node)
    // .editor is assigned in connectedCallback, which runs on upgrade
    for (let i = 0; i < 100 && !node.editor; i++)
      await new Promise(r => setTimeout(r, 20))
    if (!node.editor) throw new Error('Strudel editor failed to load')
    el.value = node
  } catch (e) {
    error.value = 'Could not load Strudel. Check your network and reload the slide.'
    console.error(e)
  } finally {
    loading.value = false
  }
  return el.value
}

async function toggleOpen() {
  open.value = !open.value
  if (open.value) {
    const node = await ensureEditor()
    if (node && items.value.length) {
      active.value = 0
      node.editor?.setCode(items.value[0].code)
      await play()
    }
  } else {
    stop()
  }
}

async function load(snippet, i) {
  const node = await ensureEditor()
  if (!node) return
  active.value = i
  node.editor?.setCode(snippet.code)
  await play()
}

async function play() {
  const node = await ensureEditor()
  if (!node) return
  await node.editor?.evaluate()   // first call waits on prebake (needs network)
  playing.value = true
}

function stop() {
  el.value?.editor?.stop()
  playing.value = false
}

onBeforeUnmount(stop)
</script>

<template>
  <!-- keydown/keyup MUST stop here: see note 1 above -->
  <div class="strudel-pad" @keydown.stop @keyup.stop>
    <button v-if="!open" class="pad-launch" @click="toggleOpen">
      ▶ {{ label }}
    </button>

    <div v-show="open" class="pad-panel">
      <div class="pad-bar">
        <button
          v-for="(s, i) in items" :key="i"
          class="pad-chip" :class="{ 'pad-chip-on': active === i }"
          :disabled="loading"
          @click="load(s, i)"
        >{{ s.label }}</button>

        <span class="pad-spacer" />

        <button class="pad-btn" :disabled="loading" @click="play">▶</button>
        <button class="pad-btn" :disabled="!playing" @click="stop">■</button>
        <button class="pad-btn pad-close" @click="toggleOpen">✕</button>
      </div>

      <div ref="host" class="pad-editor" />

      <div class="pad-hint">
        <span v-if="loading">loading Strudel (needs network on first open)…</span>
        <span v-else-if="error" class="text-red-300">{{ error }}</span>
        <span v-else>edit freely · click ▶ to play · click ■ to stop · click the slide to get arrow keys back</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.strudel-pad { position: absolute; left: 0; right: 0; bottom: 0; z-index: 20; }

.pad-launch {
  position: absolute; right: 1.5rem; bottom: 1.2rem;
  padding: 0.35rem 0.8rem; border-radius: 999px;
  font-size: 0.8rem; font-weight: 600;
  background: var(--slidev-theme-primary, #3b82f6); color: #fff;
  opacity: 0.85; transition: opacity 0.15s;
}
.pad-launch:hover { opacity: 1; }

.pad-panel {
  background: rgba(0, 0, 0, 0.82);
  backdrop-filter: blur(6px);
  border-top: 1px solid rgba(255, 255, 255, 0.15);
  padding: 0.5rem 1rem 0.6rem;
}

.pad-bar { display: flex; align-items: center; gap: 0.4rem; flex-wrap: wrap; margin-bottom: 0.4rem; }
.pad-spacer { flex: 1; }

.pad-chip {
  padding: 0.2rem 0.6rem; border-radius: 4px;
  font-family: ui-monospace, monospace; font-size: 0.72rem;
  background: rgba(255, 255, 255, 0.1); color: rgba(255, 255, 255, 0.85);
}
.pad-chip:hover { background: rgba(255, 255, 255, 0.2); }
.pad-chip-on { background: #3b82f6; color: #fff; }

.pad-btn {
  padding: 0.2rem 0.6rem; border-radius: 4px; font-size: 0.8rem;
  background: rgba(255, 255, 255, 0.12); color: #fff;
}
.pad-btn:disabled { opacity: 0.35; }
.pad-close { background: transparent; opacity: 0.6; }

/* the web component injects its editor as a sibling inside this host */
.pad-editor { max-height: 26vh; overflow: auto; font-size: 13px; }
.pad-editor :deep(.cm-editor) { background: transparent; }

.pad-hint { font-size: 0.65rem; opacity: 0.5; color: #fff; padding-top: 0.3rem; }
</style>
