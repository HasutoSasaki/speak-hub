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
DynamoDB の Scan と Query、どちらを使うべきか。
検証データをもとに、その境界線を明らかにします。
-->

---

<ProfileCard />

---

## layout: statement

# "Scan は避けるべき"

---

## よく聞く話

- Scan は全データを読み込むから遅い
- GSI を使ってコストを抑えるべき
- RCU の消費量に大きな差が出る

<div v-click class="mt-10">

## ...でも、実際どれくらい差が出るの？

</div>

<!--
DynamoDB を学ぶと必ず聞く「Scan は避けるべき」という話。
でも、具体的に何件くらいから問題になるのか、コストはどれくらい違うのか、
実は知らない人が多いのではないでしょうか。
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
知識としては知っているけど、具体的な数値感がわからないと設計時に自信を持てない。
だから実際に検証してみました。
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
小規模から大規模まで、網羅的に検証するために30パターンを用意しました。
対象データは全体の約30%という構成です。
-->

---

## レスポンス時間: 0.5KB

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

---

## レスポンス時間: 1KB

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

---

## レスポンス時間: 5KB

### 大きなレコード

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
倍率だけ見ると大した差に見えませんが、実際の時間差が重要です。
100件では数msの差ですが、100万件 x 5KBでは83秒もの差になります。
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
RCUは一貫して約3.3倍の差。これは対象データが30%だったから。
もし対象が全体の1%なら、Scan は100倍のコストがかかることになります。
-->

---
layout: fact
---

# 83秒

5KB x 100万件での Scan と Query の差

<!--
最大パターンでは Scan に137秒、Query でも54秒。差は83秒。
この規模ではどちらもAPIレスポンスとしては使えません。
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
検証結果から導き出した設計指針です。
1,000件以下ならScanで問題ない。
1万件を超えたらGSIを検討。10万件以上はGSI必須。
-->

---
layout: statement
---

# 検証した事実で設計判断する

<!--
「Scanは遅い」と聞いたから避ける、ではなく、
自分のユースケースではどうなのかを検証して判断する。
それが設計力であり、エンジニアとしての成長につながります。
-->

---
layout: statement
---

# ありがとうございました

<div class="absolute bottom-10 left-10 text-sm opacity-70">
  <p>詳細記事: <a href="https://dev.classmethod.jp/articles/dynamodb-scan-vs-query-benchmark/">DynamoDB Scan vs Query ベンチマーク検証</a></p>
  <p>検証コード: <a href="https://github.com/HasutoSasaki/dynamodb-scan-vs-query-benchmark">github.com/HasutoSasaki/dynamodb-scan-vs-query-benchmark</a></p>
</div>
