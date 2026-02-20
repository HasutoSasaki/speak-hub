---
theme: apple-basic
colorSchema: dark
title: DynamoDB Scan vs Query 〜検証で見えた境界線〜
transition: slide-left
layout: intro
---

# DynamoDB Scan vs Query

検証で見えた境界線

<div class="absolute bottom-10">
  <span class="font-700">
    @HasutoSasaki
  </span>
</div>

<!--
- DynamoDB Scan vs Query 〜検証で見えた境界線〜
- AWS の DynamoDB において「Scan は避けるべき」→ よく聞くけど、何件からどれくらい差が出る？
- 実際にベンチマークを取って検証した結果をお見せする
-->

---

<ProfileCard />

<!--
- Sasaki Hasuto と申します。
- 現在は、classmethod でWebアプリ開発に携わっている
- DynamoDB の設計に迷ったのが検証のきっかけ
- 趣味は筋トレ、アニメ、低レイヤー技術、Golang、Neovimとかで、
- 目標として今年はベンチプレス 100kg を目指している
-->

---
layout: fact
---

# 自分の手で検証する

自分の手で得た経験は **自分だけの武器** になる

<!--
- 今日の裏メッセージ：「自分の手で検証する」
- AI に聞けば答えは返ってくる時代
- でも自分で動かして得た経験は、コピペでは手に入らない
- この発表が検証してみるきっかけになれば嬉しい
-->

---

## 今日持ち帰ってほしいこと

<div class="mt-6 grid grid-cols-2 gap-8">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20">

**技術的な知見**

Scan と Query の性能差を数値で理解する

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20">

**それ以上に大事なこと**

<span v-mark.underline="{ color: '#F59E0B', at: 1 }">自分の手で検証する姿勢</span>

</div>
</div>

<div v-click class="mt-4 opacity-90">

この2つを軸に、DynamoDB の Scan と Query を検証した結果をお話しします

</div>

<!--
- 持ち帰ってほしいことは2つ
- ① 技術的な知見：Scan vs Query の性能差を数値で
- ② 自分の手で検証する姿勢
- この2軸でベンチマーク結果をお話しする
-->

---

## DynamoDB とは

<div class="grid grid-cols-2 gap-6 mt-4">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20">

**AWS のフルマネージド NoSQL DB**

- サーバーレスで運用負荷が少ない
- Key-Value 型の NoSQL
- PK 指定の取得は一桁ミリ秒のレスポンス

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20">

**キー設計がすべて — 図書館で例えると**

- <span class="text-amber-400 font-bold">Partition Key (PK)</span> — 本棚の「棚番号」
- <span class="text-amber-400 font-bold">Sort Key (SK)</span> — 棚の中の「並び順」
- PK が同じデータは同じ棚に格納される

</div>
</div>

<div v-click class="mt-6 opacity-90">

RDB のように自由な WHERE 句は使えない → <strong>どの棚に・どう並べるか</strong>を最初に設計する必要がある

</div>

<!--
- AWS フルマネージド NoSQL、サーバーレス
- PK 指定の取得なら一桁 ms
- 図書館の例：PK = 棚番号、SK = 棚の中の並び順
- 「どの棚に・どう並べるか」を最初に設計する必要がある
- WHERE 句が自由に使えない → 設計ミスると Scan に頼ることに
-->

---

## Scan と Query（GSI）の仕組み

<div class="grid grid-cols-2 gap-6 mt-4">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20">

<p class="text-m font-600 tracking-wide text-amber-400 !mb-2">Scan</p>

テーブル **全体** を読み込み、FilterExpression で絞り込む

- 全パーティションを順番に走査
- フィルタは読み込み **後** に適用
- 読み込んだデータ分だけ RCU を消費

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20">

<p class="text-m font-600 tracking-wide text-amber-400 !mb-2">Query（GSI 利用）</p>

**必要なパーティション** だけを読み込む

