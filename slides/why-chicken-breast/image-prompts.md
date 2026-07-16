# 画像生成プロンプト集

`slides.md` は下記4枚の画像を参照する。ChatGPT（DALL-E）やMidjourney等で生成し、同じファイル名で配置すれば自動的に反映される。

タイトルスライドは `layout: intro-image` が画像未配置時に文字を白背景へ白文字で描画してしまう（画像の有無に関わらずcolorを強制的に白にする仕様）ため、`layout: intro`（画像なし）に変更済み。背景画像は使用しない。

トーン：NHK「プロフェッショナル 仕事の流儀」のオープニング映像を意識した、重厚でシネマティックなドキュメンタリー写真調。派手さや彩度を避け、深い陰影と静かな迫力を出す。四角い枠のカードには入れず、写真そのものを直接配置する構成なので、画像単体で完結する構図にする。

## 共通スタイル指定（全画像に付与）

```
cinematic documentary photography, dramatic side lighting, deep shadows,
desaturated muted tones, shallow depth of field, subtle film grain,
serious and quiet intensity, NHK professional documentary style,
high contrast, no text, no watermark
```

## 1. eggs-tray.jpg（卵換算）

```
A dozen eggs arranged neatly in a dark wooden tray,
dramatic overhead side lighting, deep shadows between eggs,
muted desaturated color palette, documentary still-life photography,
shallow depth of field, subtle film grain, quiet intensity, no text
```

配置先：`assets/images/eggs-tray.jpg`

## 2. chicken-breast-raw.jpg（鶏むね肉換算）

```
Raw chicken breast fillets stacked on a dark cutting board with a kitchen knife nearby,
dramatic side lighting, deep shadows, muted desaturated tones,
documentary food photography, shallow depth of field, subtle film grain,
quiet and serious mood, no text
```

配置先：`assets/images/chicken-breast-raw.jpg`

## 3. protein-scoop.jpg（プロテイン換算）

```
A metal scoop filled with protein powder next to a shaker bottle,
dark studio background, dramatic side lighting emphasizing texture,
muted desaturated tones, documentary still-life photography,
shallow depth of field, subtle film grain, no text
```

配置先：`assets/images/protein-scoop.jpg`

## 4. house-construction.jpg（誤解③：家のメタファー）

```
A house under construction at dusk, wooden frame structure visible,
a craftsman silhouette working quietly, warm dim backlighting against a dark sky,
cinematic documentary photography, muted desaturated tones,
shallow depth of field, subtle film grain, quiet and serious mood,
NHK professional documentary style, no text
```

配置先：`public/images/house-construction.jpg`（`layout: image-right` の背景として使用）

## 配置先まとめ

```
slides/why-chicken-breast/public/images/house-construction.jpg
slides/why-chicken-breast/assets/images/eggs-tray.jpg
slides/why-chicken-breast/assets/images/chicken-breast-raw.jpg
slides/why-chicken-breast/assets/images/protein-scoop.jpg
```

## 備考

classmethod公式テンプレート版（`slides/why-chicken-breast-classmethod/`）は白背景・ライトテーマ向けの別プロンプトを使っている。そちらは明るく清潔感のあるトーンで、本ファイルとは別に管理する。
