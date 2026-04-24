<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="零件号" prop="partNo">
        <el-input v-model="queryParams.partNo" placeholder="请输入零件号" clearable style="width: 180px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="零件名称" prop="partName">
        <el-input v-model="queryParams.partName" placeholder="请输入零件名称" clearable style="width: 180px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="生产机组" prop="productionUnit">
        <el-input v-model="queryParams.productionUnit" placeholder="请输入生产机组" clearable style="width: 180px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="工序" prop="processName">
        <el-input v-model="queryParams.processName" placeholder="请输入工序" clearable style="width: 180px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="物料编码" prop="materialCode">
        <el-input v-model="queryParams.materialCode" placeholder="请输入刀具物料编码" clearable style="width: 190px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="刀具名称" prop="toolName">
        <el-input v-model="queryParams.toolName" placeholder="请输入刀具名称" clearable style="width: 180px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="状态" clearable style="width: 140px">
          <el-option v-for="dict in sys_normal_disable" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="流程状态" prop="approvalStatus">
        <el-select v-model="queryParams.approvalStatus" placeholder="流程状态" clearable style="width: 150px">
          <el-option v-for="dict in tool_approval_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['tooling:partToolList:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['tooling:partToolList:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['tooling:partToolList:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['tooling:partToolList:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="partToolList" :row-class-name="tableRowClassName" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="清单ID" align="center" prop="listId" width="90" />
      <el-table-column label="零件号" align="center" prop="partNo" min-width="130" :show-overflow-tooltip="true" />
      <el-table-column label="零件名称" align="center" prop="partName" min-width="140" :show-overflow-tooltip="true" />
      <el-table-column label="生产机组" align="center" prop="productionUnit" min-width="120" :show-overflow-tooltip="true" />
      <el-table-column label="工序号" align="center" prop="processNo" min-width="100" :show-overflow-tooltip="true" />
      <el-table-column label="工序名称" align="center" prop="processName" min-width="130" :show-overflow-tooltip="true" />
      <el-table-column label="刀具物料编码" align="center" prop="materialCode" min-width="150" :show-overflow-tooltip="true" />
      <el-table-column label="刀具名称" align="center" prop="toolName" min-width="160" :show-overflow-tooltip="true" />
      <el-table-column label="刀具牌号" align="center" prop="toolBrand" min-width="120" :show-overflow-tooltip="true" />
      <el-table-column label="刀具规格" align="center" prop="toolSpec" min-width="120" :show-overflow-tooltip="true" />
      <el-table-column label="刀具型号" align="center" prop="toolModel" min-width="120" :show-overflow-tooltip="true" />
      <el-table-column label="刀具寿命" align="center" prop="toolLife" width="110" />
      <el-table-column label="寿命单位" align="center" prop="toolLifeUnit" width="100" />
      <el-table-column label="状态" align="center" prop="displayStatus" width="130">
        <template #default="scope">
          <el-tag v-if="isToolChanged(scope.row)" type="info">刀具信息变化</el-tag>
          <dict-tag v-else :options="sys_normal_disable" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="流程状态" align="center" prop="approvalStatus" width="110">
        <template #default="scope">
          <dict-tag :options="tool_approval_status" :value="scope.row.approvalStatus" />
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="230" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button v-if="canEdit(scope.row)" link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['tooling:partToolList:edit']">修改</el-button>
          <el-button v-if="canDelete(scope.row)" link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['tooling:partToolList:remove']">删除</el-button>
          <el-button v-if="canSubmit(scope.row)" link type="primary" icon="Promotion" @click="openSubmitApproval(scope.row)" v-hasPermi="['tooling:partToolList:submit']">提交</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="820px" append-to-body>
      <el-form ref="partToolListRef" :model="form" :rules="rules" label-width="110px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="零件号" prop="partNo">
              <el-input v-model="form.partNo" placeholder="请输入零件号" maxlength="64" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="零件名称" prop="partName">
              <el-input v-model="form.partName" placeholder="请输入零件名称" maxlength="100" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="生产机组" prop="productionUnit">
              <el-input v-model="form.productionUnit" placeholder="请输入生产机组" maxlength="100" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="工序号" prop="processNo">
              <el-input v-model="form.processNo" placeholder="请输入工序号" maxlength="64" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="工序名称" prop="processName">
              <el-input v-model="form.processName" placeholder="请输入工序名称" maxlength="100" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="刀具物料编码" prop="toolId">
              <el-input v-model="form.materialCode" placeholder="请引用刀具物料" readonly>
                <template #append>
                  <el-tooltip content="引用" placement="top">
                    <el-button icon="Search" @click="openToolReference" />
                  </el-tooltip>
                </template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="刀具名称" prop="toolName">
              <el-input v-model="form.toolName" placeholder="引用后自动带出" readonly />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="刀具牌号" prop="toolBrand">
              <el-input v-model="form.toolBrand" placeholder="引用后自动带出" readonly />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="刀具规格" prop="toolSpec">
              <el-input v-model="form.toolSpec" placeholder="引用后自动带出" readonly />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="刀具型号" prop="toolModel">
              <el-input v-model="form.toolModel" placeholder="引用后自动带出" readonly />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="刀具类别" prop="toolCategory">
              <el-input v-model="form.toolCategory" placeholder="引用后自动带出" readonly />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="生产厂家" prop="manufacturer">
              <el-input v-model="form.manufacturer" placeholder="引用后自动带出" readonly />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="刀具寿命" prop="toolLife">
              <el-input-number v-model="form.toolLife" controls-position="right" :min="0" :precision="2" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="寿命单位" prop="toolLifeUnit">
              <el-input v-model="form.toolLifeUnit" placeholder="请输入寿命单位，如 件、分钟、次" maxlength="32" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio v-for="dict in sys_normal_disable" :key="dict.value" :value="dict.value">{{ dict.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="流程状态" prop="approvalStatus">
              <dict-tag :options="tool_approval_status" :value="form.approvalStatus || 'draft'" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" maxlength="500" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="提交审批" v-model="approvalOpen" width="520px" append-to-body>
      <el-form ref="approvalRef" :model="approvalForm" label-width="90px">
        <el-form-item label="零件号">
          <el-input :model-value="approvalForm.partNo" disabled />
        </el-form-item>
        <el-form-item label="零件名称">
          <el-input :model-value="approvalForm.partName" disabled />
        </el-form-item>
        <el-form-item label="审批意见">
          <el-input v-model="approvalForm.opinion" type="textarea" :rows="4" placeholder="请输入提交意见" maxlength="500" show-word-limit />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitApproval">确 定</el-button>
          <el-button @click="approvalOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="引用刀具" v-model="toolReferenceOpen" width="900px" append-to-body>
      <el-form :model="toolQueryParams" ref="toolQueryRef" :inline="true">
        <el-form-item label="物料编码" prop="materialCode">
          <el-input v-model="toolQueryParams.materialCode" placeholder="请输入刀具物料编码" clearable style="width: 200px" @keyup.enter="handleToolQuery" />
        </el-form-item>
        <el-form-item label="刀具名称" prop="toolName">
          <el-input v-model="toolQueryParams.toolName" placeholder="请输入刀具名称" clearable style="width: 200px" @keyup.enter="handleToolQuery" />
        </el-form-item>
        <el-form-item label="刀具牌号" prop="toolBrand">
          <el-input v-model="toolQueryParams.toolBrand" placeholder="请输入刀具牌号" clearable style="width: 200px" @keyup.enter="handleToolQuery" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleToolQuery">搜索</el-button>
          <el-button icon="Refresh" @click="resetToolQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <el-table v-loading="toolLoading" :data="toolOptions">
        <el-table-column label="物料编码" align="center" prop="materialCode" min-width="140" :show-overflow-tooltip="true" />
        <el-table-column label="刀具名称" align="center" prop="toolName" min-width="160" :show-overflow-tooltip="true" />
        <el-table-column label="刀具牌号" align="center" prop="toolBrand" min-width="120" :show-overflow-tooltip="true" />
        <el-table-column label="规格" align="center" prop="toolSpec" min-width="120" :show-overflow-tooltip="true" />
        <el-table-column label="型号" align="center" prop="toolModel" min-width="120" :show-overflow-tooltip="true" />
        <el-table-column label="类别" align="center" prop="toolCategory" min-width="120" :show-overflow-tooltip="true" />
        <el-table-column label="生产厂家" align="center" prop="manufacturer" min-width="130" :show-overflow-tooltip="true" />
        <el-table-column label="操作" align="center" width="90">
          <template #default="scope">
            <el-button link type="primary" @click="selectTool(scope.row)">选择</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="toolTotal > 0" :total="toolTotal" v-model:page="toolQueryParams.pageNum" v-model:limit="toolQueryParams.pageSize" @pagination="getToolOptions" />
    </el-dialog>
  </div>
</template>

<script setup name="PartToolList">
import { listPartToolList, getPartToolList, delPartToolList, addPartToolList, updatePartToolList, submitPartToolList } from "@/api/tooling/partToolList"
import { listMachiningTool } from "@/api/tooling/machiningTool"

const { proxy } = getCurrentInstance()
const { sys_normal_disable, tool_approval_status } = useDict("sys_normal_disable", "tool_approval_status")

const partToolList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const toolReferenceOpen = ref(false)
const toolLoading = ref(false)
const toolOptions = ref([])
const toolTotal = ref(0)
const approvalOpen = ref(false)
const approvalForm = ref({})

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    partNo: undefined,
    partName: undefined,
    productionUnit: undefined,
    processName: undefined,
    materialCode: undefined,
    toolName: undefined,
    status: undefined,
    approvalStatus: undefined
  },
  toolQueryParams: {
    pageNum: 1,
    pageSize: 10,
    materialCode: undefined,
    toolName: undefined,
    toolBrand: undefined,
    status: "0",
    approvalStatus: "effective"
  },
  rules: {
    partNo: [{ required: true, message: "零件号不能为空", trigger: "blur" }],
    partName: [{ required: true, message: "零件名称不能为空", trigger: "blur" }],
    toolId: [{ required: true, message: "请引用刀具物料", trigger: "change" }]
  }
})

