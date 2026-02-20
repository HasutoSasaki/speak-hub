<script setup lang="ts">
import { ref, computed } from "vue";

const systemPromptTokens = 1500;
const avgUserTokens = 80;
const avgAssistantTokens = 300;
const maxTurns = 15;

const turns = ref<Array<{ userTokens: number; assistantTokens: number }>>([]);

function addTurn() {
  if (turns.value.length >= maxTurns) return;
  const userTokens =
    avgUserTokens + Math.floor(Math.random() * 40 - 20);
  const assistantTokens =
    avgAssistantTokens + Math.floor(Math.random() * 150 - 75);
  turns.value.push({ userTokens, assistantTokens });
}

function reset() {
  turns.value = [];
}

// Each turn: calculate what the LLM actually receives as input
const turnData = computed(() => {
  let accumulatedHistory = 0;
  return turns.value.map((turn, i) => {
    const totalInput =
      systemPromptTokens + accumulatedHistory + turn.userTokens;
    const result = {
      turn: i + 1,
      systemPrompt: systemPromptTokens,
      history: accumulatedHistory,
      newMessage: turn.userTokens,
      totalInput,
      output: turn.assistantTokens,
    };
    accumulatedHistory += turn.userTokens + turn.assistantTokens;
    return result;
  });
});

// Chart dimensions
const chartW = 620;
const chartH = 240;
const barGap = 4;

const maxTokens = computed(() => {
  if (turnData.value.length === 0) return 5000;
  const maxInput = Math.max(...turnData.value.map((t) => t.totalInput));
  return Math.ceil(maxInput / 1000) * 1000;
});

const barWidth = computed(() => {
  const count = Math.max(turnData.value.length, 1);
  return Math.min((chartW - barGap * (count - 1)) / count, 50);
});

// Cumulative input tokens (sum of ALL API calls' input)
const cumulativeInput = computed(() =>
  turnData.value.reduce((sum, t) => sum + t.totalInput, 0),
);

// "Naive" estimate: if someone thought only the new message is sent each time
const naiveTotal = computed(() =>
  turnData.value.reduce((sum, t) => sum + t.newMessage, 0),
);

function formatNum(n: number): string {
  return n.toLocaleString();
}

// Y-axis scale labels
const yLabels = computed(() => {
  const max = maxTokens.value;
  const step = max <= 5000 ? 1000 : max <= 15000 ? 2500 : 5000;
  const labels = [];
  for (let v = 0; v <= max; v += step) {
    labels.push(v);
  }
  return labels;
});
</script>

