---
theme: default
class: text-center
transition: "slide-left"
colorSchema: light
highlighter: shiki
lineNumbers: true
title: トレーニーはなぜ鶏むね肉を食べ続けるのか
defaults:
  fonts:
    sans: Calibri
---

<!--
生成画像は slides/why-chicken-breast/image-prompts.md のプロンプトを使って用意し、
assets/images/ 配下に同名で配置すると自動的に反映される。
-->

<div class="bg-[#F3F3F3] flex flex-col items-center min-h-screen">
    <img src="./assets/images/logo_blk_20221223.svg" alt="classmethod" class="scale-30 mt-15">
    <div>
        <div class="text-center font-bold text-black text-[40.5px]">トレーニーはなぜ鶏むね肉を<br />
        食べ続けるのか
        </div>
        <div class="text-center text-lg text-black mb-4 mt-10">
          筋肉、その見えない設計思想
        </div>
    </div>
</div>

<!--
- トレーニーと聞くと何を思い浮かべますか？ 鶏むね肉、プロテイン、ゆで卵
- 「好きだから食べている」という説を今日は検証します
-->

---

<div class="bg-[#F3F3F3] flex flex-col items-start min-h-screen pl-15">
  <div class="font-bold text-[#434343] text-[31px] mt-60">
    トレーニーと聞くと、<br />
    何を思い浮かべますか？
  </div>
</div>

<!--
- 鶏むね肉、プロテイン、ゆで卵
- 「好きだから食べている」という説を今日は検証します
-->

---

# 自己紹介

<Transform :scale=0.8>

- 名前（ニックネーム）
  - Hasuto（Sasaki Hasuto）
- 役職
  - Server-side Engineer
- 経歴
  - 2023.04〜 SES企業 フロントエンドエンジニア（Vue.js / Nuxt.js + Lambda / DynamoDB）
  - 2026.01〜 クラスメソッド株式会社 サーバーサイドエンジニア（TypeScript / React + Lambda / DynamoDB）
- 趣味・嗜好
  - 筋トレ・アニメ・低レイヤー・Golang・Neovim

</Transform>

<img src="./assets/images/avatar.jpeg" alt="Hasuto" class="absolute bottom-30 right-30 h-32 w-32 scale-160">

---

# 本当に好きで食べてるの？

<div grid="~ cols-2 gap-4" m="t-10">

<div>
  <p class="text-[18px] font-bold">一般的なイメージ</p>
  <p class="text-[14px] mt-4">「筋トレを始めると鶏になる」と言われがちです。</p>
</div>

<div>
  <p class="text-[18px] font-bold">今日の結論</p>
  <p class="text-[14px] mt-4">実は「好きだから」ではありません。今日は数字だけで説明します。</p>
</div>

</div>

<!--
- 実は好きだからではありません
- 今日は数字だけで説明します
-->

---

  <div class="flex items-center justify-center mt-40">
    <div class="text-center font-bold text-[#262626] text-[37px]">
      1.6〜2.2g/kg
      <br>
      体重70kgなら、1日112〜154g必要
    </div>
  </div>

<!--
- 筋トレする人はこれだけのタンパク質が必要と言われている
- 出典: Morton et al. 2018 メタアナリシス（飽和点1.62g/kg）、ISSN Position Stand 2017（1.4〜2.0g/kg）
- この数値の根拠は2017〜2018年の文献だが、2022年の新しいメタアナリシスでも約1.5g/kgで頭打ちという近い結論が出ており、繰り返し検証されて生き残っている値
- じゃあこれってどのくらいの量なのか、次のスライドで見せる
-->

---

# 112gってどれくらい？

<div grid="~ cols-3 gap-4" m="t-10">

<div class="text-center">
  <img src="./assets/images/eggs-tray.jpg" class="h-24 w-full object-cover">
  <p class="text-[16px] font-bold mt-2">卵換算</p>
  <p class="text-[14px]">18〜25個</p>
</div>

<div class="text-center">
  <img src="./assets/images/chicken-breast-raw.jpg" class="h-24 w-full object-cover">
  <p class="text-[16px] font-bold mt-2">鶏むね肉換算</p>
  <p class="text-[14px]">約500〜650g</p>
</div>

<div class="text-center">
  <img src="./assets/images/protein-scoop.jpg" class="h-24 w-full object-cover">
  <p class="text-[16px] font-bold mt-2">プロテイン換算</p>
  <p class="text-[14px]">約4〜5杯</p>
</div>

</div>

<!--
- 毎日ゆで卵20個生活は、かなりニワトリ寄りです
- ここで初めて、鶏むね肉という選択肢が現実味を帯びてくる
-->

