# speak-hub

[Slidev](https://sli.dev/) で管理するプレゼンテーション集。

## セットアップ

```bash
pnpm install
```

## スライド一覧

| スライド | コマンド |
| --- | --- |
| 独自のRedis構築 | `pnpm run dev:redis` |
| Starter Template（参考用） | `pnpm run dev:starter` |

## 新しいスライドの追加

1. `slides/<スライド名>/` ディレクトリを作成
2. `slides/<スライド名>/slides.md` をエントリーポイントとして作成
3. `package.json` の `scripts` にコマンドを追加:
   ```json
   "dev:<name>": "slidev slides/<スライド名>/slides.md --open"
   ```

## ビルド・エクスポート

```bash
pnpm run build:redis    # 静的ファイル生成
pnpm run export:redis   # PDF エクスポート
```
