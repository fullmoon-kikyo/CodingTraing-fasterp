<template>
  <div v-if="!item.hidden">
    <template v-if="hasOneShowingChild(item.children, item) && (!onlyOneChild.children || onlyOneChild.noShowingChildren) && !item.alwaysShow">
      <app-link v-if="onlyOneChild.meta" :to="resolvePath(onlyOneChild.path, onlyOneChild.query)">
        <el-menu-item :index="resolvePath(onlyOneChild.path)" :class="{ 'submenu-title-noDropdown': !isNest }">
          <svg-icon :icon-class="onlyOneChild.meta.icon || (item.meta && item.meta.icon)"/>
          <template #title>
            <div class="sidebar-menu-title">
              <span class="menu-title" :title="hasTitle(onlyOneChild.meta.title)">{{ onlyOneChild.meta.title }}</span>
              <span v-if="showWorkflowTodoBadge(onlyOneChild)" class="workflow-todo-badge">{{ workflowTodoBadgeText }}</span>
            </div>
          </template>
        </el-menu-item>
      </app-link>
    </template>

    <el-sub-menu v-else ref="subMenu" :index="resolvePath(item.path)" teleported>
      <template v-if="item.meta" #title>
        <svg-icon :icon-class="item.meta && item.meta.icon" />
        <div class="sidebar-menu-title">
          <span class="menu-title" :title="hasTitle(item.meta.title)">{{ item.meta.title }}</span>
          <span v-if="showWorkflowTodoBadge(item)" class="workflow-todo-badge">{{ workflowTodoBadgeText }}</span>
        </div>
      </template>

      <sidebar-item
        v-for="(child, index) in item.children"
        :key="child.path + index"
        :is-nest="true"
        :item="child"
        :base-path="resolvePath(child.path)"
        class="nest-menu"
      />
    </el-sub-menu>
  </div>
</template>

<script setup>
import { isExternal } from '@/utils/validate'
import AppLink from './Link'
import { getNormalPath } from '@/utils/ruoyi'
import useWorkflowStore from '@/store/modules/workflow'

const props = defineProps({
  // route object
  item: {
    type: Object,
    required: true
  },
  isNest: {
    type: Boolean,
    default: false
  },
  basePath: {
    type: String,
    default: ''
  }
})

const onlyOneChild = ref({})
const workflowStore = useWorkflowStore()
const workflowTodoBadgeText = computed(() => workflowStore.todoCount > 99 ? '99+' : String(workflowStore.todoCount))

function hasOneShowingChild(children = [], parent) {
  if (!children) {
    children = []
  }
  const showingChildren = children.filter(item => {
    if (item.hidden) {
      return false
    }
    onlyOneChild.value = item
    return true
  })

  // When there is only one child router, the child router is displayed by default
  if (showingChildren.length === 1) {
    return true
  }

  // Show parent if there are no child router to display
  if (showingChildren.length === 0) {
    onlyOneChild.value = { ...parent, path: '', noShowingChildren: true }
    return true
  }

  return false
}

function resolvePath(routePath, routeQuery) {
  if (isExternal(routePath)) {
    return routePath
  }
  if (isExternal(props.basePath)) {
    return props.basePath
  }
  if (routeQuery) {
    let query = JSON.parse(routeQuery)
    return { path: getNormalPath(props.basePath + '/' + routePath), query: query }
  }
  return getNormalPath(props.basePath + '/' + routePath)
}

function hasTitle(title){
  if (title.length > 5) {
    return title
  } else {
    return ""
  }
}

function showWorkflowTodoBadge(route) {
  return isWorkflowMenu(route) && workflowStore.todoCount > 0
}

function isWorkflowMenu(route) {
  return route?.path === 'workflow' || route?.path === '/workflow' || route?.meta?.title === '流程管理'
}
</script>

<style scoped>
.sidebar-menu-title {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  min-width: 0;
}

.workflow-todo-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 18px;
  height: 18px;
  padding: 0 6px;
  color: #ffffff !important;
  font-size: 12px;
  font-weight: 600;
  line-height: 1;
  background: linear-gradient(180deg, #f87171 0%, #ef4444 100%);
  border: 1px solid rgba(248, 113, 113, 0.88);
  border-radius: 999px;
  box-shadow: 0 6px 14px rgba(239, 68, 68, 0.28);
}

.workflow-todo-badge * {
  color: #ffffff !important;
}
</style>
