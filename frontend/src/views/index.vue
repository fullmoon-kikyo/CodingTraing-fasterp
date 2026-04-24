<template>
  <div class="app-container home">
    <section class="welcome-panel">
      <h1>欢迎 {{ displayName }} 来到管理后台</h1>
    </section>
  </div>
</template>

<script setup name="Index">
import useUserStore from "@/store/modules/user"

const userStore = useUserStore()
const displayName = computed(() => userStore.name || userStore.nickName || "用户")
</script>

<style scoped lang="scss">
.home {
  min-height: calc(100vh - 84px);
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--app-main-bg);
}

.welcome-panel {
  width: 100%;
  text-align: center;

  h1 {
    margin: 0;
    color: var(--navbar-text);
    font-size: 32px;
    font-weight: 600;
    line-height: 1.5;
  }
}
</style>
