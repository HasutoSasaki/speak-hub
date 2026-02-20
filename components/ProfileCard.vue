<script setup lang="ts">
const name = "Hasuto（Sasaki Hasuto）";
const role = "Server-side Engineer";
const career = [
  {
    period: "2023.04 -",
    company: "SES企業",
    role: "Webサイト・Webアプリ開発",
    description: "Vue.js / Nuxt.js + Lambda / DynamoDB",
  },
  {
    period: "2026.01 -",
    company: "classmethod",
    role: "Webアプリ開発",
    description: "TypeScript / React + Lambda / DynamoDB",
  },
];
const hobbies = ["筋トレ", "アニメ", "低レイヤー", "Golang", "Neovim"];
const avatarSrc = new URL("../assets/images/avatar.jpeg", import.meta.url).href;
const logoSrc = new URL("../assets/images/logo/job.jpg", import.meta.url).href;
const socials = [
  {
    icon: "i-carbon-logo-github",
    url: "https://github.com/HasutoSasaki",
    label: "GitHub",
  },
  {
    icon: "i-carbon-logo-x",
    url: "https://x.com/vt23358",
    label: "@vt23358",
  },
];
</script>

<template>
  <div class="absolute inset-0 flex items-center justify-center px-12">
    <div
      class="p-10 rounded-2xl border bg-black/4 dark:bg-white/8 border-black/12 dark:border-white/15 backdrop-blur-md shadow-sm grid grid-cols-[auto_1fr_auto] gap-8 items-center max-w-4xl w-full"
    >
      <!-- Avatar -->
      <div class="flex-shrink-0">
        <div
          class="w-32 h-32 rounded-full overflow-hidden ring-4 ring-black/5 dark:ring-white/10"
        >
          <img
            :src="avatarSrc"
            :alt="name"
            class="w-full h-full object-cover"
          />
        </div>
      </div>

      <!-- Identity -->
      <div class="flex flex-col gap-4 text-left">
        <div>
          <h2 class="!text-3xl font-bold !m-0 !p-0">{{ name }}</h2>
          <div class="flex items-center gap-2.5 !mt-2">
            <!-- <img
              :src="logoSrc"
              alt="classmethod"
              class="h-5.5 object-contain"
            /> -->
            <p class="!text-base opacity-70 !m-0">{{ role }}</p>
          </div>
        </div>

        <!-- Hobbies -->
        <div class="flex gap-2 flex-wrap">
          <span
            v-for="h in hobbies"
            :key="h"
            class="px-2.5 py-0.5 rounded-full bg-black/3 dark:bg-white/6 border border-black/6 dark:border-white/8 text-xs opacity-60"
            >{{ h }}</span
          >
        </div>

        <!-- Social Links -->
        <div class="flex gap-3">
          <a
            v-for="s in socials"
            :key="s.url"
            :href="s.url"
            target="_blank"
            rel="noopener"
            class="flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-black/2 dark:bg-white/4 border border-black/6 dark:border-white/8 text-sm opacity-70 hover:opacity-100 transition-opacity !no-underline"
          >
            <div :class="s.icon" class="text-base" />
            <span>{{ s.label }}</span>
          </a>
        </div>
      </div>

      <!-- Career Timeline -->
      <div class="flex flex-col relative pl-5">
        <!-- Vertical line -->
        <div
          class="absolute left-[4px] top-2 bottom-2 w-px bg-current opacity-15"
        />
        <div
          v-for="(c, i) in career"
          :key="c.period"
          class="relative"
          :class="i < career.length - 1 ? 'pb-4' : ''"
        >
          <!-- Dot (centered on line: left-[4px] - half of 10px = -1px) -->
          <div
            class="absolute -left-[16px] top-1 w-2.5 h-2.5 rounded-full"
            :class="
              i === career.length - 1 ? 'bg-amber-400' : 'bg-current opacity-30'
            "
          />
          <!-- Content -->
          <div class="!text-sm max-w-52">
            <div class="font-medium">
              <span class="opacity-50">{{ c.period }}</span>
              <span class="opacity-80 ml-1.5">{{ c.company }}</span>
            </div>
            <div class="opacity-70 mt-0.5">{{ c.role }}</div>
            <div class="opacity-45 mt-0.5 text-xs">{{ c.description }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
