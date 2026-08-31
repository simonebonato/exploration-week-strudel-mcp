# Set up Strudel with Claude Desktop

You do **not** need to know how to program. This guide asks you to open a terminal once
and paste two commands. A terminal is simply a window where you give your computer a
written instruction and press Enter.

We will work through this guide **together during the workshop**. Allow about 15–20 minutes. You
need a Mac or Windows laptop and an internet connection.

> [!IMPORTANT]
> Use the **Claude Desktop app**, not claude.ai in a web browser. The browser version cannot
> run the music server on your laptop.

## 1. Install Claude Desktop

Download and install [Claude Desktop](https://claude.ai/download), then open it and sign in
with the account provided for the workshop.

Leave Claude Desktop open once. This creates the settings folder we need later.

## 2. Install Node.js

Node is the program that runs the music server. You will not need to use it during the
workshop.

1. Go to [nodejs.org](https://nodejs.org).
2. Download and run the recommended installer. Accept the default choices.
3. When the installer finishes, open a terminal:
   - **Windows:** press Start, type `PowerShell`, then press Enter.
   - **Mac:** press Cmd+Space, type `Terminal`, then press Enter.
4. Paste this into the terminal and press Enter:

   ```text
   node -v
   ```

You should see a version such as `v22.22.2`. The number after `v` must be **22 or higher**.
If you see “command not found” or “not recognized,” close the terminal, open it again and
retry. If it still fails, reinstall Node.

## 3. Install the music server

In the same terminal, paste this whole line and press Enter:

```text
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0
```

Text will move on the screen for a while. Warnings are okay. Wait until you can type on a
new line again.

## 4. Make the Claude Desktop setting

The setting needs two long paths that are different on every laptop. The command below
finds them and produces the exact setting for you.

Paste this **entire line** into the terminal and press Enter:

```text
node -e 'const path=require("path"),{execSync}=require("child_process");const root=execSync("npm root -g",{encoding:"utf8"}).trim();console.log(JSON.stringify({mcpServers:{strudel:{command:process.execPath,args:[path.join(root,"@williamzujkowski","live-coding-music-mcp","dist","index.js")]}}},null,2))'
```

It prints a block beginning with `{` and ending with `}`. Select and copy that whole block.
Do **not** copy the command itself.

Now open Claude Desktop:

1. Open **Settings**.
2. Select **Developer**.
3. Select **Edit Config**. A text file opens.
4. If the file is empty or contains only `{}`, replace it with the block you copied.
5. Save the file.

> [!CAUTION]
> If the file already contains a name such as `blender` or another `mcpServers` setting,
> **do not replace it**. You could disconnect the other tool. Stop here and show the file
> to the workshop facilitator; the two settings need to be combined.

## 5. Restart Claude Desktop completely

- **Mac:** choose **Claude → Quit Claude** or press Cmd+Q.
- **Windows:** right-click the Claude icon near the clock and select **Quit**.

Closing only the window is not enough. Open Claude Desktop again.

## 6. Check that it makes sound

Start a new conversation and type:

> Initialize Strudel and play a four-on-the-floor kick drum.

Claude may ask permission to use the Strudel tools. Approve it. A separate Chromium
window should open at strudel.cc and you should hear a kick drum.

> [!NOTE]
> Claude may first ask to install **Chromium**. This is expected: Chromium is the separate
> browser the music server controls. Approve the installation and wait for the download to
> finish; it is roughly 180 MB.

**Heard it? You are ready for the workshop.** 🎉

> [!IMPORTANT]
> Keep the Chromium window open. Closing it breaks the music connection. If you close it by
> accident, fully quit Claude Desktop, reopen it and start a new conversation.

## If it did not work

| What happened | What to try |
| --- | --- |
| No Chromium window opened | Fully quit and reopen Claude Desktop. In **Settings → Developer**, check whether `strudel` appears and is running. |
| Chromium opened but there is no sound | Click once inside the Chromium window, then check your laptop volume and selected headphones. |
| Claude says a browser is missing | Ask the workshop facilitator for help. The extra browser download is large, so do not guess at commands. |
| Everything failed after you closed Chromium | Fully quit and reopen Claude Desktop, then begin a new conversation. Asking Claude to initialize again will not repair the old connection. |
| The config file already contained something | Do not overwrite it. Ask for help so the settings can be combined safely. |

Still stuck? Tell the workshop facilitator which numbered step failed;
the first part of the session includes time to fix setup.
