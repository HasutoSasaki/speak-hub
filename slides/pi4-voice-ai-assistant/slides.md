---
theme: apple-basic
colorSchema: light
title: Pi4に話しかけたらClaudeが答えてくれた
transition: slide-left
layout: intro
---

# Pi4を声で話せる相棒にしてみた

呼んだら話を聞いてくれる、机の上のラズパイ

<div class="absolute bottom-10">
  <span class="font-700">
    @HasutoSasaki
  </span>
</div>

<!--
- Pi4 に話しかけると Claude Code が音声で答えてくれるデバイスを作った話
-->

---

<ProfileCard />

<!--
- Hasuto です。2026年1月からクラスメソッドでサーバーサイドを書いています
- 低レイヤーとガジェットが好きで、今回 Pi4 で遊びました
-->

---

<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-1"><carbon:favorite class="inline mr-1" />ところでガジェット愛好家の皆さん</p>

# 分割キーボードに興味があります

<div class="mt-4 grid grid-cols-[auto_1fr] gap-8 items-center">

<img src="./assets/images/keyball44.png" class="max-h-[300px] rounded-xl shadow-md" alt="Keyball44 分割キーボード" />

<div>
<p class="!text-2xl !m-0 leading-relaxed font-bold"><span class="text-blue-600">Keyball44</span> が欲しい</p>
<p class="!text-lg !mt-4 !m-0 opacity-80 leading-relaxed">でも、自分でハンダ付けして組み立てる自信がなくて<br>まだ手が出せていない…</p>

<p class="!text-base !mt-6 !m-0 opacity-70">組み立てたことある方、<br>コツを教えてください！</p>
</div>

</div>

<!--
- ちょっと自己紹介の延長で、ガジェット好きとして気になっているものを
- Keyball44 という分割キーボード、前から欲しいんですが、ハンダ付けで組み立てるタイプなので自信がなくて手が出せていません
- 今日来ている皆さんで自作キーボード組んだことある方、ぜひコツを教えてください
-->

---

# 相棒の姿

<div class="mt-4 grid grid-cols-[1fr_auto] gap-8 items-center">

<div>
<p class="!text-2xl !m-0 leading-relaxed">Raspberry Pi 4 に話しかけると<br>Claude Code が音声で答える</p>
<p class="!text-lg !mt-6 !m-0 opacity-70 leading-relaxed">「ラズパイ」で起動、<br>「おやすみラズパイ」で待機に戻る</p>
</div>

<img src="./assets/images/IMG_1711.jpeg" class="max-h-[340px] rounded-xl shadow-md" alt="Raspberry Pi 4 にピンマイクと3.5mmイヤホンを接続した実機" />

</div>

<p class="!text-sm !mt-6 text-center opacity-60">Pi4（4GB）＋ USBピンマイク ＋ 3.5mmイヤホン</p>

<!--
- 作ったのはこれ、"声で話せる相棒"
- Pi4 に話しかけると Claude Code が音声で返してくれるデバイス
- 「ラズパイ」で起動、「おやすみラズパイ」で待機
- ハードは Pi4 にマイクとイヤホン挿しただけのシンプル構成
-->

---

<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-1">最近の学び方</p>

# なぜ作ったか

<div class="mt-10">


<p class="!text-2xl !m-0 leading-relaxed">AI に聞く → 答えが返る → 終わり</p>
<p class="!text-xl !mt-3 !m-0 opacity-70 leading-relaxed">便利すぎて、自分で考える力が落ちている実感があった</p>

<p v-click class="!text-3xl !mt-12 !m-0 font-bold text-blue-600 leading-relaxed">声に出して話すと、学びは頭に残る</p>
<p v-click class="!text-xl !mt-3 !m-0 opacity-80 leading-relaxed">いつでも呼びかけて会話できる"相棒"が欲しかった</p>

</div>

<!--
- 最近、何か分からないことがあるとすぐ AI に聞いて、答えをもらって終わり、というループが増えていた
- 便利なんだけど、自分で考える力が落ちてる実感があった
- 振り返ると、学びが一番定着するのは自分の考えを声に出してアウトプットするとき
- Claude Code のボイスモードでも同じことはできるけど、毎回 PC 立ち上げてターミナル開くのは面倒で続かない
- いつでも声をかけたら会話が始まるデバイスが手元にあれば、学習のハードルが下がる
-->

---

# なぜ Pi4 で作ったか

<div class="absolute inset-0 flex items-center justify-center">
  <p v-click class="!text-5xl font-bold !m-0 leading-relaxed transition-all duration-500">ラズパイを触ってみたかったから</p>
</div>

