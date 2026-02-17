---
theme: apple-basic
colorSchema: dark
title: AI Agentの仕組みを調べてみた
transition: slide-left
layout: intro
---

# AI Agentの仕組みを調べてみた

Hugging Face Agents Course で学んだこと

<div class="absolute bottom-10">
  <span class="font-700">
    @HasutoSasaki
  </span>
</div>

<!--
AI Agentって最近よく聞くけど、中身はどうなっているのか。
Hugging Face Agents Course を通じて学んだことを共有します。
-->

---

<ProfileCard />

---
layout: statement
---

# LLMは魔法ではない

<!--
AI Agentの仕組みを理解するには、まずLLMの限界を正しく知る必要があります。
-->

---

## LLMの本質

<div class="grid grid-cols-2 gap-6 mt-6">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

<h3 class="!text-lg font-bold text-blue-400 !mb-3 !opacity-100"><carbon:checkmark-outline class="inline mr-1" /> できること</h3>

- テキストを入力として受け取る
- テキストを出力する
- パターンに基づく推論
- 文脈から次の単語を予測する

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

<h3 class="!text-lg font-bold text-red-400 !mb-3 !opacity-100"><carbon:close-outline class="inline mr-1" /> できないこと</h3>

- 記憶を保持する
- APIを叩く
- 計算を正確に実行する
- リアルタイム情報を取得する

</div>
</div>

<div v-click class="mt-6 text-center opacity-80">

**「234 × 567 は？」→ 計算ではなく、訓練データのパターンから予測しているだけ**

</div>

<!--
LLMの内部にHTTPリクエストを送る機能も、計算する仕組みもありません。
大きな数の掛け算で間違えるのは、実際に計算していないからです。
純粋に「テキストイン・テキストアウト」のモデルです。
-->

---

## 会話の裏側: LLMに記憶はない

チャットUIでは対話しているように見えるが、実態は全く異なる

<div v-click class="mt-6 bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">
<p class="!text-sm font-mono !leading-relaxed !m-0">
[1回目のユーザーの質問]<br>
[1回目のモデルの回答]<br>
[2回目のユーザーの質問]<br>
[2回目のモデルの回答]<br>
<span class="text-blue-400">[3回目のユーザーの質問] ← 毎回すべてを読み直す</span>
</p>
</div>

<div v-click class="mt-6 opacity-90">

**過去のすべての会話が連結されて、毎回1本のテキストとして丸ごと渡されている**

</div>

<!--
3往復目でモデルが過去の会話を覚えているように見えるのは、
過去のすべてが毎回丸ごと渡されているからです。
記憶ではなく、入力の再構築です。
-->

---

## ツール: LLMはテキストを書くだけ

<div class="grid grid-cols-2 gap-6 mt-4">
<div>

### LLMがツールを「使う」流れ

1. ユーザーが「パリの天気は？」と聞く
2. LLMが**テキスト**を出力する
   `call weather('Paris')`
3. **Agent**がテキストを解析しAPIを実行
4. 結果を会話に追加
5. LLMが結果を読んで回答を生成

</div>
<div v-click class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm flex items-center">
<div class="text-center w-full">
<p class="!text-lg !m-0">LLMは「このツールを使って」と</p>
<p class="!text-2xl font-bold text-blue-400 !my-2">テキストで書いているだけ</p>
<p class="!text-lg !m-0">実行するのは <span class="text-blue-400 font-bold">Agent</span></p>
</div>
</div>
</div>

<!--
LLMはテキストしか扱えないので、自分自身でAPIを叩くことはできません。
ツール呼び出しの指示文をテキストとして生成するだけ。
実際にAPIを叩いているのはLLMの外側にいるエージェントプログラムです。
-->

---

## @tool デコレータ: 関数からツール情報を自動抽出

```python
@tool
def get_current_time_in_timezone(timezone: str) -> str:
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  ← ① ツール名（関数名）
#                                  ^^^^^^^^^^^^^ ← ③ 引数と型
#                                                    ^^^ ← ④ 出力の型
    """A tool that fetches the current local time in a specified timezone.
    # ↑ ② 何をするかの説明（docstring）
    """
```

<div v-click class="mt-4 bg-white/10 p-4 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">
<p class="!text-sm font-mono !m-0 !leading-relaxed">
Tool Name: get_current_time_in_timezone<br>
Description: A tool that fetches the current local time in a specified timezone.<br>
Arguments: timezone: str<br>
Outputs: str
</p>
</div>