<template>
  <div class="flex flex-col h-full">
    <!-- Header -->
    <div class="flex items-center justify-between mb-3">
      <h3 class="!text-lg font-bold text-blue-400 !m-0 !opacity-100">
        <carbon:chart-stacked class="inline mr-1" />
        ターンごとのLLM入力トークン数
      </h3>
      <div class="flex gap-2">
        <button
          class="px-3 py-1 rounded-lg bg-blue-500/20 border border-blue-400/30 text-blue-400 text-sm hover:bg-blue-500/30 transition-colors cursor-pointer"
          :class="{ 'opacity-30 cursor-not-allowed': turns.length >= maxTurns }"
          @click="addTurn"
        >
          <carbon:add class="inline mr-0.5 text-xs" />
          Next Turn
        </button>
        <button
          class="px-3 py-1 rounded-lg bg-white/5 border border-gray-400/20 text-sm opacity-60 hover:opacity-90 transition-opacity cursor-pointer"
          @click="reset"
        >
          Reset
        </button>
      </div>
    </div>

    <div class="grid grid-cols-[1fr_200px] gap-4 flex-1">
      <!-- Chart area -->
      <div
        class="bg-white/5 rounded-xl border border-gray-400/10 p-4 flex items-end"
      >
        <svg
          :viewBox="`0 0 ${chartW + 50} ${chartH + 20}`"
          class="w-full h-full"
          preserveAspectRatio="xMidYMax meet"
        >
          <!-- Y-axis labels -->
          <template v-for="label in yLabels" :key="label">
            <text
              :x="44"
              :y="chartH - (label / maxTokens) * chartH + 4"
              text-anchor="end"
              class="fill-current opacity-30"
              font-size="10"
            >
              {{ label >= 1000 ? `${label / 1000}k` : label }}
            </text>
            <line
              :x1="50"
              :y1="chartH - (label / maxTokens) * chartH"
              :x2="chartW + 50"
              :y2="chartH - (label / maxTokens) * chartH"
              stroke="currentColor"
              stroke-opacity="0.08"
              stroke-width="1"
            />
          </template>

          <!-- Bars -->
          <g v-for="(d, i) in turnData" :key="i">
            <!-- System prompt portion (bottom, blue) -->
            <rect
              :x="50 + i * (barWidth + barGap)"
              :y="chartH - (d.systemPrompt / maxTokens) * chartH"
              :width="barWidth"
              :height="(d.systemPrompt / maxTokens) * chartH"
              fill="#3b82f6"
              opacity="0.7"
              rx="2"
            />
            <!-- History portion (middle, teal) -->
            <rect
              :x="50 + i * (barWidth + barGap)"
              :y="
                chartH -
                ((d.systemPrompt + d.history) / maxTokens) * chartH
              "
              :width="barWidth"
              :height="(d.history / maxTokens) * chartH"
              fill="#14b8a6"
              opacity="0.7"
              rx="0"
            />
            <!-- New user message (top, amber) -->
            <rect
              :x="50 + i * (barWidth + barGap)"
              :y="chartH - (d.totalInput / maxTokens) * chartH"
              :width="barWidth"
              :height="(d.newMessage / maxTokens) * chartH"
              fill="#f59e0b"
              opacity="0.8"
              rx="2"
            />
            <!-- Turn label -->
            <text
              :x="50 + i * (barWidth + barGap) + barWidth / 2"
              :y="chartH + 14"
              text-anchor="middle"
              class="fill-current opacity-30"
              font-size="9"
            >
              {{ d.turn }}
            </text>
          </g>

          <!-- Empty state -->
          <text
            v-if="turnData.length === 0"
            :x="chartW / 2 + 50"
            :y="chartH / 2"
            text-anchor="middle"
            class="fill-current opacity-20"
            font-size="14"
          >
            "Next Turn" を押して会話を開始
          </text>
        </svg>
      </div>

      <!-- Stats panel -->
      <div class="flex flex-col gap-3">
        <!-- Legend -->
        <div
          class="bg-white/10 p-3 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm"
        >
          <p class="!text-xs font-bold opacity-60 !m-0 !mb-2">凡例</p>
          <div class="flex flex-col gap-1.5">
            <div class="flex items-center gap-2">
              <span class="w-3 h-3 rounded-sm bg-blue-500/70 inline-block" />
              <span class="!text-xs opacity-70">System Prompt</span>
            </div>
            <div class="flex items-center gap-2">
              <span class="w-3 h-3 rounded-sm bg-teal-500/70 inline-block" />
              <span class="!text-xs opacity-70">過去の会話履歴</span>
            </div>
            <div class="flex items-center gap-2">
              <span class="w-3 h-3 rounded-sm bg-amber-500/80 inline-block" />
              <span class="!text-xs opacity-70">新しいメッセージ</span>
            </div>
          </div>
        </div>

        <!-- Metrics -->
        <div
          class="bg-white/10 p-3 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm"
        >
          <p class="!text-xs font-bold opacity-60 !m-0 !mb-2">
            累計 入力トークン
          </p>
          <p class="!text-xl font-bold text-blue-400 !m-0">
            {{ formatNum(cumulativeInput) }}
          </p>
        </div>

        <div
          class="bg-white/10 p-3 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm"
        >
          <p class="!text-xs font-bold opacity-60 !m-0 !mb-2">
            ユーザー入力のみの合計
          </p>
          <p class="!text-lg font-bold opacity-70 !m-0">
            {{ formatNum(naiveTotal) }}
          </p>
          <p
            v-if="cumulativeInput > 0"
            class="!text-xs text-amber-400 !m-0 !mt-1"
          >
            実際は {{ Math.round(cumulativeInput / Math.max(naiveTotal, 1)) }}
            倍のトークンが使われている
          </p>
        </div>

        <div
          class="bg-white/10 p-3 rounded-xl border border-gray-400/20 backdrop-blur-md shadow-sm"
        >
          <p class="!text-xs font-bold opacity-60 !m-0 !mb-2">
            ターン数
          </p>
          <p class="!text-lg font-bold opacity-70 !m-0">
            {{ turns.length }} / {{ maxTurns }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>