const { queryParams, form, toolQueryParams, rules } = toRefs(data)

function isToolChanged(row) {
  return Number(row.toolInfoChanged) === 1
}

function tableRowClassName({ row }) {
  return isToolChanged(row) ? "tool-info-changed-row" : ""
}

function isLocked(row) {
  return row && row.approvalStatus === "processing"
}

function canEdit(row) {
  return !isLocked(row)
}

function canDelete(row) {
  return ["draft", "rejected"].includes(row.approvalStatus)
}

function canSubmit(row) {
  return ["draft", "rejected"].includes(row.approvalStatus)
}

function getList() {
  loading.value = true
  listPartToolList(queryParams.value).then(response => {
    partToolList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    listId: undefined,
    partNo: undefined,
    partName: undefined,
    productionUnit: undefined,
    processNo: undefined,
    processName: undefined,
    toolId: undefined,
    materialCode: undefined,
    toolName: undefined,
    toolBrand: undefined,
    toolSpec: undefined,
    toolModel: undefined,
    toolCategory: undefined,
    manufacturer: undefined,
    toolLife: undefined,
    toolLifeUnit: "件",
    status: "0",
    approvalStatus: "draft",
    remark: undefined
  }
  proxy.resetForm("partToolListRef")
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.listId)
  single.value = selection.length != 1 || isLocked(selection[0])
  multiple.value = !selection.length || selection.some(item => !canDelete(item))
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "添加零件刀具清单"
}

