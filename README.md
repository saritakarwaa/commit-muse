# Commit-Muse

> A Git commit-message hook installer that rewrites your commit messages in any style using Google’s Gemini AI.

`commit-muse` hooks into your project’s Git workflow to automatically “bardify” (rewrite) your commit messages in the style of your choice. Powered by Google’s Gemini API, it transforms raw commit text into a single concise sentence in fun or formal styles—all without leaving your terminal.

---

## Features

* 📜 **Automated rewriting** of Git commit messages
* 🎭 **Custom styles**: Shakespeare, Haiku, Formal, and more
* 🔧 **Easy installation** via npm / npx
* 🔒 Configurable via environment variables
* ⚙️ Built‑in installer to place the `commit-msg` hook

---

## Installation

Install globally:

```bash
npm install -g commit-muse
```

*or* install per-project as a dev dependency:

```bash
npm install --save-dev commit-muse
```

Then run the installer to register the Git hook:

```bash
npx commit-muse
```

This copies `hook.sh` into `.git/hooks/commit-msg` and makes it executable.

---

## Configuration

Before using, set your Gemini API key and optionally choose a style:

| Variable         | Default       | Description                                           |
| ---------------- | ------------- | ----------------------------------------------------- |
| `GEMINI_API_KEY` | *(required)*  | Your Google Gemini API key                            |
| `BARD_STYLE`     | `Shakespeare` | The writing style to apply (e.g., Shakespeare, Haiku) |

You can set these in your shell:

```bash
export GEMINI_API_KEY="YOUR_API_KEY_HERE"
export BARD_STYLE="Haiku"
```

---

## Usage

1. **Stage your changes**:

   ```bash
   git add .
   ```

2. **Commit as usual**:

   ```bash
   git commit -m "fix user login validation"
   ```

   The hook will automatically run, rewriting your message.

3. **Observe the output**:

   ```text
   Using style: Haiku
   ✅ Commit message bardified!
   ```

4. **Push to remote**:

   ```bash
   git push
   ```

Your AI-enhanced message is now in the commit history.

---

## Available Styles

You can use any style that makes sense as plain text. Here are some examples:

| Style         | Description                       | Example Prompt Text                                     |
| ------------- | --------------------------------- | ------------------------------------------------------- |
| `Shakespeare` | Old-English dramatic flair        | Rewrite this commit in Shakespearean style.             |
| `Haiku`       | 5–7–5 syllable poetic form        | Rewrite this commit as a Haiku (5-7-5 syllables).       |
| `Formal`      | Professional, business-like tone  | Rewrite this commit in a concise, formal business tone. |
| `Casual`      | Friendly, conversational          | Rewrite this commit in a casual, conversational tone.   |
| `Pirate`      | Yarr! Swashbuckling pirate jargon | Rewrite this commit in pirate speak.                    |

To try another style, just set `BARD_STYLE`:

```bash
export BARD_STYLE="Pirate"
git commit -m "add user profile page"
```

---

## How It Works

* **Installer (`bin/install.js`)**: Copies `hook.sh` into your repo’s `.git/hooks/commit-msg` and sets the right permissions.
* **Commit Hook (`hook.sh`)**:

  1. Reads your original commit message.
  2. Sends a prompt (including `BARD_STYLE`) and the message to the Gemini API.
  3. Overwrites the commit message file with the AI’s single-sentence rewrite.

---

## Requirements

* **Node.js** v12+ (for the installer script)
* **`jq` CLI** (for JSON construction and parsing in `hook.sh`)
* A **Git repository** with a `.git` folder

---

## Contributing

Contributions, issues, and feature requests are welcome! Fork the repo and send a PR:

1. Fork and clone
2. Create a feature branch: `git checkout -b feature/new-style`
3. Commit your changes: `git commit -m "feat: add whimsical style option"`
4. Push and open a PR

---

## License

MIT © \[Your Name]
