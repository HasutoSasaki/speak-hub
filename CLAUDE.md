# CLAUDE.md

## Project Overview

Slidev によるプレゼンテーション管理プロジェクト。複数のスライドデッキを `slides/` ディレクトリ配下で管理する。

## Project Structure

```
slides/
├── <スライド名>/
│   ├── slides.md          # エントリーポイント
│   └── *.md               # セクション別ファイル（src でインポート）
└── starter-template/      # 参考用テンプレート
```

## Commands

- `pnpm run dev:<name>` - 開発サーバー起動
- `pnpm run build:<name>` - 静的ビルド
- `pnpm run export:<name>` - PDFエクスポート

## Slide Design Rules

スライドの作成・編集・レビュー時は、必ず `docs/rules.md` を読み、記載されたルールに従うこと。

主要なルール:
- **デザイン**: Bento UI (Grid System)、Soft Glow配色、"Less is More" の装飾原則
- **技術仕様**: Frontmatter設定、Mermaid.js の themeVariables 適用、Vue/UnoCSS コンポーネント
- **構成**: Hook → Focus → Action のストーリーテリング、1スライド・1メッセージ
- **プロセス**: 曖昧な指示の場合はいきなり作らず、Target/Tone/Goal を質問して要件を固める