function handleUpdate(row) {
  reset()
  const target = row.listId ? row : partToolList.value.find(item => item.listId === ids.value[0])
  if (isLocked(target)) {
    proxy.$modal.msgWarning("审签中的零件刀具清单不能修改，请先驳回或退回")
    return
  }
  const listId = row.listId || ids.value
  getPartToolList(listId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改零件刀具清单"
  })
}

function submitForm() {
  proxy.$refs["partToolListRef"].validate(valid => {
    if (valid) {
      if (form.value.listId != undefined) {
        updatePartToolList(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addPartToolList(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

function handleDelete(row) {
  const rows = row.listId ? [row] : partToolList.value.filter(item => ids.value.includes(item.listId))
  if (rows.some(item => !canDelete(item))) {
    proxy.$modal.msgWarning("仅草稿或已驳回状态的零件刀具清单允许删除")
    return
  }
  const listIds = row.listId || ids.value
  proxy.$modal.confirm('是否确认删除清单编号为"' + listIds + '"的数据项？').then(function() {
    return delPartToolList(listIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

function openSubmitApproval(row) {
  approvalForm.value = {
    listId: row.listId,
    partNo: row.partNo,
    partName: row.partName,
    opinion: undefined
  }
  approvalOpen.value = true
}

function submitApproval() {
  submitPartToolList(approvalForm.value.listId, { opinion: approvalForm.value.opinion }).then(() => {
    proxy.$modal.msgSuccess("提交审批成功")
    approvalOpen.value = false
    getList()
  })
}

function handleExport() {
  proxy.download("tooling/partToolList/export", {
    ...queryParams.value
  }, `part_tool_list_${new Date().getTime()}.xlsx`)
}

function openToolReference() {
  toolReferenceOpen.value = true
  toolQueryParams.value.pageNum = 1
  getToolOptions()
}

function getToolOptions() {
  toolLoading.value = true
  listMachiningTool(toolQueryParams.value).then(response => {
    toolOptions.value = response.rows
    toolTotal.value = response.total
    toolLoading.value = false
  })
}

function handleToolQuery() {
  toolQueryParams.value.pageNum = 1
  getToolOptions()
}

function resetToolQuery() {
  proxy.resetForm("toolQueryRef")
  toolQueryParams.value.status = "0"
  toolQueryParams.value.approvalStatus = "effective"
  handleToolQuery()
}

function selectTool(row) {
  form.value.toolId = row.toolId
  form.value.materialCode = row.materialCode
  form.value.toolName = row.toolName
  form.value.toolBrand = row.toolBrand
  form.value.toolSpec = row.toolSpec
  form.value.toolModel = row.toolModel
  form.value.toolCategory = row.toolCategory
  form.value.manufacturer = row.manufacturer
  toolReferenceOpen.value = false
  proxy.$refs["partToolListRef"]?.validateField("toolId")
}

getList()
</script>

<style scoped lang="scss">
:deep(.tool-info-changed-row) {
  color: #909399;
  background-color: #f5f7fa;
}

:deep(.tool-info-changed-row td.el-table__cell) {
  background-color: #f5f7fa !important;
}
</style>
