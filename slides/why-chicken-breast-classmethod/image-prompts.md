# 画像生成プロンプト集

`slides.md` は classmethod 公式Slidevテンプレート（`classmethod-slidev-template`）のデザイン言語（白背景・ライトテーマ）に合わせて作成している。下記4枚の画像を `assets/images/` 配下から参照する。ChatGPT（DALL-E）やMidjourney等で生成し、同じファイル名で配置すれば自動的に反映される。

トーン：白背景のライトテーマに馴染むよう、明るく清潔感のある写真調。NHKドキュメンタリー的な重厚さではなく、classmethodテンプレートのクリーンな印象を優先する。

## 共通スタイル指定（全画像に付与）

```
clean bright product photography, soft natural lighting, white or light gray background,
minimal shadows, high key lighting, crisp and clean aesthetic,
no text, no watermark
```

## 1. eggs-tray.jpg（卵換算カード）

```
A dozen eggs arranged neatly in a light wooden or white tray,
soft natural overhead lighting, clean bright background,
minimal still-life product photography, no text
```

## 2. chicken-breast-raw.jpg（鶏むね肉換算カード）

```
Raw chicken breast fillets on a clean white cutting board,
bright soft lighting, clean food photography, no text
```

## 3. protein-scoop.jpg（プロテイン換算カード）

```
A scoop of protein powder next to a shaker bottle on a white surface,
bright clean studio lighting, minimal product photography, no text
```

## 4. house-construction.jpg（誤解③：家のメタファー）

```
A house under construction in daylight, wooden frame structure visible,
bright clear sky, clean documentary-style photography, no text
```

## 配置先

```
slides/why-chicken-breast/assets/images/eggs-tray.jpg
slides/why-chicken-breast/assets/images/chicken-breast-raw.jpg
slides/why-chicken-breast/assets/images/protein-scoop.jpg
slides/why-chicken-breast/assets/images/house-construction.jpg
```

## 備考

- `logo_blk_20221223.svg`（classmethodロゴ）は`classmethod-slidev-template`から流用済みの既存アセットのため生成不要
- NHKプロフェッショナル風の重厚な画像案は当初検討したが、テンプレートの公式デザイン（白背景・ライトテーマ）を優先する方針に変更したため不採用
