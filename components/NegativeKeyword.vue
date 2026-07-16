<template>
  <div class="flex items-center justify-center h-full bg-[#F26565]">
    <div class="font-bold text-white absolute text-[44px]">{{ message }}</div>
  </div>
</template>

<script setup>
const props = defineProps({
  message: String,
});
</script>