- GSI = テーブルとは別のキーで検索できるインデックス
- PK 指定で対象パーティションに直行
- 読み込むデータ量が最小限で済む

</div>
</div>

<div v-click class="mt-6 opacity-90">

つまり Scan は「本棚を端から全部見る」、Query は「索引で目的のページを開く」

</div>

<!--
- Scan：全体を読み込み → フィルタは読み込み後に適用 → 不要データ分も RCU 消費
- Query：PK 指定で必要なパーティションだけ読む
- GSI = 元のキーとは別のキーで Query できるインデックス
- Scan = 本棚を端から全部見る、Query = 索引で目的のページを開く
-->

---
layout: statement
---

## では本題に入ります。

---
layout: statement
---

# "Scan は避けるべき"

<!--
- 必ず最初に言われるフレーズ
- 正しいけど、実際どれくらい差がある？ → 掘り下げた
-->

---

## よく聞く話

- Scan は全データを読み込むから遅い
- GSI を使ってコストを抑えるべき
- RCU の消費量に大きな差が出る

<div v-click class="mt-10">

## ...でも、実際どれくらい差が出るの？

</div>

<!--
- ドキュメントや入門記事でよく見る話
- 「数百件でも差は出る？」「何件から問題？」→ 答えに詰まる
- 自分もまさにそうだった
-->

---

## 設計で自信が持てなかった

<div class="mt-6 grid grid-cols-2 gap-8">
<div>

**知っていたこと**

- Scan はテーブル全体を読む
- GSI を使えば効率的にクエリできる
- RCU コストに差が出る

</div>
<div>

**わからなかったこと**

- 数百件でも差は出るの？
- 何件から実用上問題になる？
- レコードサイズの影響は？

</div>
</div>

<div v-click class="mt-8">

**「聞いた話」ではなく「検証した事実」で判断したい**

</div>

<!--
- なぜ検証しようと思ったのか
- 左：教科書的に知っていたこと
- 右：実際にはわからなかったこと
- 「聞いた話」ではなく「検証した事実」で判断したい → 検証を始めた
-->

---

## 検証設計: 計30パターン

<table>
  <thead>
    <tr><th>項目</th><th>内容</th></tr>
  </thead>
  <tbody>
    <tr v-mark.box="{ color: '#F59E0B', at: 1 }"><td><strong>データサイズ</strong></td><td>0.5KB / 1KB / 5KB (3種)</td></tr>
    <tr v-mark.box="{ color: '#F59E0B', at: 2 }"><td><strong>データ件数</strong></td><td>100 / 1,000 / 10,000 / 100,000 / 1,000,000 (5種)</td></tr>
    <tr><td><strong>比較手法</strong></td><td>Scan vs Query (GSI)</td></tr>
    <tr><td><strong>実行環境</strong></td><td>AWS Lambda (Node.js 24.x / 1024MB)</td></tr>
    <tr v-mark.box="{ color: '#F59E0B', at: 3 }"><td><strong>計測方法</strong></td><td>各パターン5回計測の平均値</td></tr>
    <tr><td><strong>モード</strong></td><td>オンデマンド / 結果整合性読み込み</td></tr>
    <tr><td><strong>対象データ割合</strong></td><td>全体の約30%</td></tr>
  </tbody>
</table>

<div v-click="4" class="mt-4 opacity-90">

注目: 対象データは全体の <span v-mark.underline="{ color: '#F59E0B', at: 4 }">約30%</span> — この割合が後の結果に大きく影響する

</div>

<!--
- 3サイズ × 5件数 × 2手法 = 計30パターン
- Lambda Node.js 24.x、各5回の平均値
- 注目：ヒット率は約30% → Scan は残り70%も読んでいる
- この割合が後の結果に大きく影響
-->

---
layout: fact
---

## 検証結果を見ていきましょう。


---

## レスポンス時間の比較 <span class="text-sm font-600 tracking-wide text-amber-400 ml-4">レコードサイズ: 0.5KB</span>

