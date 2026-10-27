# Manim animations for PRBA lectures

Source code of the videos embedded in the lectures. The `_` prefix keeps
this folder out of the Quarto render.

| Scene | Lecture | Output |
|---|---|---|
| `seq_vs_index.py` → `SeqScanVsIndexScan` | `lectures/wyklad6.qmd` | `lectures/media/seq_vs_index.mp4` |

## Setup (once)

Manim needs Python ≤ 3.13 (no wheels for 3.15 yet) plus Homebrew `cairo`,
`pango` and `ffmpeg`. The virtual environment lives in `.venv/`
(already in `.gitignore`).

```bash
uv venv --python 3.13 .venv
uv pip install --python .venv/bin/python manim
```

## Render

Run from the repository root. `--media_dir` keeps Manim's partial files
out of the repo; only the final mp4 is copied into `lectures/media/`.

```bash
.venv/bin/manim -qm --media_dir /tmp/manim _manim/seq_vs_index.py SeqScanVsIndexScan
cp /tmp/manim/videos/seq_vs_index/720p30/SeqScanVsIndexScan.mp4 lectures/media/seq_vs_index.mp4
```

Use `-ql` (480p15) for quick previews while editing. Keep committed videos
at 720p (`-qm`) so every re-render adds only a few MB to the git history.
