<template>
  <div>
    <svg-icon icon-class="guide" @click="goto" />
  </div>
</template>

<script setup>
const url = ref('http://ruoyi.vip')

function goto() {
  window.open(url.value)
}
</script>