<table>
  <thead>
    <tr><th>件数</th><th>Scan</th><th>Query</th><th>差分</th></tr>
  </thead>
  <tbody>
    <tr><td><strong>100</strong></td><td>13ms</td><td>7ms</td><td>6ms</td></tr>
    <tr><td><strong>1,000</strong></td><td>40ms</td><td>28ms</td><td>12ms</td></tr>
    <tr><td><strong>10,000</strong></td><td>169ms</td><td>151ms</td><td>18ms</td></tr>
    <tr><td><strong>100,000</strong></td><td>1.7s</td><td>1.1s</td><td>0.6s</td></tr>
    <tr v-mark.box="{ color: '#F59E0B', at: 1 }"><td><strong>1,000,000</strong></td><td>15.9s</td><td>9.8s</td><td>6.1s</td></tr>
  </tbody>
</table>

<div v-click>

小さなレコードでも、100万件規模では <span v-mark.underline="{ color: '#F59E0B' }">**6秒の差**</span>

</div>

<!--
- 0.5KB：100件〜1,000件は誤差レベル（数ms〜12ms）
- 件数が増えるにつれ差が開く
- 100万件：Scan 16s vs Query 10s → 小さなレコードでも6秒差
-->

---

## レスポンス時間の比較 <span class="text-sm font-600 tracking-wide text-amber-400 ml-4">レコードサイズ: 1KB</span>

<table>
  <thead>
    <tr><th>件数</th><th>Scan</th><th>Query</th><th>差分</th></tr>
  </thead>
  <tbody>
    <tr><td><strong>100</strong></td><td>14ms</td><td>8ms</td><td>6ms</td></tr>
    <tr><td><strong>1,000</strong></td><td>30ms</td><td>26ms</td><td>4ms</td></tr>
    <tr><td><strong>10,000</strong></td><td>256ms</td><td>195ms</td><td>61ms</td></tr>
    <tr><td><strong>100,000</strong></td><td>2.5s</td><td>1.8s</td><td>0.7s</td></tr>
    <tr v-mark.box="{ color: '#F59E0B', at: 1 }"><td><strong>1,000,000</strong></td><td>26.3s</td><td>18.7s</td><td>7.6s</td></tr>
  </tbody>
</table>

<div v-click>

1万件を超えると差が顕著に。100万件では <span v-mark.underline="{ color: '#F59E0B' }">**7.6秒の差**</span>

</div>

<!--
- 1KB：1万件から差が出始める（61ms）
- 100万件：26.3s vs 18.7s → 7.6秒差
- 倍率は1.4倍だが、実時間7.6秒はユーザー体験に直結
-->

---

## レスポンス時間の比較 <span class="text-sm font-600 tracking-wide text-amber-400 ml-4">レコードサイズ: 5KB</span>

<table>
  <thead>
    <tr><th>件数</th><th>Scan</th><th>Query</th><th>差分</th></tr>
  </thead>
  <tbody>
    <tr><td><strong>100</strong></td><td>17ms</td><td>13ms</td><td>4ms</td></tr>
    <tr><td><strong>1,000</strong></td><td>97ms</td><td>83ms</td><td>14ms</td></tr>
    <tr><td><strong>10,000</strong></td><td>1,041ms</td><td>612ms</td><td>429ms</td></tr>
    <tr v-mark.box="{ color: '#F59E0B', at: 1 }"><td><strong>100,000</strong></td><td>10.5s</td><td>5.2s</td><td>5.3s</td></tr>
    <tr v-mark.box="{ color: '#F59E0B', at: 2 }"><td><strong>1,000,000</strong></td><td><strong>137s</strong></td><td><strong>54s</strong></td><td><strong>83s</strong></td></tr>
  </tbody>
</table>

<div v-click>