---

  <div class="flex items-center justify-center mt-40">
    <div class="text-center font-bold text-[#262626] text-[37px]">
      好きだからじゃない。
      <br>
      物理的に無理だから。
    </div>
  </div>

<!--
- ここが一番伝えたい一言
-->

---

# よくある誤解① タイミング神話

  <div class="flex items-center justify-center mt-40">
    <div class="text-center text-[#DF3756] text-[37px]">
      「運動後30分以内に飲まないと
      <br>
      意味がない」
    </div>
  </div>

<!--
- これが世間で言われている誤解
-->

---

  <div class="flex items-center justify-center mt-40">
    <div class="text-center text-[#2C67E5] text-[37px]">
      実は、総摂取量の方が
      <br>
      重要でした。
    </div>
  </div>

<p class="text-center text-[12px] text-gray-500 mt-4">Casuso &amp; Goossens, Nutrients 2025</p>

<!--
- 筋タンパク質合成は運動後24〜48時間持続する
- 過去に「タイミング効果あり」とされた研究は、実は総摂取量も群間で違っていた
-->

---

# よくある誤解② 腎臓への影響

  <div class="flex items-center justify-center mt-40">
    <div class="text-center text-[#DF3756] text-[37px]">
      「タンパク質の摂りすぎは
      <br>
      腎臓に悪い」
    </div>
  </div>

---

  <div class="flex items-center justify-center mt-40">
    <div class="text-center text-[#2C67E5] text-[37px]">
      健康な人には
      <br>
      根拠がありませんでした。
    </div>
  </div>

<p class="text-center text-[14px] text-gray-600 mt-4">既往の腎疾患がある人は別</p>
<p class="text-center text-[12px] text-gray-500 mt-2">Devries et al., J Nutr 2018</p>

<!--
- 健康な人と腎疾患がある人の混同が誤解の元
-->

---

# よくある誤解③「ご飯を多く食べればよくない？」

- 筋肉を「家」に例えると
  - タンパク質 = 材料
  - 炭水化物 = エネルギー
  - 電気だけあっても家は建たない
  - 材料だけあっても職人が動けない

<div class="flex items-center justify-center mt-10 scale-95">
  <img src="./assets/images/house-construction.jpg" alt="家の建築" class="h-56">
</div>

<!--
- 炭水化物・脂質は炭素・水素・酸素のみで構成されるエネルギー源
- アミノ酸は窒素を含むのが本質的な違い。必須アミノ酸9種は体内で合成できない
- 炭水化物をいくら摂っても、筋肉の材料である窒素は補充されない
-->

---

# 実験してみた

<div grid="~ cols-2 gap-4" m="t-10">

<div class="text-center">
  <div class="text-[30px] font-bold text-[#2C67E5]">+1.2kg</div>
  <p class="text-[18px] mt-2">高タンパク群</p>
</div>

<div class="text-center">
  <div class="text-[30px] font-bold text-[#DF3756]">+0.1kg</div>
  <p class="text-[18px] mt-2">低タンパク群</p>
</div>

</div>

<p class="text-center text-[14px] text-gray-500 mt-4">同じ運動・同じカロリー制限。違いはタンパク質量だけ。</p>

<!--
- Longland et al. 2016（AJCN）
- 40%カロリー欠損・同じ運動メニューで、タンパク質量だけ2.4g/kg vs 1.2g/kgに分けた4週間の介入
- カロリーだけでは説明できませんでした
-->

---

# 今日伝えたかったこと

- 必要量は意外と多い
- だから鶏むね肉になる
- だからプロテインになる
- 都市伝説も意外と多い

---

<div class="bg-[#F3F3F3] flex flex-col items-center min-h-screen">
    <img src="./assets/images/logo_blk_20221223.svg" alt="classmethod" class="scale-30 mt-15">
    <div>
        <div class="text-center font-bold text-black text-[40.5px] mt-25">トレーニーはなぜ鶏むね肉を<br />
        食べ続けるのか
        </div>
    </div>
</div>

<!--
- タイトルを再掲して3秒間を置く
-->

---

  <div class="flex items-center justify-center mt-40">
    <div class="text-center font-bold text-[#262626] text-[37px]">
      好きだからではない。
      <br>
      数字に従った結果だった。
    </div>
  </div>

---

<SectionTitle message="筋肉は気合いではなく、エビデンスでできている。"></SectionTitle>

---

<div class="bg-white flex items-center justify-center h-full">
  <img src="./assets/images/logo_blk_20221223.svg" alt="おわり" class="scale-40">
</div>
