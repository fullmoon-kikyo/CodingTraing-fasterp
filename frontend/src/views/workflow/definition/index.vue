<template>
  <div class="app-container">
    <el-alert
      title="当前已内置机加刀具信息审批流程，支持启用、停用与版本查看。"
      type="info"
      show-icon
      class="mb8"
    />

    <el-table v-loading="loading" :data="definitionList">
      <el-table-column label="流程名称" align="center" prop="name" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="流程Key" align="center" prop="key" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="版本" align="center" prop="version" width="90" />
      <el-table-column label="部署ID" align="center" prop="deploymentId" min-width="160" :show-overflow-tooltip="true" />
      <el-table-column label="部署时间" align="center" prop="deploymentTime" width="170">
        <template #default="scope">
          <span>{{ parseTime(scope.row.deploymentTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="suspended" width="100">
        <template #default="scope">
          <el-tag :type="scope.row.suspended ? 'danger' : 'success'">{{ scope.row.suspended ? '停用' : '启用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="160" fixed="right">
        <template #default="scope">
          <el-button v-if="scope.row.suspended" link type="primary" icon="VideoPlay" @click="handleActivate(scope.row)" v-hasPermi="['workflow:definition:edit']">启用</el-button>
          <el-button v-else link type="primary" icon="VideoPause" @click="handleSuspend(scope.row)" v-hasPermi="['workflow:definition:edit']">停用</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup name="WorkflowDefinition">
import { listWorkflowDefinition, suspendWorkflowDefinition, activateWorkflowDefinition } from "@/api/workflow/definition"

const { proxy } = getCurrentInstance()

const loading = ref(true)
const definitionList = ref([])

function getList() {
  loading.value = true
  listWorkflowDefinition().then(response => {
    definitionList.value = response.rows || []
    loading.value = false
  })
}

function handleSuspend(row) {
  proxy.$modal.confirm('是否确认停用流程"' + row.name + '"？').then(() => {
    return suspendWorkflowDefinition(row.definitionId)
  }).then(() => {
    proxy.$modal.msgSuccess("停用成功")
    getList()
  }).catch(() => {})
}

function handleActivate(row) {
  activateWorkflowDefinition(row.definitionId).then(() => {
    proxy.$modal.msgSuccess("启用成功")
    getList()
  })
}

getList()
</script>