<!--
- 正直、最初は「Pi4 を触ってみたかった」が先にあった
- 用途は後付けで、話の種としてこれを作った
-->

---

# なぜ Claude Code にしたか

<div class="mt-10 grid grid-cols-2 gap-6">

<div class="bg-black/5 p-6 rounded-xl border border-black/10 shadow-sm">
<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-3"><carbon:notebook class="inline mr-1" />学びの蓄積先が揃っている</p>
<p class="!text-xl font-bold !m-0 leading-relaxed"><code>workspace</code> リポジトリで<br>学びと日記を管理している</p>
<p class="!text-base !mt-3 !m-0 opacity-70">社用も私用も、話したこと・<br>学んだことをここに残したい</p>
</div>

<div class="bg-black/5 p-6 rounded-xl border border-black/10 shadow-sm">
<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-3"><carbon:tool-kit class="inline mr-1" />既存資産をそのまま使える</p>
<p class="!text-xl font-bold !m-0 leading-relaxed">普段使っている <span class="font-mono">skill</span> が<br>そのまま効く</p>
<p class="!text-base !mt-3 !m-0 opacity-70">学習スタイル、校正、日報生成…<br>手に馴染んだ資産を活かせる</p>
</div>

</div>

<!--
- なぜ API 直叩きじゃなく Claude Code なのか
- 普段から workspace というリポジトリを社用/私用の両方で使って、学びや日記を管理している
- 声で話したこと・学んだことも、そのリポジトリに自然に蓄積したい
- さらに Claude Code なら、普段使っている skill（学習スタイル、校正、日報生成など）がそのまま効く
- 既存の仕組みに乗れるのが最大の理由
-->

---

<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-1"><carbon:education class="inline mr-1" />動いてるところ ①</p>

# 学びの相棒として

<div class="mt-4 flex justify-center">
  <img src="./assets/images/log-learning.png" class="max-h-[340px] rounded-lg border border-black/10 shadow-md" alt="会話ログ：ReactのuseStateについて学びたいですと尋ねたら、Claudeが詳細に解説してくれた" />
</div>

<p class="!text-2xl !mt-8 text-center !m-0">「React の useState について学びたい」</p>
<p class="!text-2xl !mt-3 text-center !m-0 font-bold text-blue-600">→ Claude が例え付きで解説</p>

<!--
- 学びの相棒として使っている例
- 「React の useState について学びたいです」と話しかけたら、Claude が具体例を交えて解説してくれた
- 声で聞いて、声で返ってくる。この往復が頭に残るというのを狙っている
-->

---

<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-1"><carbon:moon class="inline mr-1" />動いてるところ ②</p>

# 待機モードに戻る

<div class="mt-4 flex justify-center">
  <img src="./assets/images/log-sleep.png" class="max-h-[340px] rounded-lg border border-black/10 shadow-md" alt="ログ：『おやすみラズパイ』で待機に戻り、Voskが環境音を拾う様子" />
</div>

<p class="!text-2xl !mt-8 text-center !m-0">「おやすみラズパイ」 → 待機復帰</p>
<p class="!text-xl !mt-3 text-center !m-0 opacity-70">待機中も Vosk が「えーっと」など環境音を拾っている</p>

<!--
- もうひとつの例。「おやすみラズパイ」で待機モードに戻ったところ
- 待機中も Vosk が環境音を拾い続けている（「えーっと」「ん」など）
- ウェイクワード以外は無視するので、AWS 課金は発生しない
-->

---

# ざっくり技術スタック

<div class="mt-8 grid grid-cols-2 gap-6">

<div class="bg-black/5 p-6 rounded-xl border border-black/10 shadow-sm">
<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-2"><carbon:chat class="inline mr-1" />ウェイク検出</p>
<p class="!text-2xl font-bold !m-0">Vosk</p>
<p class="!text-base !mt-1 !m-0 opacity-70">ローカル音声認識</p>
</div>

<div class="bg-black/5 p-6 rounded-xl border border-black/10 shadow-sm">
<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-2"><carbon:headphones class="inline mr-1" />音声 → テキスト</p>
<p class="!text-2xl font-bold !m-0">AWS Transcribe</p>
<p class="!text-base !mt-1 !m-0 opacity-70">クラウドSTT</p>
</div>

<div class="bg-black/5 p-6 rounded-xl border border-black/10 shadow-sm">
<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-2"><carbon:machine-learning-model class="inline mr-1" />AI応答</p>
<p class="!text-2xl font-bold !m-0">Claude Code</p>
<p class="!text-base !mt-1 !m-0 opacity-70"><code>-p --model haiku</code></p>
</div>

