# Setup Guide — README v3 (Japanese Minimal)

## 📂 Final structure

After setup, `yoonjae26/yoonjae26` repo will look like this:

```
yoonjae26/
├── README.md
├── assets/
│   ├── banner.svg        ← hero (name + Go2 technical drawing + hanko)
│   ├── dashboard.svg     ← "Now" status card with 4 columns
│   └── manifesto.svg     ← centered quote banner
└── .github/
    ├── scripts/
    │   └── update-readme.js
    └── workflows/
        └── update-readme.yml
```

## 🚀 Three steps to deploy

### Step 1 — Upload files

| File in this package | → | Path in repo |
|---|---|---|
| `README.md` | → | `README.md` |
| `banner.svg` | → | `assets/banner.svg` |
| `dashboard.svg` | → | `assets/dashboard.svg` |
| `manifesto.svg` | → | `assets/manifesto.svg` |
| `update-readme.yml` | → | `.github/workflows/update-readme.yml` |
| `update-readme.js` | → | `.github/scripts/update-readme.js` |

### Step 2 — Enable Discussions

1. Repo → **Settings** → **Features** → tick **Discussions**
2. Discussions tab → create 4 categories:
   - **Guestbook** (announcement)
   - **Ideas** (open-ended)
   - **Q&A** (question/answer)
   - **Hall of the Curious** (announcement) — for the easter egg

### Step 3 — First workflow run

1. Repo → **Actions** tab → "Update README" workflow
2. **Run workflow** → wait ~30s
3. The "Archive" section auto-fills with your 5 most recent activities

After this, the workflow runs daily at 00:00 UTC.

---

## ✏️ Keeping content fresh

### Update the dashboard weekly

Open `assets/dashboard.svg` and edit:

**Column 1 — Now building:**
- Find the two `<text class="serif" font-style="italic">` near `y="95"` and `y="120"`
- Change project name (2 lines)
- Update progress bar: change `x2="100"` (current progress in % out of 240)
- Update text: `42% — PHASE 2 / 5`

**Column 2 — Reading:**
- Find `Reinforcement` / `Learning` → replace with current book title
- Update author and chapter

**Column 3 — Metrics:**
- Update `3.2k`, `14`, `3` numbers when they change

**Column 4 — Availability:**
- Change the green dot to grey if not available:
  - `fill="#22a06b"` → `fill="#999"`
  - Remove the `<animate>` tags

Tip: bookmark `assets/dashboard.svg` on GitHub's web editor and update it every Sunday in 2 minutes.

### Update manifesto

`assets/manifesto.svg` has the quote on two lines around `y="135"` and `y="178"`. Edit, commit.

---

## 🥚 The easter egg

In "Say hello" → "The hidden one", the hint says *"Look at the banner. Read the technical drawing carefully."*

**Answer:** the number `12` (joints) is the key, labeled directly on the Go2 drawing in the banner.

When someone finds it and opens the issue, manually add them to the "Hall of the Curious" Discussions category. This builds engagement.

---

## 🎨 Design notes

The aesthetic borrows from Japanese editorial design:
- **Paper colour** `#f7f5f0` (warm off-white)
- **Ink** `#1a1a1a` (near-black, not pure black)
- **Single accent** `#c8202e` (vermillion, used only in the hanko stamp and opening quote — sparingly)
- **Typography pairing:** Cormorant Garamond (serif italic) for emotion, Inter (sans) for body, JetBrains Mono (mono) for metadata
- **Fallbacks:** all fonts fall back to system defaults if not loaded (Times, Helvetica, Courier)

Whitespace is the loudest element. Don't fill it.

---

## 🔧 Troubleshooting

**SVG not showing?** → Path is `./assets/banner.svg` (relative). If you put files at a different path, edit the `<img src="...">` in README.

**Action permission error?** → Settings → Actions → General → Workflow permissions → "Read and write".

**Want to change cron schedule?** → `.github/workflows/update-readme.yml`:
- `'0 */6 * * *'` = every 6 hours
- `'0 0 * * 1'` = every Monday at midnight

**Light mode only?** → GitHub renders SVG with its set colors regardless of viewer's theme. The off-white background works on both light and dark mode (though it'll look like a warm card on dark mode — still good).
