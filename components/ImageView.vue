<template>
  <img
    :src="fileName"
    :alt="alt"
    class="flex items-center justify-center h-full"
  />
</template>

<script setup>
const props = defineProps({
  fileName: String,
  alt: String,
});
</script>
