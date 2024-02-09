# PDF workspace

[![CI - Nix Status](https://github.com/kachick/pdf-workspace/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/pdf-workspace/actions/workflows/ci-nix.yml?query=branch%3Amain+)

Nix environment and scripts around my PDF operations. Create PDF from images and apply OCR.

Mostly personal use for now.

## Workflow

Assume there are some images

```bash
pngquant --skip-if-larger --force --ext .png "img1.png" "img2.png"
./scripts/imgs2pdf.bash "img_dir" png jpn
```

## Note

- [How to use tesseract](https://github.com/kachick/times_kachick/issues/165)