<div v-click class="mt-4 opacity-80 text-center">

**型ヒントとdocstringを正確に書くこと = LLMへの正確な説明になる**

</div>

<!--
@toolデコレータはPythonのinspectモジュールで関数名、docstring、型ヒントを自動抽出し、
LLM向けの説明文を生成します。だからこそ型ヒントとdocstringが重要なのです。
この説明文は毎回システムメッセージに含まれるため、簡潔に書くことも大切です。
-->

---
layout: statement
---

# Agentは
# シンプルなwhileループ

<!--
ここが今日一番伝えたいことです。
AI Agentの中身は驚くほどシンプルです。
-->

---

## Agentの内部構造

```python
while True:
    # 1. 会話全体をLLMに渡す
    response = llm.generate(messages)

    # 2. 出力にツール呼び出しがあるか？
    if has_tool_call(response):
        tool_name, args = parse_tool_call(response)
        result = tools[tool_name](**args)
        messages.append({"role": "tool", "content": result})
    else:
        # ツール呼び出しがなければ最終回答
        return response
```

<div v-click class="mt-4 text-center opacity-90">

**賢い判断はすべてLLM側。Agent自体は「あれば実行、なければ終了」だけ**

</div>

<!--
Agentが柔軟に見える理由は、賢い判断をすべてLLM側がしているから。
Agent自体は「ツール呼び出しがあれば実行、なければ終了」というシンプルなルールで動いているだけです。
-->

---

## smolagents: 概念とコードの対応

HuggingFace 製の軽量エージェントフレームワーク

```python
agent = CodeAgent(
    model=model,                     # ← LLMエンジン
    tools=[final_answer, ...],       # ← エージェントが使えるツールのリスト
    max_steps=6,                     # ← 無限ループ防止の上限
    prompt_templates=prompt_templates # ← システムメッセージのテンプレート
)
```

<div v-click class="mt-4 bg-white/10 p-4 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">
<p class="!text-sm !m-0 !leading-relaxed">

`tools` 配列にツールを追加 → `@tool` が説明文を自動生成 → **システムメッセージに追加される**

配列に入れ忘れたツールは、コード上に存在していてもLLMはその存在を知らない

</p>
</div>

<!--
これまで説明してきた概念が、実際のフレームワークではこう対応しています。
LLMエンジン、ツールリスト、ループ上限、システムメッセージテンプレート。
tools配列がシステムメッセージに反映されるので、入れ忘れるとLLMはそのツールを使えません。
-->

---

## Stop → Parse: Agentの2つの仕事

<div class="grid grid-cols-2 gap-6 mt-6">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

<h3 class="!text-lg font-bold text-blue-400 !mb-3 !opacity-100"><carbon:stop-sign class="inline mr-1" /> Stop（停止）</h3>

LLMは次のトークンを予測し続けるモデルのため、JSON出力後も止まらずテキストを生成し続ける

**まずLLMを止めないと、パースすべきテキストが確定しない**

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

<h3 class="!text-lg font-bold text-blue-400 !mb-3 !opacity-100"><carbon:data-structured class="inline mr-1" /> Parse（解析）</h3>

停止後の出力テキストを解析し、ツール呼び出しかどうかを判定する

**ツール名と引数を抽出 → 実行 → 結果を会話に追加**

</div>
</div>

<div v-click class="mt-6 opacity-80 text-center">

無限ループ防止のため、実際のAgentでは **max_steps** でループ回数の上限を設定する

</div>

<!--
LLMは生成を止めない限りテキストを出し続けます。
まず止めて、出力を確定させてから解析する。この2ステップがAgentの核です。
また、ツールがエラーを返し続けるとループが止まらないため、max_stepsで上限を設けます。
-->

---

## Thought → Action → Observation

<div class="mt-2 bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

**例: 「ニューヨークの天気は？」**

| Step | 内容 |
|------|------|
| **Thought** | 天気APIツールを使おう |
| **Action** | `get_weather("New York")` → Agentが実行 |
| **Observation** | 「曇り、15℃」→ 会話に追加 |
| **Thought** | データが手に入った。回答をまとめよう |
| **Final** | ユーザーへの自然言語の回答 → ループ終了 |

</div>

