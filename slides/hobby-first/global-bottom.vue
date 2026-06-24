<template>
  <div class="fixed inset-0 pointer-events-none overflow-hidden" style="z-index: 0;">
    <!-- 右上 コーナーアーク -->
    <div style="
      position: absolute;
      top: -280px;
      right: -280px;
      width: 500px;
      height: 500px;
      border-radius: 50%;
      background: #c2410c;
      opacity: 0.12;
    " />
    <!-- 左下 コーナーアーク -->
    <div style="
      position: absolute;
      bottom: -260px;
      left: -260px;
      width: 460px;
      height: 460px;
      border-radius: 50%;
      background: #9a3412;
      opacity: 0.10;
    " />
  </div>
</template>
