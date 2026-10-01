# Sophie Voice Mouse

**Hold the middle mouse button, speak, release — your words are typed wherever your cursor is.**

Sophie Voice Mouse turns the mouse you already own into a voice input device for Windows. It was built for talking to AI assistants: dictate a prompt, grab an error message or a paragraph with a quick tap, and send both together without touching the keyboard.

[한국어 README](README.ko.md)

## How it works

| Do this | Get this |
|---|---|
| **Hold** the middle button, speak, **release** | What you said is typed at the cursor |
| Select text, then **tap** the middle button | That text is stashed (tap again to stash more) |
| With text stashed, **tap** with nothing selected | The stashed text is pasted — no keyboard needed |
| With text stashed, **hold and speak** | Your words + the stashed text are typed together, and the stash is cleared |
| Select text and **hold right away** | Your words + the selection are typed together |
| **Tap** with nothing selected and nothing stashed | A normal middle click (open link in new tab, etc.) |

A tap picks text up and a tap puts it down, so you never need the keyboard.

Example: select an error message on a web page → **tap** → click into your AI chat box → hold and say *"why am I getting this?"* → release:

```
Why am I getting this?

TypeError: cannot read property 'map' of undefined
```

A small bubble next to your cursor shows what's happening: listening, how much text is attached, working, done. While anything is stashed, a chip stays next to your cursor so you can see that a tap will paste rather than middle-click.

**Text goes to the window that has the keyboard focus** — not to whatever the mouse is hovering over. Click into the chat box or editor first, then hold the button. The app's own console window is the one exception: nothing is ever typed into it. If it has the focus when your words are ready, they are stashed instead and the bubble asks you to click where you want them.

## Features

- **Works in any app** — chat boxes, editors, email, documents.
- **Any language** — speech recognition detects your language automatically.
- **Fixes punctuation for you** — with an API key, an AI adds `? ! , .` and drops "um/uh", without changing your words.
- **Bring your own key** — Claude, OpenAI or Gemini. The provider is detected from the key itself.
- **Private by default** — speech recognition runs on your PC. Your audio never leaves it.

## Download & run

### Option A: ready-made app (no Python needed)

1. Download `SophieVoiceMouse-windows.zip` from [Releases](../../releases) and unzip it.
2. Double-click `SophieVoiceMouse.exe`.
3. Windows may show *"Windows protected your PC"* because the app isn't code-signed yet. Click **More info → Run anyway**.

### Option B: run from source

1. Install [Python 3.10+](https://www.python.org/downloads/) — tick **"Add python.exe to PATH"** in the installer.
2. Download this repository and double-click `run.bat`. It installs everything on the first run.

The first launch downloads the speech model (~500 MB), which takes a few minutes. After that, it starts in seconds.

## API key (optional)

On first launch you'll be asked for an API key. Paste one from any of these:

| Provider | Key starts with | Get a key | Default model |
|---|---|---|---|
| Claude | `sk-ant-` | [console.anthropic.com](https://console.anthropic.com/settings/keys) | `claude-haiku-4-5-20251001` |
| OpenAI | `sk-` | [platform.openai.com](https://platform.openai.com/api-keys) | `gpt-5.4-nano` |
| Gemini | `AIza` | [aistudio.google.com](https://aistudio.google.com/apikey) | `gemini-3.5-flash-lite` |

- The key is stored in **Windows Credential Manager**, never in a file.
- Usage is billed to your own account. Cleaning one sentence costs a tiny fraction of a cent with these small models.
- **Skip** it and Sophie Voice Mouse still works: your words are typed exactly as recognized.
- Change key: `Change API key.bat` (app) or `run.bat --set-key` (source). Remove key: `--clear-key`.

## Privacy

- **Audio** is transcribed locally with [faster-whisper](https://github.com/SYSTRAN/faster-whisper). It is never uploaded.
- **Transcribed text** is sent to the AI provider you chose, only if you added a key, only to fix punctuation.
- **Text you select or stash** is pasted locally and is **not** sent to the AI.
- Selecting text briefly uses the clipboard; your previous clipboard text is restored afterwards.

## Settings

Edit the `Settings` block at the top of `sophie_voice_mouse.py`:

| Setting | What it does |
|---|---|
| `MODE` | `"clean"` (keep your words, fix punctuation — default), `"dictate"` (no AI), `"prompt"` (rewrite into a tidy prompt) |
| `LANGUAGE` | `None` = auto-detect, or a fixed code like `"en"`, `"ko"`, `"ja"` |
| `UI_LANG` | `None` = follow Windows, or `"en"` / `"ko"` |
| `SELECTION_POSITION` | Put attached text `"after"` or `"before"` your words |
| `MODELS` | Model used for each provider |
| `WHISPER_MODEL` | `"base"` = faster, `"medium"` = more accurate |
| `WHISPER_DEVICE` | `"cuda"` if you have an NVIDIA GPU (much faster) |

## Good to know

- **Terminals** (Command Prompt, PowerShell, Windows Terminal): Ctrl+C stops programs there, so text is never auto-copied in a terminal. Copy it yourself.
- **Middle-button autoscroll** (hold and drag in a browser) no longer works, because holding the button means "record".
- If text is selected on a page and you middle-click a link, the text gets stashed instead of opening a new tab. Deselect first.
- While anything is stashed, a tap pastes it instead of middle-clicking. Paste it (or wait 10 minutes for it to expire) to get middle click back. The chip next to your cursor tells you when this is the case.
- **Admin windows**: Windows blocks input into apps running as administrator. Run Sophie Voice Mouse as administrator too if you need that.
- Some antivirus tools are wary of apps that watch the mouse and keyboard. The full source is here so you can check exactly what it does.

## Troubleshooting

- **Nothing happens when I hold the button** → the console should print `▶ middle button` on each press. If not, check that your mouse software (e.g. Logi Options+) hasn't remapped the middle button.
- **No recording** → Settings → Privacy & security → Microphone → turn on *Let desktop apps access your microphone*.
- **Slow** → set `WHISPER_MODEL = "base"`, or use `"cuda"` with an NVIDIA GPU.

## Build the app yourself

Push a tag like `v0.1.0` and GitHub Actions builds `SophieVoiceMouse-windows.zip` and attaches it to a release. See [.github/workflows/build.yml](.github/workflows/build.yml).

## License

[MIT](LICENSE) — Copyright (c) 2026 Sophie ([@LetsBeLikeSophie](https://github.com/LetsBeLikeSophie)).

Made by Sophie. If you build on it, a link back to [this repository](https://github.com/LetsBeLikeSophie/sophie-voice-mouse) is appreciated.
