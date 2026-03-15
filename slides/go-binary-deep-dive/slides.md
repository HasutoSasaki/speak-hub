---
theme: apple-basic
colorSchema: dark
title: Go のバイナリを覗いてみた
transition: slide-left
layout: intro
---

# Go のバイナリを覗いてみた

速さの秘密はバイナリに隠れている？

<div class="absolute bottom-10">
  <span class="font-700">
    @HasutoSasaki
  </span>
</div>

<!--
- Go のバイナリを覗いてみた、という話をする
- Go は速いとよく言われるが、なぜ速いのか？
- バイナリの中身を見ることで、その理由に迫った
-->

---

<ProfileCard />

<!--
- Sasaki Hasuto です
- classmethod で Web アプリ開発をしている
- Go や低レイヤー技術が好きで、今回バイナリを覗いてみた
-->

---
layout: statement
---

# Go は速い

# なぜ...？

<!--
- Go が速いのはみんな知っている
- でも「なぜ速いのか」を説明できるか？
- コンパイル言語だから？ goroutine があるから？
- もう少し深く、バイナリレベルで見てみた
-->

---

## アプローチ: バイナリを直接見る

<div class="mt-6 grid grid-cols-2 gap-6">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

**サンプルコード: Hello World**

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello World")
}
```

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

**ビルドして解析**

```bash
go build -o ./bin/hello_go ./go/hello.go
```

<p class="!text-sm opacity-70 !mt-3">シンプルなコードでも、<br>バイナリには多くの情報が詰まっている</p>

</div>
</div>

<!--
- 題材はシンプルな Hello World
- コンパイルして生成されたバイナリを解析ツールで見ていく
- シンプルなコードだからこそ、Go が裏で何をしているかが見えやすい
-->

---

## file コマンドで正体を確認

<div class="mt-6 bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm font-mono text-sm">

$ file ./bin/hello_go<br>
<span v-mark.highlight="{ color: '#F59E0B33', at: 1 }">ELF</span> 64-bit LSB executable, ARM aarch64, version 1 (SYSV),<br>
<span v-mark.highlight="{ color: '#F59E0B33', at: 2 }">statically linked</span>, <span v-mark.highlight="{ color: '#F59E0B33', at: 3 }">not stripped</span>

</div>

<div class="mt-6 grid grid-cols-3 gap-4">
<div v-click="1" class="bg-white/10 p-4 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm text-center">
<p class="!text-lg font-bold text-blue-400 !mb-1">ELF</p>
<p class="!text-sm opacity-70 !m-0">Linux/Unix の<br>実行ファイル形式</p>
</div>
<div v-click="2" v-mark.box="{ color: '#F59E0B', at: 4 }" class="bg-blue-400/10 p-4 rounded-xl border border-blue-400/20 backdrop-blur-md shadow-sm text-center">
<p class="!text-lg font-bold text-blue-400 !mb-1">statically linked</p>
<p class="!text-sm opacity-70 !m-0">依存をすべて<br>バイナリに内包</p>
</div>
<div v-click="3" class="bg-white/10 p-4 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm text-center">
<p class="!text-lg font-bold text-blue-400 !mb-1">not stripped</p>
<p class="!text-sm opacity-70 !m-0">デバッグ情報が<br>保持されている</p>
</div>
</div>

<!--
- file コマンドでバイナリの種類を確認
- ELF = Linux/Unix の実行ファイル形式
- 最も重要なのは statically linked — 依存をすべてバイナリに埋め込んでいる
- not stripped = デバッグ情報が残っている → シンボルテーブルを解析できる
-->

---
layout: statement
---

## ELF の中身をもう少し覗いてみる

<!--
- file コマンドで ELF であることがわかった
- では ELF の中にはどんな情報が入っているのか？
-->

---

## ELF の構造

<div class="mt-4 grid grid-cols-3 gap-4">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">
<p class="!text-sm font-600 tracking-wide text-blue-400 !mb-2">ELF Header</p>

- ファイル種別の識別
- エントリーポイントの指定
- バイナリの「目次」

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">
<p class="!text-sm font-600 tracking-wide text-blue-400 !mb-2">Sections</p>

- <span v-mark.highlight="{ color: '#F59E0B33', at: 1 }">`.text` — 機械語命令</span>
- `.rodata` — 定数データ
- `.data` / `.bss` — 変数

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">
<p class="!text-sm font-600 tracking-wide text-blue-400 !mb-2">Segments</p>

- セクションのグループ化
- OS がメモリに配置する単位
- 実行時のメモリマッピング

</div>
</div>

<div v-click class="mt-6 opacity-90">

特に注目すべきは `.text` セクション — ここに **実行される命令がすべて格納** されている

</div>

<!--
- ELF は3つの構造要素で成り立つ
- Header = バイナリの目次
- Sections = 用途別の領域。.text に命令、.rodata に定数、.data/.bss に変数
- Segments = OS がメモリに配置する単位
- .text セクションに注目して、サイズを見てみる
-->

---

## .text セクションが巨大

<div class="mt-6 bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

`size` コマンドで各セクションのサイズを確認

<div class="mt-4 font-mono">

| セクション | サイズ |
|-----------|--------|
| .text | <span v-mark.highlight="{ color: '#F59E0B33', at: 1 }">**約 1.4 MB**</span> |
| .data | 数 KB |
| .bss | 数 KB |

</div>
</div>

<div v-click class="mt-6 grid grid-cols-2 gap-6">
<div class="bg-white/10 p-4 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm text-center">
<p class="!text-sm opacity-70 !m-0 !mb-1">サンプルコード</p>
<p class="!text-2xl font-bold text-blue-400 !m-0">数十 bytes</p>
</div>
<div class="bg-blue-400/10 p-4 rounded-xl border border-blue-400/20 backdrop-blur-md shadow-sm text-center">
<p class="!text-sm opacity-70 !m-0 !mb-1">.text セクション</p>
<p class="!text-2xl font-bold text-blue-400 !m-0">約 1.4 MB</p>
</div>
</div>

<!--
- Hello World のソースコードは数十バイト
- なのに .text セクションは約 1.4 MB もある
- この差分は何？ → Go のランタイムやパッケージが丸ごと含まれている
-->

---

## 1.4 MB の中身は何？

<div class="mt-6 grid grid-cols-2 gap-6">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

**シンボルとは**

バイナリに記録された関数名や変数名の一覧

<p class="!text-sm opacity-70 !mt-3">コンパイル前のコードの「名前」が<br>バイナリの中に残っている</p>

</div>
<div v-click class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

**シンボルテーブルを見れば**

どのパッケージがどれだけ含まれているかがわかる

<p class="!text-sm opacity-70 !mt-3"><code>not stripped</code> だったので<br>シンボルが残っている → 解析できる</p>

</div>
</div>

<!--
- .text の 1.4 MB が何で構成されているのか知りたい
- シンボル = バイナリに残っている関数名や変数名
- not stripped だったのでシンボルが残っている → 解析に使える
- go tool nm で中身を見てみよう
-->

---

## シンボルテーブルの中身を暴く

`go tool nm` でバイナリに含まれるシンボルを分析

<div class="mt-6 grid grid-cols-3 gap-4">
<div class="bg-blue-400/10 p-5 rounded-xl border border-blue-400/20 backdrop-blur-md shadow-sm text-center">
<p class="!text-3xl font-bold text-blue-400 !m-0 !mb-2">1,677</p>
<p class="!text-sm opacity-70 !m-0">runtime</p>
</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm text-center">
<p class="!text-3xl font-bold !m-0 !mb-2">83</p>
<p class="!text-sm opacity-70 !m-0">type</p>
</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm text-center">
<p class="!text-3xl font-bold !m-0 !mb-2">78</p>
<p class="!text-sm opacity-70 !m-0">reflect</p>
</div>
</div>

<div v-click class="mt-6 bg-white/10 p-4 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

`runtime` が圧倒的 — GC、goroutine スケジューラ、メモリ管理などが **すべてバイナリに埋め込まれている**

</div>

<!--
- go tool nm でシンボルを解析すると、runtime が 1,677 シンボルで圧倒的
- Hello World しか書いていないのに、GC やスケジューラが丸ごと入っている
- これが静的リンクの正体 — Go のランタイムがバイナリに同梱されている
-->

---
layout: fact
---

# 全部載せ

Go は依存もランタイムも **すべてバイナリに詰め込む** (Self-Contained)

<!--
- Go のバイナリは「全部載せ」— Self-Contained な自己完結型
- 依存ライブラリも、ランタイムも、すべて1つのバイナリに入っている
- だから実行時に外部を探しに行く必要がない → 速い
-->

---

## 静的リンクがもたらすもの

<div class="mt-6 grid grid-cols-2 gap-6">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

<p class="!text-sm font-600 tracking-wide text-blue-400 !mb-2"><carbon:flash class="inline mr-1" /> 速さの理由</p>

- 実行時の依存解決が不要
- 共有ライブラリのロードなし
- 起動からすぐにコード実行

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

<p class="!text-sm font-600 tracking-wide text-blue-400 !mb-2"><carbon:cube class="inline mr-1" /> デプロイの強み</p>

- バイナリ1つで動く
- コンテナイメージの軽量化
- 環境依存の問題が起きにくい

</div>
</div>

<div v-click class="mt-6">

**トレードオフ**: バイナリサイズは大きくなる — Hello World でも約 1.8 MB

</div>

<!--
- 静的リンクの恩恵は速度だけではない
- バイナリ1つで完結するので、デプロイもシンプル
- scratch ベースの Docker イメージで動かせる
- トレードオフとしてバイナリサイズが大きくなるが、現代では許容範囲
-->

---
layout: statement
---

# バイナリを覗けば<br>言語の設計思想が見える

<!--
- 表面的な特徴だけでなく、バイナリレベルで見ることで設計思想が理解できる
- Go は「全部入りのシンプルなバイナリ」という設計思想
- 気になったら file, size, go tool nm を試してみてほしい
-->

---
layout: statement
---

# ありがとうございました

<div class="absolute bottom-10 left-10 text-sm opacity-70 text-left">
  <p>詳細記事: <a href="https://dev.classmethod.jp/articles/go-binary-deep-dive/">Go のバイナリを覗いてみた - DevelopersIO</a></p>
</div>

<!--
- 詳細は DevelopersIO の記事に
- 質問があればお気軽に
-->
