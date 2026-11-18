<!-- 表紙以外のスライドの右上にクラスメソッドのロゴを出す -->
<template>
  <img
    v-if="$nav.currentPage !== 1"
    src="./assets/images/classmethod-logo.svg"
    alt="Classmethod"
    class="absolute top-5 right-6 h-6"
  />
</template>