<div class="bg-black/5 p-6 rounded-xl border border-black/10 shadow-sm">
<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-2"><carbon:volume-up class="inline mr-1" />テキスト → 音声</p>
<p class="!text-2xl font-bold !m-0">Amazon Polly</p>
<p class="!text-base !mt-1 !m-0 opacity-70">クラウドTTS</p>
</div>

</div>

<!--
- ざっくり使った技術の紹介
- ウェイクワード検出は Vosk（ローカル）、常時聞いてるけど課金なし
- 会話モードでは Transcribe で音声→テキスト、Claude Code で応答生成、Polly で音声化
- クラウドに頼ることで Pi4 の CPU 負荷を抑えた構成
-->

---

# 動作：待機 と 会話 の2モード

```mermaid {scale: 1.2}
%%{init: {
  'theme': 'base',
  'themeVariables': {
    'primaryColor': '#dbeafe',
    'primaryTextColor': '#1e3a8a',
    'primaryBorderColor': '#2563eb',
    'lineColor': '#64748b',
    'secondaryColor': '#eff6ff',
    'tertiaryColor': '#f8fafc',
    'fontSize': '20px'
  }
}}%%
stateDiagram-v2
    [*] --> 待機
    待機 --> 会話: "ラズパイ"
    会話 --> 待機: "おやすみラズパイ"
```

<p class="!text-xl !mt-4 text-center opacity-80">待機中はローカル Vosk のみ<span class="mx-3">/</span>会話中の質問ごとに AWS を呼ぶ</p>

<!--
- 状態機械で組み立てた
- 待機中はローカル Vosk だけ動かして課金ゼロ
- ウェイクワードで会話モードに入り、質問するたびに AWS パイプラインが走る
- これで常時起動でも AWS 料金を最小化できる
-->

---

# 技術選定：ローカルは遅かった

<div class="mt-10 grid grid-cols-2 gap-8">
<div class="bg-black/5 p-8 rounded-xl border border-black/10 shadow-sm">

<p class="!text-xl font-bold text-blue-600 !mb-4"><carbon:headphones class="inline mr-2" />音声認識</p>

<p class="!text-lg !m-0 opacity-60 line-through">whisper.cpp — 16秒</p>
<p class="!text-2xl !m-0 font-bold !mt-2">Transcribe — 1.4秒</p>

</div>
<div class="bg-black/5 p-8 rounded-xl border border-black/10 shadow-sm">

<p class="!text-xl font-bold text-blue-600 !mb-4"><carbon:volume-up class="inline mr-2" />音声合成</p>

<p class="!text-lg !m-0 opacity-60 line-through">VOICEVOX — 17〜30秒</p>
<p class="!text-2xl !m-0 font-bold !mt-2">Polly — 0.1秒</p>

</div>
</div>

<p class="!text-xl !mt-10 text-center opacity-80">Pi4 の CPU では厳しい。割り切って AWS に任せる</p>

<!--
- 最初はローカル完結を目指したが Pi4 の CPU だと遅すぎた
- STT 約11倍、TTS 100倍以上の高速化
- 潔くクラウドに任せる判断
-->

---

# 計測してから速くする

<div class="mt-8 text-center">

<p class="!text-6xl font-bold !m-0"><span class="opacity-50">27秒</span> → <span class="text-blue-600">13秒</span></p>

<p class="!text-lg !mt-6 !m-0 opacity-80">体感では「AIが遅い」と思っていたが…</p>

</div>

<div v-click class="mt-8 bg-black/5 p-6 rounded-xl border border-black/10 shadow-sm text-center">

<p class="!text-2xl !m-0 font-bold">計測したら <span class="text-blue-600">STT が一番遅かった</span></p>
<p class="!text-lg !mt-3 !m-0 opacity-80">whisper.cpp <span class="font-mono">16秒</span> → Transcribe に切り替えて <span class="font-mono">1.4秒</span></p>

</div>

<!--
- 約52%短縮
- 体感では「AIが遅い」と思っていたが、計測したら一番遅かったのは STT
- whisper.cpp が16秒で全体の半分以上を占めていた
- そこで Transcribe に切り替えたら 1.4秒、全体が一気に速くなった
- 思い込みで最適化しない、まず計測する
-->

<!--
ハマりどころスライド（時間に余裕があれば復活させる）
Slidev が --- をスライド区切りとして解釈するので、復活時は復元して slide separator を足す

=== ハマりどころ ===

・Polly の音声が HDMI から出てしまう
  → 出力先を aplay に切り替え、最終的に Polly から PCM 直接受信

・Vosk が同じ発話を別表記で返す
  → "ラズパイ" / "ラズ パイ" / "らずぱい" を全部受け入れる

