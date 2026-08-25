---
theme: apple-basic
colorSchema: light
title: トレーニーはなぜ鶏むね肉を食べ続けるのか
transition: slide-left
---

<!--
生成画像はすべて slides/why-chicken-breast/image-prompts.md のプロンプトを使って用意し、
public/images/ または assets/images/ 配下に同名で配置すると自動的に反映される。
-->

---
layout: intro
---

# トレーニーはなぜ鶏むね肉を食べ続けるのか


<!--
- トレーニーと聞くと何を思い浮かべますか？ 鶏むね肉、プロテイン、ゆで卵
- 「好きだから食べている」という説を今日は検証します
-->

---

<ProfileCard />

<!--
- Sasaki Hasuto です
- classmethod で Web アプリ開発をしています
-->

---
layout: statement
clickAnimation: fade-in.up
---

<div v-click="1" class="text-2xl leading-relaxed opacity-80">彼らは、今日も鶏むね肉を食べる。<br>昨日も。<br>おそらく明日も。</div>
<div v-click="2" class="text-4xl font-700 mt-12">好きだからではない。</div>
<div v-click="3" class="text-2xl mt-12 opacity-80">そこには、ある「数字」が隠されていた。</div>

<!--
- ここはナレーション口調で、1クリックごとに3秒ほど間を置いてから次を読む
- 「好きだからではない」は一段大きく強く読む
- 「今日はその数字の話です」で本編に入る
-->

---

## 本当に好きで食べてるの？

<div class="mt-10 grid grid-cols-2 gap-10">
<div>

<h3 class="opacity-100 text-xl font-700 mb-2">一般的なイメージ</h3>

<p class="text-xl">「筋トレにハマると鶏むね肉ばかり食べるようになる」</p>

</div>
<div>

<h3 class="opacity-100 text-xl font-700 mb-2">今日の結論</h3>

<p class="text-4xl font-700">？？？</p>

</div>
</div>

<!--
- 実は好きだからではありません
- 今日は数字だけで説明します
-->

---
layout: fact
---

# 1.6〜2.2g/kg
体重70kgなら、1日112〜154g必要

<!--
- 筋トレする人はこれだけのタンパク質が必要と言われている
- 出典: Morton et al. 2018 メタアナリシス（飽和点1.62g/kg）、ISSN Position Stand 2017（1.4〜2.0g/kg）
- この数値の根拠は2017〜2018年の文献だが、2022年の新しいメタアナリシスでも約1.5g/kgで頭打ちという近い結論が出ており、繰り返し検証されて生き残っている値
- じゃあこれってどのくらいの量なのか、次のスライドで見せる
-->

---

## 112gってどれくらい？

<div class="mt-10 grid grid-cols-3 gap-10 text-center">
<div>
  <img src="./assets/images/eggs-tray.jpg" class="h-32 w-full object-cover" />
  <h3 class="opacity-100 text-xl font-700 mt-3">卵換算</h3>
  <p class="text-3xl font-700 mt-1">18〜25個</p>
</div>
<div>
  <img src="./assets/images/chicken-breast-raw.jpg" class="h-32 w-full object-cover" />
  <h3 class="opacity-100 text-xl font-700 mt-3">鶏むね肉換算</h3>
  <p class="text-3xl font-700 mt-1">約500〜650g</p>
</div>
<div>
  <img src="./assets/images/protein-scoop.jpg" class="h-32 w-full object-cover" />
  <h3 class="opacity-100 text-xl font-700 mt-3">プロテイン換算</h3>
  <p class="text-3xl font-700 mt-1">約4〜5杯</p>
</div>
</div>

<!--
- 毎日ゆで卵20個生活は、かなりニワトリ寄りです
- ここで初めて、鶏むね肉という選択肢が現実味を帯びてくる
-->

---
layout: statement
clickAnimation: fade-in.up
---

<div v-click="1" class="text-3xl">トレーニーはプロテインが好きなんじゃありません。</div>
<div v-click="2" class="text-2xl mt-8 opacity-80">鶏むね肉だけで毎日150gのタンパク質を摂ろうとすると、<br>約650gの鶏むね肉を、一週間食べ続けることになります。</div>
<div v-click="3" class="text-4xl font-700 mt-12">たぶん、2日目にはプロテインを買いに行きます。</div>

<!--
- ここが一番伝えたい一言
- 150gは体重70kgの必要量112〜154gの範囲内、誇張ではなく実際の数字
- 鶏むね肉(皮なし)は可食部100gあたりタンパク質約23gなので、150g÷0.23≈約650g
- 最後の1行はオチなので、少し間を置いてから読む
-->

---

## よくある誤解① ゴールデンタイム

<div class="mt-10 grid grid-cols-2 gap-10">
<div>

<h3 class="opacity-100 text-xl font-700 mb-2">思われていること</h3>

<p class="text-xl">「運動後30分以内に飲まないと意味がない」</p>

</div>
<div>

<h3 class="opacity-100 text-xl font-700 mb-2">実際は</h3>

<p class="text-2xl font-700">総摂取量の方が重要</p>

<p class="text-sm opacity-80 mt-4">Casuso &amp; Goossens, Nutrients 2025</p>

</div>
</div>

<!--
- 筋タンパク質合成は運動後24〜48時間持続する
- 過去に「タイミング効果あり」とされた研究は、実は総摂取量も群間で違っていた
-->

---
layout: image-right
image: /images/house-construction.jpg
---

## よくある誤解②
### 「ご飯を多く食べればよくない？」

<p class="text-xl">炭水化物・脂質は、炭素・水素・酸素だけでできている</p>

<div class="text-xl leading-relaxed mt-4">

- アミノ酸（タンパク質）だけが窒素を含む
- 筋肉の材料になるのは、この窒素を含むアミノ酸
- 必須アミノ酸9種は体内で合成できない
- ご飯（炭水化物）をいくら増やしても、窒素は補充されない

</div>

<!--
- 炭水化物・脂質・アミノ酸は、いずれもエネルギー源になれる
- ただし筋肉の材料（アミノ酸の再合成）に使えるのは窒素を含むアミノ酸だけ
- 必須アミノ酸9種は体内で合成できないので、食事から摂るしかない
-->

---
layout: fact
---

# +1.2kg vs +0.1kg
筋肉量の変化（高タンパク質群 vs 低タンパク質群）
同じ運動・同じカロリー制限。違いはタンパク質量だけ。

<!--
- Longland et al. 2016（AJCN）
- 40%カロリー欠損・同じ運動メニューで、タンパク質量だけ2.4g/kg vs 1.2g/kgに分けた4週間の介入
- 高タンパク群は除脂肪体重+1.2kg、低タンパク群は+0.1kg
- カロリーだけでは説明できませんでした
-->

---
layout: bullets
---

# 今日伝えたかったこと

* 必要量は意外と多い
* だから鶏むね肉になる
* だからプロテインになる
* 都市伝説も意外と多い

---
layout: intro
---

# トレーニーはなぜ鶏むね肉を食べ続けるのか

<!--
- タイトルを再掲して3秒間を置く
-->

---
layout: statement
---

# 好きだからではない。
# 数字に従った結果だった。

---
layout: fact
---

# 1.6〜2.2g/kg
答えは、これだけだった。

<!--
- 最初に見せた数字がもう一度出てくる、という一本の線の締め
-->

---
layout: quote
---

# 筋肉は気合いではなく、エビデンスでできている。