レコードサイズが大きいと差は爆発的に拡大 → <span v-mark.highlight="{ color: '#F59E0B33' }">**83秒の差**</span>

</div>

<!--
- 5KB：差が爆発的に広がる
- 1万件で Scan が1秒超え、10万件で5.3秒差
- 100万件：137s vs 54s → 83秒差、システムとして成り立たない
-->

---

## 結果: RCU 消費量

| 件数                | Scan RCU | Query RCU | 倍率 |
| ------------------- | -------- | --------- | ---- |
| **100** (0.5KB)     | 7        | 2         | 3.5x |
| **1,000** (1KB)     | 121      | 37        | 3.3x |
| **10,000** (5KB)    | 6,208    | 1,863     | 3.3x |
| **100,000** (5KB)   | 62,079   | 18,626    | 3.3x |
| **1,000,000** (5KB) | 620,773  | 186,163   | 3.3x |

<div v-click="1" class="mt-6 opacity-90">

**なぜ約<span v-mark.circle="{ color: '#F59E0B', at: 1 }">3.3倍</span>？** 対象データが全体の約30%のため、Scan は残り70%分も読み込んでいる

</div>

<div v-click="2" class="mt-2 opacity-90">

ヒット率が下がるほど、コスト差は <span v-mark.underline="{ color: '#F59E0B', at: 2 }">さらに拡大</span> する

</div>

<!--
- サイズ・件数によらず Scan は Query の約3.3倍の RCU
- 理由：ヒット率30% → 残り70%も読んでいるから
- ヒット率1%なら100倍近くになる → ヒット率が下がるほど差は拡大
-->

---
layout: fact
---

# 83秒

5KB x 100万件での Scan と Query の差

<!--
- 83秒。Scan 137s vs Query 54s
- この規模ではどちらも同期レスポンスとしては厳しい
- ただ、GSI の設計が不可欠なのは明らか
-->

---

## 設計判断の指針

<div v-click="1">

<p class="text-sm font-600 tracking-wide text-amber-400 !mt-4 !mb-1">〜1,000件</p>

**Scan で十分** — GSI の管理コストを避けられる

</div>

<div v-click="2">

<p class="text-sm font-600 tracking-wide text-amber-400 !mt-4 !mb-1">1万〜10万件</p>

**GSI 推奨** — 時間差・RCU差が顕著になり始める

</div>

<div v-click="3">

<p class="text-sm font-600 tracking-wide text-amber-400 !mt-4 !mb-1">10万件〜</p>

<span v-mark.box="{ color: '#F59E0B', at: 3 }">**GSI 必須**</span> — Scan では許容できない遅延が発生

</div>

<!--
- 〜1,000件：Scan で十分。GSI は書き込みコストも増えるのでシンプルに
- 1万〜10万件：GSI 推奨。数百ms〜数秒の差、RCU 3倍以上
- 10万件〜：GSI 必須。Scan では秒単位の遅延
- 「Scan が絶対ダメ」ではなく、ユースケースに応じて選ぶ
-->

---
layout: statement
---

# 自分の手で検証する

<!--
- 最初のメッセージに戻る
- 「聞いたから避ける」ではなく、自分で動かして判断する
- 検証したからこそ自信を持って言える
- 気になったら手を動かしてみてほしい
-->

---
layout: statement
---

# ありがとうございました

<div class="absolute bottom-10 left-10 text-sm opacity-70 text-left">
  <p>詳細記事: <a href="https://dev.classmethod.jp/articles/dynamodb-scan-vs-query-benchmark/">DynamoDB Scan vs Query ベンチマーク検証</a></p>
  <p>検証コード: <a href="https://github.com/HasutoSasaki/dynamodb-scan-vs-query-benchmark">github.com/HasutoSasaki/dynamodb-scan-vs-query-benchmark</a></p>
</div>

<!--
- 詳細は DevelopersIO の記事に
- 検証コードも GitHub で公開中
- 質問があればお気軽に
-->
