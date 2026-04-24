<template>
  <div class="app-container">
    <el-table v-loading="loading" :data="processList">
      <el-table-column label="流程名称" align="center" prop="processDefinitionName" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="业务标题" align="center" prop="businessTitle" min-width="220" :show-overflow-tooltip="true" />
      <el-table-column label="业务类型" align="center" prop="businessType" width="140" />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-tag :type="scope.row.status === 'running' ? 'warning' : 'success'">{{ scope.row.status === 'running' ? '审批中' : '已结束' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="发起时间" align="center" prop="startTime" width="170">
        <template #default="scope">
          <span>{{ parseTime(scope.row.startTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="结束时间" align="center" prop="endTime" width="170">
        <template #default="scope">
          <span>{{ parseTime(scope.row.endTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="100" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Tickets" @click="openHistory(scope.row)" v-hasPermi="['workflow:process:detail']">轨迹</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog title="审批轨迹" v-model="historyOpen" width="860px" append-to-body>
      <el-table v-loading="historyLoading" :data="historyList">
        <el-table-column label="节点" align="center" prop="activityName" min-width="140" />
        <el-table-column label="类型" align="center" prop="activityType" width="140" />
        <el-table-column label="处理人" align="center" prop="assignee" width="120" />
        <el-table-column label="开始时间" align="center" prop="startTime" width="170">
          <template #default="scope">
            <span>{{ parseTime(scope.row.startTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="结束时间" align="center" prop="endTime" width="170">
          <template #default="scope">
            <span>{{ parseTime(scope.row.endTime) }}</span>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script setup name="WorkflowMyStarted">
import { listMyStartedProcess, listWorkflowProcessHistory } from "@/api/workflow/process"

const loading = ref(true)
const processList = ref([])
const historyOpen = ref(false)
const historyLoading = ref(false)
const historyList = ref([])

function getList() {
  loading.value = true
  listMyStartedProcess().then(response => {
    processList.value = response.rows || []
    loading.value = false
  })
}

function openHistory(row) {
  historyOpen.value = true
  historyLoading.value = true
  listWorkflowProcessHistory(row.processInstanceId).then(response => {
    historyList.value = response.rows || []
    historyLoading.value = false
  })
}

getList()
</script>