・起動時の Polly 失敗でサービス全落ち
  → try/except で包んで、失敗してもログを出して継続

Speaker notes:
- Polly の音声が HDMI から出てしまった。デフォルト出力先が HDMI だった
- Vosk は同じ「ラズパイ」でも「ラズ パイ」「らずぱい」など複数パターンで返ってくる。判定側で全部許容
- 起動直後にネットワークが安定していないと Polly が失敗してサービス全体が落ちた。例外を握って継続するように修正
-->

---

# 次の一手：`claude -p` → SDK 化

<div class="mt-6 grid grid-cols-2 gap-6">

<div class="bg-black/5 p-6 rounded-xl border border-black/10 shadow-sm">
<p class="!text-sm font-600 tracking-wide !m-0 !mb-3 opacity-60">現状：<code>claude -p</code></p>
<p class="!text-xl !m-0 leading-relaxed font-bold">毎回プロセス起動で <span class="text-blue-600">8秒</span> ロス</p>
<p class="!text-base !mt-3 !m-0 opacity-70">会話履歴も残らない</p>
</div>

<div class="bg-blue-500/10 p-6 rounded-xl border border-blue-500/20 shadow-sm">
<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-3">次：Python SDK 直叩き</p>
<p class="!text-xl !m-0 leading-relaxed font-bold">常駐プロセスから API <span class="text-blue-600">→ 起動コスト ゼロ</span></p>
<p class="!text-base !mt-3 !m-0 opacity-70"><code>messages</code> 配列で履歴を自分で管理</p>
</div>

</div>

<p v-click class="!text-xl !mt-8 text-center">応答 <span class="font-bold">13秒 → 5秒</span> 以下を狙える見込み</p>

<!--
- 現状の最大の残課題は Claude Code の起動オーバーヘッド
- claude -p は毎回 Node のランタイムを立ち上げているので、8秒の定額コストがかかる
- しかも毎回プロセスが新しいので、前の会話を引き継げない
- Python SDK を使えば、常駐している main.py から直接 API を叩ける。起動コストはゼロ
- API はステートレス設計なので、会話履歴は messages 配列で自分で管理すれば、前の質問を踏まえた対話もできる
- これで応答時間が 13秒 → 5秒程度まで縮まる見込み
-->

---
layout: statement
---

# 実用？微妙

# でも楽しい

<!--
- スマホのClaude アプリの方が速いし便利
- でも「呼びかけたら起きる机の上のデバイス」はスマホでは出せない手触り
- ガジェットは実用じゃなくて体験を作るもの
-->

---

# 宣伝：仲間を探しています

<div class="mt-4 grid grid-cols-2 gap-6">

<div>
<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-2"><carbon:user-multiple class="inline mr-1" />絶賛大募集中</p>
<img src="./assets/images/recruit-positions.png" class="rounded-lg border border-black/10 shadow-sm" alt="クラスメソッド採用サイトの募集職種ページ。募集中のポジションは118件" />
<p class="!text-base !mt-2 !m-0"><span class="font-bold text-blue-600">118件</span> の募集ポジション</p>
</div>

<div>
<p class="!text-sm font-600 tracking-wide text-blue-600 !m-0 !mb-2"><carbon:user-favorite class="inline mr-1" />私が入った枠</p>
<img src="./assets/images/recruit-young-engineer.png" class="rounded-lg border border-black/10 shadow-sm" alt="育成前提・若手開発エンジニアの募集ページ。入社後最大1年間の育成プログラムあり" />
<p class="!text-base !mt-2 !m-0"><span class="font-bold text-blue-600">育成前提・若手開発エンジニア</span></p>
</div>

</div>

<p class="!text-xl !mt-6 text-center font-bold">この枠で入った一人担当です。<span class="text-blue-600">声かけてください！</span></p>

<!--
- 最後に宣伝
- クラスメソッド、いま 118件 募集してます
- 私が入ったのは「育成前提・若手開発エンジニア」枠で、入社後最大1年間の育成プログラム付き
- この枠で入った一人担当なので、仲間を探しています
- ガジェット好き、低レイヤー好きの方、ぜひ声かけてください
-->

---
layout: statement
---

# ありがとうございました

<div class="absolute bottom-10 left-10 text-sm opacity-70 text-left">
  <p>詳細記事: <a href="https://dev.classmethod.jp/articles/pi4-voice-ai-assistant/">Raspberry Pi 4で音声AIアシスタントを作ってみた - DevelopersIO</a></p>
</div>

<!--
- ありがとうございました
- 詳細は DevelopersIO の記事に書いてあります
-->
