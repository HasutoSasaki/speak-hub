<template>
  <div class="flex items-center justify-center h-full">
    <div class="font-bold text-gray-600 absolute text-[44px]">
      {{ message }}
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  message: String,
});
</script>
