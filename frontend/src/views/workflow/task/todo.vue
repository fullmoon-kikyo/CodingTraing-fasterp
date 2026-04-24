<template>
  <div class="app-container">
    <el-table v-loading="loading" :data="taskList">
      <el-table-column label="任务名称" align="center" prop="taskName" width="120" />
      <el-table-column label="业务标题" align="center" prop="businessTitle" min-width="220" :show-overflow-tooltip="true" />
      <el-table-column label="业务类型" align="center" prop="businessType" width="140" />
      <el-table-column label="流程Key" align="center" prop="processDefinitionKey" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="170">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="220" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="CircleCheck" @click="openHandle(scope.row, 'complete')" v-hasPermi="['workflow:task:complete']">同意</el-button>
          <el-button link type="primary" icon="CircleClose" @click="openHandle(scope.row, 'reject')" v-hasPermi="['workflow:task:reject']">驳回</el-button>
          <el-button link type="primary" icon="Tickets" @click="openHistory(scope.row)" v-hasPermi="['workflow:process:detail']">轨迹</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :title="handleTitle" v-model="handleOpen" width="520px" append-to-body>
      <el-form ref="handleRef" :model="handleForm" :rules="handleRules" label-width="80px">
        <el-form-item label="业务">
          <el-input :model-value="handleForm.businessTitle" disabled />
        </el-form-item>
        <el-form-item label="意见" prop="comment">
          <el-input v-model="handleForm.comment" type="textarea" :rows="4" placeholder="请输入审批意见" maxlength="500" show-word-limit />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitHandle">确 定</el-button>
          <el-button @click="handleOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

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

<script setup name="WorkflowTodo">
import { listWorkflowTodo, completeWorkflowTask, rejectWorkflowTask } from "@/api/workflow/task"
import { listWorkflowProcessHistory } from "@/api/workflow/process"

const { proxy } = getCurrentInstance()

const loading = ref(true)
const taskList = ref([])
const handleOpen = ref(false)
const handleType = ref("")
const handleTitle = ref("")
const historyOpen = ref(false)
const historyLoading = ref(false)
const historyList = ref([])

const data = reactive({
  handleForm: {},
  handleRules: {
    comment: [{ validator: validateComment, trigger: "blur" }]
  }
})

const { handleForm, handleRules } = toRefs(data)

function validateComment(rule, value, callback) {
  if (handleType.value === "reject" && !value) {
    callback(new Error("驳回意见不能为空"))
  } else {
    callback()
  }
}

function getList() {
  loading.value = true
  listWorkflowTodo().then(response => {
    taskList.value = response.rows || []
    loading.value = false
  })
}

function openHandle(row, type) {
  handleType.value = type
  handleTitle.value = type === "complete" ? "同意审批" : "驳回审批"
  handleForm.value = {
    taskId: row.taskId,
    businessTitle: row.businessTitle,
    comment: undefined
  }
  handleOpen.value = true
  proxy.resetForm("handleRef")
}

function submitHandle() {
  proxy.$refs["handleRef"].validate(valid => {
    if (!valid) return
    const action = handleType.value === "complete" ? completeWorkflowTask : rejectWorkflowTask
    action(handleForm.value.taskId, { comment: handleForm.value.comment }).then(() => {
      proxy.$modal.msgSuccess(handleTitle.value + "成功")
      handleOpen.value = false
      getList()
    })
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