<div v-click class="mt-4 opacity-90">

このサイクルはLLMの組み込み能力ではなく、**システムメッセージで指示されたパターン**

</div>

<!--
LLMがこの手順で動けるのは、システムメッセージにサイクルの手順自体が書かれているからです。
プロンプトで指示されたパターンに過ぎません。
-->

---

## 思考テクニック: CoT と ReAct

<div class="grid grid-cols-2 gap-6 mt-4">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

<h3 class="!text-lg font-bold text-blue-400 !mb-3 !opacity-100">CoT（Chain-of-Thought）</h3>

**外部ツールなし**でステップバイステップ思考

```
Q: 200の15%はいくつ？
Thought: 10%は20、5%は10、
         だから15%は30。
Answer: 30
```

<p class="!text-sm opacity-70 !mt-2">論理・数学など内部推論向き</p>

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

<h3 class="!text-lg font-bold text-blue-400 !mb-3 !opacity-100">ReAct（Reasoning + Acting）</h3>

**思考とアクションを交互**に実行

```
Thought: パリの天気を調べたい
Action: Search["weather in Paris"]
Observation: 18°C、曇り
Action: Finish["18°C、曇りです"]
```

<p class="!text-sm opacity-70 !mt-2">情報取得・複数ステップ向き</p>

</div>
</div>

<div v-click class="mt-4 opacity-80 text-center">

どちらも**プロンプティング戦略**であり、どのモデルでも使える

</div>

<!--
CoTは内部の推論を言語化する手法、ReActは外部ツールと組み合わせる手法です。
どちらもプロンプトで指示するだけで使えるテクニックです。
DeepSeek R1やOpenAI o1は、これを訓練レベルで組み込んだモデルです。
-->

---

## アクションの形式: JSON vs Code

<div class="grid grid-cols-2 gap-6 mt-6">
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

<h3 class="!text-lg font-bold text-blue-400 !mb-3 !opacity-100">JSON Agent</h3>

```json
{
  "action": "get_weather",
  "action_input": {
    "location": "New York"
  }
}
```

<p class="!text-sm opacity-70 !mt-3">構造化データのみ → 安全性が高い</p>

</div>
<div class="bg-white/10 p-5 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm">

<h3 class="!text-lg font-bold text-blue-400 !mb-3 !opacity-100">Code Agent</h3>

```python
result = get_weather("New York")
print(result)
```

<p class="!text-sm opacity-70 !mt-3">ループ・条件分岐が可能 → 表現力が高い</p>

</div>
</div>

<div v-click class="mt-6 opacity-80 text-center">

Code Agent は表現力が高い反面、**サンドボックス環境などのセキュリティ対策**が必須

</div>

<!--
LLMの出力形式には大きく2種類あります。
JSON形式は安全だが表現力が限定的。コード形式はループや条件分岐が書ける反面、
悪意あるコード実行のリスクがあるためサンドボックスが必要です。
-->

---

## 全体像

<div class="mt-2 leading-relaxed">

1. ユーザーの質問が届く
2. 過去の会話すべてが**特殊トークン**で区切られ、1本のテキストに連結
3. LLMが全体を読んで **Thought** する
4. アクションをテキストとして出力 → **Stop**
5. Agentが出力を **Parse**
6. ツール呼び出しあり → **Action**: Agentがツールを実行
7. 結果が **Observation** として会話に追加 → 3に戻る
8. ツール呼び出しなし → **最終回答**を返す

</div>

<div v-click class="mt-4 bg-white/10 p-4 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm text-center">

これを支えるのは: **特殊トークン** / **チャットテンプレート** / **システムメッセージ** / **シンプルなwhileループ**

</div>

<!--
この一連の流れを支えているのが、特殊トークン、チャットテンプレート、
システムメッセージ、そしてシンプルなwhileループのエージェントです。
-->

---
layout: statement
---

# 複雑に見えて
# 仕組みはシンプル

<!--
AI Agentを分解していくと、一つ一つの仕組みは驚くほどシンプルです。
LLMの限界を理解し、ツールとwhileループで補う。それがAgentの全体像です。
-->

---
layout: statement
---

# ありがとうございました

<div class="absolute bottom-10 left-10 text-sm opacity-70">
  <p>参考: <a href="https://huggingface.co/learn/agents-course">Hugging Face Agents Course</a></p>
</div>
