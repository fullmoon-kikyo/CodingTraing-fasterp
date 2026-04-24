<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" class="query-toolbar" v-show="showSearch">
      <div class="query-primary">
        <el-form-item label="物料编码" prop="materialCode">
          <el-input v-model="queryParams.materialCode" placeholder="请输入刀具物料编码" clearable class="query-input" @keyup.enter="handleQuery" />
        </el-form-item>
        <el-form-item label="刀具名称" prop="toolName">
          <el-input v-model="queryParams.toolName" placeholder="请输入刀具名称" clearable class="query-input" @keyup.enter="handleQuery" />
        </el-form-item>
        <el-form-item label="刀具牌号" prop="toolBrand">
          <el-input v-model="queryParams.toolBrand" placeholder="请输入刀具牌号" clearable class="query-input" @keyup.enter="handleQuery" />
        </el-form-item>
      </div>
      <div class="query-actions">
        <el-popover placement="bottom-end" width="360" trigger="click" popper-class="machining-tool-query-popper">
          <template #reference>
            <el-button icon="Filter">详细查询</el-button>
          </template>
          <div class="advanced-query-panel">
            <div class="advanced-query-title">更多查询条件</div>
            <el-form-item label="使用状态" prop="status">
              <el-select v-model="queryParams.status" placeholder="使用状态" clearable class="advanced-query-control">
                <el-option v-for="dict in usageStatusOptions" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
            <el-form-item label="物料状态" prop="materialStatus">
              <el-select v-model="queryParams.materialStatus" placeholder="物料状态" clearable class="advanced-query-control">
                <el-option v-for="item in materialStatusOptions" :key="item.value" :label="item.label" :value="item.value" />
              </el-select>
            </el-form-item>
            <el-form-item label="流程状态" prop="approvalStatus">
              <el-select v-model="queryParams.approvalStatus" placeholder="流程状态" clearable class="advanced-query-control">
                <el-option v-for="dict in tool_approval_status" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </div>
        </el-popover>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </div>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['tooling:machiningTool:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['tooling:machiningTool:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['tooling:machiningTool:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['tooling:machiningTool:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table
      ref="tableRef"
      v-loading="loading"
      :data="machiningToolList"
      :row-class-name="getTableRowClassName"
      @selection-change="handleSelectionChange"
      @row-click="handleRowClick"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="刀具ID" align="center" prop="toolId" width="90" />
      <el-table-column label="物料编码" align="center" prop="materialCode" min-width="140" :show-overflow-tooltip="true" />
      <el-table-column label="版本" align="center" prop="materialVersion" width="80">
        <template #default="scope">
          <span>{{ scope.row.materialVersion || 'A01' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="刀具名称" align="center" prop="toolName" min-width="160" :show-overflow-tooltip="true" />
      <el-table-column label="刀具牌号" align="center" prop="toolBrand" min-width="120" :show-overflow-tooltip="true" />
      <el-table-column label="规格" align="center" prop="toolSpec" min-width="120" :show-overflow-tooltip="true" />
      <el-table-column label="型号" align="center" prop="toolModel" min-width="120" :show-overflow-tooltip="true" />
      <el-table-column label="类别" align="center" prop="toolCategory" min-width="120" :show-overflow-tooltip="true" />
      <el-table-column label="生产厂家" align="center" prop="manufacturer" min-width="140" :show-overflow-tooltip="true" />
      <el-table-column label="使用状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-tag :type="usageStatusTagType(scope.row.status)">{{ usageStatusLabel(scope.row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="物料状态" align="center" width="100">
        <template #default="scope">
          <el-tag :type="materialStatusTagType(scope.row.materialStatus, scope.row.approvalStatus)">{{ materialStatusLabel(scope.row.materialStatus, scope.row.approvalStatus) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="流程状态" align="center" prop="approvalStatus" width="110">
        <template #default="scope">
          <el-tag class="process-status-tag" :class="processStatusClass(scope.row.approvalStatus)">
            {{ processStatusLabel(scope.row.approvalStatus) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
    </el-table>

    <teleport to="body">
      <div
        v-if="hoverToolbar.visible && hoverToolbar.row && hasAnyHoverActions(hoverToolbar.row)"
        class="machining-tool-hoverbar"
        :style="hoverToolbarStyle"
      >
        <div class="machining-tool-hoverbar__shell">
          <el-button
            v-if="canEdit(hoverToolbar.row)"
            class="machining-tool-pill"
            v-hasPermi="EDIT_PERMS"
            @click.stop="handleUpdate(hoverToolbar.row)"
          >
            编辑
          </el-button>
          <el-button
            class="machining-tool-pill machining-tool-pill--soft"
            v-hasPermi="QUERY_PERMS"
            @click.stop="openVersionDialog(hoverToolbar.row)"
          >
            版本
          </el-button>
          <el-popover
            v-if="hasSecondaryActions(hoverToolbar.row)"
            :visible="actionPopoverRowId === hoverToolbar.row.toolId"
            trigger="manual"
            placement="bottom-end"
            :offset="10"
            :show-arrow="false"
            popper-class="machining-tool-action-popper"
            @show="clearActionPopoverTimer"
            @hide="clearActionPopoverTimer"
          >
            <template #reference>
              <el-button
                circle
                class="machining-tool-actions__more"
                icon="MoreFilled"
                @mouseenter.stop="openActionPopover(hoverToolbar.row.toolId)"
                @mouseleave.stop="scheduleCloseActionPopover(hoverToolbar.row.toolId)"
                @click.stop="toggleActionPopover(hoverToolbar.row.toolId)"
              />
            </template>
            <div
              class="machining-tool-action-menu"
              @mouseenter="openActionPopover(hoverToolbar.row.toolId)"
              @mouseleave="scheduleCloseActionPopover(hoverToolbar.row.toolId)"
            >
              <el-button
                v-for="action in getSecondaryActions(hoverToolbar.row)"
                :key="action.key"
                link
                :type="action.type"
                :icon="action.icon"
                class="machining-tool-action-menu__item"
                v-hasPermi="action.perms"
                @click.stop="handleSecondaryAction(action.key, hoverToolbar.row)"
              >
                {{ action.label }}
              </el-button>
            </div>
          </el-popover>
        </div>
      </div>
    </teleport>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="720px" append-to-body>
      <el-form ref="machiningToolRef" :model="form" :rules="rules" label-width="110px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="物料编码" prop="materialCode">
              <el-input v-model="form.materialCode" placeholder="请输入刀具物料编码" maxlength="64" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="刀具名称" prop="toolName">
              <el-input v-model="form.toolName" placeholder="请输入刀具名称" maxlength="100" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="刀具牌号" prop="toolBrand">
              <el-input v-model="form.toolBrand" placeholder="请输入刀具牌号" maxlength="100" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="刀具规格" prop="toolSpec">
              <el-input v-model="form.toolSpec" placeholder="请输入刀具规格" maxlength="100" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="刀具型号" prop="toolModel">
              <el-input v-model="form.toolModel" placeholder="请输入刀具型号" maxlength="100" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="刀具类别" prop="toolCategory">
              <el-input v-model="form.toolCategory" placeholder="请输入刀具类别" maxlength="100" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="生产厂家" prop="manufacturer">
              <el-input v-model="form.manufacturer" placeholder="请输入生产厂家" maxlength="100" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="使用状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio v-for="dict in usageStatusOptions" :key="dict.value" :value="dict.value">{{ dict.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="8">
            <el-form-item label="版本">
              <el-input :model-value="form.materialVersion || 'A01'" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="物料状态">
              <el-tag :type="materialStatusTagType(form.materialStatus || 'draft', form.approvalStatus || 'draft')">{{ materialStatusLabel(form.materialStatus || 'draft', form.approvalStatus || 'draft') }}</el-tag>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="流程状态" prop="approvalStatus">
              <el-tag class="process-status-tag" :class="processStatusClass(form.approvalStatus || 'draft')">
                {{ processStatusLabel(form.approvalStatus || 'draft') }}
              </el-tag>
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

    <el-dialog :title="approvalTitle" v-model="approvalOpen" width="520px" append-to-body>
      <el-form ref="approvalRef" :model="approvalForm" label-width="90px">
        <el-form-item label="物料编码">
          <el-input :model-value="approvalForm.materialCode" disabled />
        </el-form-item>
        <el-form-item label="版本">
          <el-input :model-value="approvalForm.materialVersion || 'A01'" disabled />
        </el-form-item>
        <el-form-item label="刀具名称">
          <el-input :model-value="approvalForm.toolName" disabled />
        </el-form-item>
        <el-form-item :label="approvalMode === 'change' ? '申请说明' : '提交意见'">
          <el-input v-model="approvalForm.opinion" type="textarea" :rows="4" :placeholder="approvalMode === 'change' ? '请输入修改申请说明' : '请输入提交意见'" maxlength="500" show-word-limit />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitApproval">确 定</el-button>
          <el-button @click="approvalOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="历史版本" v-model="versionOpen" width="1080px" append-to-body>
      <el-table v-loading="versionLoading" :data="versionList" border>
        <el-table-column label="版本" align="center" prop="materialVersion" width="80">
          <template #default="scope">
            <span>{{ scope.row.materialVersion || 'A01' }}</span>
          </template>
        </el-table-column>
        <el-table-column label="物料编码" align="center" prop="materialCode" min-width="140" :show-overflow-tooltip="true" />
        <el-table-column label="刀具名称" align="center" prop="toolName" min-width="150" :show-overflow-tooltip="true" />
        <el-table-column label="刀具牌号" align="center" prop="toolBrand" min-width="120" :show-overflow-tooltip="true" />
        <el-table-column label="规格" align="center" prop="toolSpec" min-width="120" :show-overflow-tooltip="true" />
        <el-table-column label="型号" align="center" prop="toolModel" min-width="120" :show-overflow-tooltip="true" />
        <el-table-column label="类别" align="center" prop="toolCategory" min-width="120" :show-overflow-tooltip="true" />
        <el-table-column label="生产厂家" align="center" prop="manufacturer" min-width="140" :show-overflow-tooltip="true" />
        <el-table-column label="使用状态" align="center" prop="status" width="100">
          <template #default="scope">
            <el-tag :type="usageStatusTagType(scope.row.status)">{{ usageStatusLabel(scope.row.status) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="物料状态" align="center" width="100">
          <template #default="scope">
            <el-tag :type="materialStatusTagType(scope.row.materialStatus, scope.row.approvalStatus)">{{ materialStatusLabel(scope.row.materialStatus, scope.row.approvalStatus) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="流程状态" align="center" width="120">
          <template #default="scope">
            <el-tag class="process-status-tag" :class="processStatusClass(scope.row.approvalStatus)">
              {{ processStatusLabel(scope.row.approvalStatus) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="快照人" align="center" prop="snapshotBy" width="110" />
        <el-table-column label="快照时间" align="center" prop="snapshotTime" width="160">
          <template #default="scope">
            <span>{{ parseTime(scope.row.snapshotTime) }}</span>
          </template>
        </el-table-column>
      </el-table>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="versionOpen = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>

  </div>
</template>

<script setup name="MachiningTool">
import {
  listMachiningTool,
  getMachiningTool,
  delMachiningTool,
  forceDelMachiningTool,
  addMachiningTool,
  updateMachiningTool,
  submitMachiningTool,
  changeApplyMachiningTool,
  listMachiningToolVersions
} from "@/api/tooling/machiningTool"
import { checkPermi, checkRole } from "@/utils/permission"
import { TOOL_MATERIAL_STATUS_OPTIONS, TOOL_USAGE_STATUS_OPTIONS, getToolMaterialStatusLabel, getToolUsageStatusLabel, getToolUsageStatusTagType } from "@/utils/toolingStatus"
import useUserStore from "@/store/modules/user"

const { proxy } = getCurrentInstance()
const { tool_usage_status, tool_approval_status } = useDict("tool_usage_status", "tool_approval_status")
const userStore = useUserStore()
const usageStatusOptions = computed(() => tool_usage_status.value?.length ? tool_usage_status.value : TOOL_USAGE_STATUS_OPTIONS)
const materialStatusOptions = TOOL_MATERIAL_STATUS_OPTIONS
const STATUS_DRAFT = "draft"
const STATUS_PROCESSING = "processing"
const STATUS_EFFECTIVE = "effective"
const STATUS_REJECTED = "rejected"
const STATUS_CHANGE_PROCESSING = "change_processing"
const STATUS_CHANGING = "changing"
const STATUS_CHANGE_REJECTED = "change_rejected"
const EDIT_PERMS = ["tooling:machiningTool:edit"]
const REMOVE_PERMS = ["tooling:machiningTool:remove"]
const SUBMIT_PERMS = ["tooling:machiningTool:submit"]
const QUERY_PERMS = ["tooling:machiningTool:query"]
const HOVER_TOOLBAR_ANCHOR_RATIO = 0.7
const HOVER_TOOLBAR_MIN_LEFT = 220
const HOVER_TOOLBAR_VERTICAL_OFFSET = -10

const machiningToolList = ref([])
const tableRef = ref()
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const forceMultiple = ref(true)
const total = ref(0)
const title = ref("")
const selectedRows = ref([])
const approvalOpen = ref(false)
const approvalMode = ref("submit")
const approvalTitle = ref("提交审批")
const versionOpen = ref(false)
const versionLoading = ref(false)
const versionList = ref([])
const actionPopoverRowId = ref(undefined)
const hoverToolbar = reactive({
  visible: false,
  row: null,
  top: 0,
  left: 0
})
const hasForceRemovePerm = checkPermi(["tooling:machiningTool:forceRemove"])
const hasToolAuditRole = checkRole(["admin", "tool_auditor"])
const currentUsername = computed(() => userStore.name)
let actionPopoverTimer = null

const data = reactive({
  form: {},
  approvalForm: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    materialCode: undefined,
    toolName: undefined,
    toolBrand: undefined,
    status: undefined,
    materialStatus: undefined,
    approvalStatus: undefined
  },
  rules: {
    materialCode: [{ required: true, message: "刀具物料编码不能为空", trigger: "blur" }],
    toolName: [{ required: true, message: "刀具名称不能为空", trigger: "blur" }]
  },
  approvalRules: {}
})

const { queryParams, form, rules, approvalForm } = toRefs(data)

function isDraftMaterialStatus(status) {
  return status === STATUS_DRAFT
}

function isEditableMaterialStatus(status) {
  return status === STATUS_DRAFT
}

function isSubmittableApprovalStatus(status) {
  return [STATUS_DRAFT, STATUS_REJECTED].includes(status)
}

function resolveMaterialStatus(materialStatus, approvalStatus) {
  if (materialStatus) {
    return materialStatus
  }
  if (approvalStatus === STATUS_PROCESSING) {
    return STATUS_PROCESSING
  }
  if ([STATUS_EFFECTIVE, STATUS_CHANGE_PROCESSING, STATUS_CHANGE_REJECTED].includes(approvalStatus)) {
    return STATUS_EFFECTIVE
  }
  return STATUS_DRAFT
}

function materialStatusLabel(materialStatus, approvalStatus) {
  const status = resolveMaterialStatus(materialStatus, approvalStatus)
  return getToolMaterialStatusLabel(status)
}

function usageStatusLabel(status) {
  return getToolUsageStatusLabel(status, usageStatusOptions.value)
}

function usageStatusTagType(status) {
  return getToolUsageStatusTagType(status, usageStatusOptions.value)
}

function materialStatusTagType(materialStatus, approvalStatus) {
  const status = resolveMaterialStatus(materialStatus, approvalStatus)
  if (isDraftMaterialStatus(status)) {
    return "info"
  }
  if (status === STATUS_PROCESSING) {
    return "warning"
  }
  if (status === STATUS_EFFECTIVE) {
    return "success"
  }
  return "info"
}

function processStatusLabel(status) {
  if (status === STATUS_DRAFT) {
    return "待提交"
  }
  if (status === STATUS_PROCESSING) {
    return "审批流"
  }
  if (status === STATUS_REJECTED) {
    return "驳回"
  }
  if (status === STATUS_EFFECTIVE) {
    return "审签完成"
  }
  if (status === STATUS_CHANGE_PROCESSING) {
    return "变更审批中"
  }
  if (status === STATUS_CHANGING) {
    return "变更中"
  }
  if (status === STATUS_CHANGE_REJECTED) {
    return "变更驳回"
  }
  return "未知"
}

function processStatusClass(status) {
  if (status === STATUS_DRAFT) {
    return "process-status-draft"
  }
  if (status === STATUS_PROCESSING) {
    return "process-status-processing"
  }
  if (status === STATUS_CHANGE_PROCESSING) {
    return "process-status-change-processing"
  }
  if (status === STATUS_REJECTED || status === STATUS_CHANGE_REJECTED) {
    return "process-status-rejected"
  }
  if (status === STATUS_EFFECTIVE) {
    return "process-status-effective"
  }
  if (status === STATUS_CHANGING) {
    return "process-status-changing"
  }
  return "process-status-draft"
}

function isApplicant(row) {
  return !!row && row.createBy === currentUsername.value
}

function isChangeApplicant(row) {
  return !!row && row.changeApplyBy === currentUsername.value
}

function isChangeEditable(row) {
  return !!row?.changeApplyBy && [STATUS_CHANGING, STATUS_REJECTED].includes(row.approvalStatus)
}

function canApplyChange(row) {
  if (!row) {
    return false
  }
  const materialStatus = resolveMaterialStatus(row.materialStatus, row.approvalStatus)
  return materialStatus === STATUS_EFFECTIVE && [STATUS_EFFECTIVE, STATUS_CHANGE_REJECTED].includes(row.approvalStatus)
}

function canEdit(row) {
  if (!row) {
    return false
  }
  if (canApplyChange(row)) {
    return true
  }
  if (row.approvalStatus === STATUS_CHANGE_PROCESSING) {
    return false
  }
  if (isChangeEditable(row)) {
    return isChangeApplicant(row)
  }
  const materialStatus = resolveMaterialStatus(row?.materialStatus, row?.approvalStatus)
  if (materialStatus === STATUS_EFFECTIVE) {
    return false
  }
  return hasToolAuditRole || (isApplicant(row) && isEditableMaterialStatus(materialStatus))
}

function canDelete(row) {
  const materialStatus = resolveMaterialStatus(row?.materialStatus, row?.approvalStatus)
  return hasToolAuditRole || (isApplicant(row) && isDraftMaterialStatus(materialStatus))
}

function canSubmit(row) {
  if (isChangeEditable(row)) {
    return isChangeApplicant(row)
  }
  return (hasToolAuditRole || isApplicant(row)) && isSubmittableApprovalStatus(row?.approvalStatus)
}

function clearActionPopoverTimer() {
  if (actionPopoverTimer) {
    clearTimeout(actionPopoverTimer)
    actionPopoverTimer = null
  }
}

function closeHoverToolbar() {
  closeActionPopover()
  hoverToolbar.visible = false
  hoverToolbar.row = null
}

function openHoverToolbar() {
  if (hoverToolbar.row) {
    hoverToolbar.visible = true
  }
}

function openActionPopover(toolId) {
  clearActionPopoverTimer()
  actionPopoverRowId.value = toolId
  openHoverToolbar()
}

function scheduleCloseActionPopover(toolId) {
  clearActionPopoverTimer()
  actionPopoverTimer = setTimeout(() => {
    if (actionPopoverRowId.value === toolId) {
      actionPopoverRowId.value = undefined
    }
  }, 140)
}

function toggleActionPopover(toolId) {
  clearActionPopoverTimer()
  actionPopoverRowId.value = actionPopoverRowId.value === toolId ? undefined : toolId
}

function closeActionPopover() {
  clearActionPopoverTimer()
  actionPopoverRowId.value = undefined
}

const hoverToolbarStyle = computed(() => ({
  top: `${hoverToolbar.top}px`,
  left: `${hoverToolbar.left}px`
}))

function getSecondaryActions(row) {
  const actions = []
  if (checkPermi(SUBMIT_PERMS) && canSubmit(row)) {
    actions.push({ key: "submit", label: "提交", icon: "Promotion", type: "primary", perms: SUBMIT_PERMS })
  }
  if (checkPermi(REMOVE_PERMS) && canDelete(row)) {
    actions.push({ key: "delete", label: "删除", icon: "Delete", type: "primary", perms: REMOVE_PERMS })
  }
  if (hasForceRemovePerm) {
    actions.push({ key: "forceDelete", label: "强制删除", icon: "DeleteFilled", type: "danger", perms: ["tooling:machiningTool:forceRemove"] })
  }
  return actions
}

function hasSecondaryActions(row) {
  return getSecondaryActions(row).length > 0
}

function hasAnyHoverActions(row) {
  return (checkPermi(EDIT_PERMS) && canEdit(row)) || checkPermi(QUERY_PERMS) || hasSecondaryActions(row)
}

function handleSecondaryAction(actionKey, row) {
  closeActionPopover()
  if (actionKey === "submit") {
    openApproval(row)
    return
  }
  if (actionKey === "delete") {
    handleDelete(row)
    return
  }
  if (actionKey === "forceDelete") {
    handleForceDelete(row)
  }
}

function getList() {
  loading.value = true
  closeHoverToolbar()
  closeActionPopover()
  listMachiningTool(queryParams.value).then(response => {
    machiningToolList.value = response.rows
    total.value = response.total
    selectedRows.value = []
    ids.value = []
    single.value = true
    multiple.value = true
    forceMultiple.value = true
    tableRef.value?.clearSelection()
    loading.value = false
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    toolId: undefined,
    materialCode: undefined,
    toolName: undefined,
    toolBrand: undefined,
    toolSpec: undefined,
    toolModel: undefined,
    toolCategory: undefined,
    manufacturer: undefined,
    status: "0",
    materialVersion: "A01",
    materialStatus: "draft",
    approvalStatus: "draft",
    changeApplyBy: undefined,
    remark: undefined
  }
  proxy.resetForm("machiningToolRef")
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  Object.assign(queryParams.value, {
    materialCode: undefined,
    toolName: undefined,
    toolBrand: undefined,
    status: undefined,
    materialStatus: undefined,
    approvalStatus: undefined
  })
  handleQuery()
}

function handleSelectionChange(selection) {
  selectedRows.value = selection
  ids.value = selection.map(item => item.toolId)
  single.value = selection.length !== 1 || !canEdit(selection[0])
  multiple.value = !selection.length || selection.some(item => !canDelete(item))
  forceMultiple.value = !selection.length
  syncHoverToolbar(selection)
}

function updateHoverToolbarPosition(cell) {
  const rowElement = cell?.closest("tr")
  if (!rowElement) {
    return
  }
  const rowRect = rowElement.getBoundingClientRect()
  hoverToolbar.top = rowRect.top + rowRect.height / 2 + HOVER_TOOLBAR_VERTICAL_OFFSET
  hoverToolbar.left = Math.max(HOVER_TOOLBAR_MIN_LEFT, rowRect.left + rowRect.width * HOVER_TOOLBAR_ANCHOR_RATIO)
}

function updateHoverToolbarPositionByRow(row) {
  const rowIndex = machiningToolList.value.findIndex(item => item.toolId === row?.toolId)
  const tableElement = tableRef.value?.$el
  if (rowIndex < 0 || !tableElement) {
    return
  }
  const rowElement = tableElement.querySelectorAll(".el-table__body-wrapper tbody tr")[rowIndex]
  if (!rowElement) {
    return
  }
  updateHoverToolbarPosition(rowElement)
}

function syncHoverToolbar(selection = selectedRows.value) {
  if (selection.length !== 1 || !hasAnyHoverActions(selection[0])) {
    closeHoverToolbar()
    return
  }
  hoverToolbar.row = selection[0]
  nextTick(() => {
    if (selectedRows.value.length !== 1 || selectedRows.value[0]?.toolId !== selection[0]?.toolId) {
      return
    }
    updateHoverToolbarPositionByRow(selection[0])
    openHoverToolbar()
  })
}

function getTableRowClassName({ row }) {
  return hoverToolbar.row?.toolId === row?.toolId ? "machining-tool-row-hovered" : ""
}

function handleRowClick(row, column, event) {
  if (event?.target?.closest(".el-checkbox") || event?.target?.closest(".el-button")) {
    return
  }
  tableRef.value?.clearSelection()
  tableRef.value?.toggleRowSelection(row, true)
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "添加机加刀具信息"
}

function handleUpdate(row) {
  reset()
  const target = row?.toolId ? row : selectedRows.value[0]
  if (!canEdit(target)) {
    proxy.$modal.msgWarning("已归档物料不可直接修改；可发起修改申请，变更通过后仅变更申请人可编辑")
    return
  }
  if (canApplyChange(target)) {
    openChangeApply(target)
    return
  }
  const toolId = target.toolId
  getMachiningTool(toolId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改机加刀具信息"
  })
}

function submitForm() {
  proxy.$refs["machiningToolRef"].validate(valid => {
    if (valid) {
      if (form.value.toolId != undefined) {
        updateMachiningTool(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addMachiningTool(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功，物料已保存为草稿")
          open.value = false
          getList()
        })
      }
    }
  })
}

function handleDelete(row) {
  const rows = row.toolId ? [row] : selectedRows.value
  if (rows.some(item => !canDelete(item))) {
    proxy.$modal.msgWarning("仅物料申请人可以删除草稿状态物料，刀具管理-审核可无视状态删除")
    return
  }
  const toolIds = row.toolId || ids.value
  const hasProcessing = rows.some(item => item.approvalStatus === "processing")
  const confirmText = hasToolAuditRole && hasProcessing
    ? "所选物料包含审签中的数据，删除将同时终止对应流程实例。是否继续？"
    : '是否确认删除刀具编号为"' + toolIds + '"的数据项？'

  proxy.$modal.confirm(confirmText).then(function() {
    return delMachiningTool(toolIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

function handleForceDelete(row) {
  if (!hasForceRemovePerm) {
    return
  }
  const rows = row?.toolId ? [row] : selectedRows.value
  const toolIds = row?.toolId ? row.toolId : ids.value
  const hasProcessing = rows.some(item => item.approvalStatus === "processing")
  const warningText = hasProcessing
    ? "所选物料包含审签中的数据，强制删除将同时终止对应流程实例。是否继续？"
    : "强制删除将无视物料状态直接删除数据。是否继续？"

  proxy.$modal.confirm(warningText).then(function() {
    return forceDelMachiningTool(toolIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("强制删除成功")
  }).catch(() => {})
}

function handleExport() {
  proxy.download("tooling/machiningTool/export", {
    ...queryParams.value
  }, `machining_tool_${new Date().getTime()}.xlsx`)
}

function openApproval(row) {
  approvalMode.value = "submit"
  approvalTitle.value = "提交审批"
  approvalForm.value = {
    toolId: row.toolId,
    materialCode: row.materialCode,
    materialVersion: row.materialVersion,
    toolName: row.toolName,
    opinion: undefined
  }
  approvalOpen.value = true
  proxy.resetForm("approvalRef")
}

function openChangeApply(row) {
  approvalMode.value = "change"
  approvalTitle.value = "提交修改申请"
  approvalForm.value = {
    toolId: row.toolId,
    materialCode: row.materialCode,
    materialVersion: row.materialVersion,
    toolName: row.toolName,
    opinion: undefined
  }
  approvalOpen.value = true
  proxy.resetForm("approvalRef")
}

function submitApproval() {
  const request = approvalMode.value === "change"
    ? changeApplyMachiningTool(approvalForm.value.toolId, { opinion: approvalForm.value.opinion })
    : submitMachiningTool(approvalForm.value.toolId, { opinion: approvalForm.value.opinion })
  request.then(() => {
    proxy.$modal.msgSuccess(approvalMode.value === "change" ? "修改申请提交成功" : "提交审批成功")
    approvalOpen.value = false
    getList()
  })
}

function openVersionDialog(row) {
  versionOpen.value = true
  versionLoading.value = true
  versionList.value = []
  listMachiningToolVersions(row.toolId).then(response => {
    versionList.value = response.data || []
  }).finally(() => {
    versionLoading.value = false
  })
}

onMounted(() => {
  window.addEventListener("scroll", closeHoverToolbar, true)
  window.addEventListener("resize", closeHoverToolbar)
})

onActivated(() => {
  closeHoverToolbar()
})

onDeactivated(() => {
  closeHoverToolbar()
})

onBeforeUnmount(() => {
  clearActionPopoverTimer()
  window.removeEventListener("scroll", closeHoverToolbar, true)
  window.removeEventListener("resize", closeHoverToolbar)
})

getList()
</script>

<style scoped>
.query-toolbar {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 14px 16px;
  margin-bottom: 12px;
  overflow: hidden;
  background: linear-gradient(135deg, #f8fafc 0%, #eef6ff 100%);
  border: 1px solid #e5edf7;
  border-radius: 10px;
  box-shadow: 0 6px 18px rgba(30, 64, 175, 0.06);
}

.query-primary {
  display: flex;
  flex: 1 1 auto;
  gap: 10px;
  min-width: 0;
  overflow: hidden;
  white-space: nowrap;
}

.query-primary :deep(.el-form-item) {
  flex: 0 0 auto;
  margin-right: 0;
  margin-bottom: 0;
}

.query-input {
  width: 220px;
}

.query-actions {
  display: flex;
  flex: 0 0 auto;
  align-items: center;
  gap: 8px;
  margin-left: auto;
  white-space: nowrap;
}

.advanced-query-panel {
  padding: 2px 2px 0;
}

.advanced-query-title {
  margin-bottom: 14px;
  color: #1f2937;
  font-size: 15px;
  font-weight: 600;
}

.advanced-query-panel :deep(.el-form-item) {
  margin-right: 0;
  margin-bottom: 14px;
}

.advanced-query-panel :deep(.el-form-item:last-child) {
  margin-bottom: 0;
}

.advanced-query-panel :deep(.el-form-item__label) {
  width: 84px;
  color: #4b5563;
}

.advanced-query-control {
  width: 220px;
}

.process-status-tag {
  border-width: 1px 1px 1px 4px;
  border-style: solid;
}

.process-status-draft {
  color: #1e3a8a;
  background-color: #eff6ff;
  border-color: #93c5fd #93c5fd #93c5fd #2563eb;
}

.process-status-processing {
  color: #9a3412;
  background-color: #fff7ed;
  border-color: #fdba74 #fdba74 #fdba74 #ea580c;
}

.process-status-change-processing {
  color: #5b21b6;
  background-color: #f5f3ff;
  border-color: #c4b5fd #c4b5fd #c4b5fd #7c3aed;
}

.process-status-rejected {
  color: #9f1239;
  background-color: #fff1f2;
  border-color: #fda4af #fda4af #fda4af #e11d48;
}

.process-status-effective {
  color: #115e59;
  background-color: #ecfeff;
  border-color: #67e8f9 #67e8f9 #67e8f9 #0f766e;
}

.process-status-changing {
  color: #a16207;
  background-color: #fefce8;
  border-color: #fde68a #fde68a #fde68a #ca8a04;
}

.machining-tool-hoverbar {
  position: fixed;
  z-index: 2010;
  transform: translate(-100%, -50%);
  pointer-events: auto;
}

.machining-tool-hoverbar__shell {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 5px 6px;
  background: rgba(244, 247, 252, 0.94);
  border: 1px solid rgba(15, 23, 42, 0.1);
  border-radius: 12px;
  box-shadow: 0 16px 32px rgba(15, 23, 42, 0.1);
  backdrop-filter: blur(22px) saturate(130%);
}

.machining-tool-pill {
  height: 28px;
  margin-left: 0;
  padding: 0 11px;
  color: #0f172a;
  background: rgba(255, 255, 255, 0.62);
  border: 1px solid rgba(15, 23, 42, 0.08);
  border-radius: 999px;
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.75);
  transition: transform 0.18s ease, border-color 0.18s ease, background-color 0.18s ease, color 0.18s ease, box-shadow 0.18s ease, opacity 0.18s ease;
}

.machining-tool-pill:hover {
  color: #020617;
  background: rgba(255, 255, 255, 0.9);
  border-color: rgba(15, 23, 42, 0.12);
  box-shadow: 0 10px 20px rgba(15, 23, 42, 0.06);
  transform: translateY(-1px);
}

.machining-tool-pill--soft {
  color: #475569;
  background: rgba(255, 255, 255, 0.48);
  border-color: rgba(15, 23, 42, 0.06);
  opacity: 0.92;
}

.machining-tool-pill--soft:hover {
  color: #0f172a;
  background: rgba(255, 255, 255, 0.82);
  border-color: rgba(15, 23, 42, 0.1);
  box-shadow: 0 10px 20px rgba(15, 23, 42, 0.05);
}

.machining-tool-actions__more {
  flex: 0 0 auto;
  width: 28px;
  height: 28px;
  margin-left: 0;
  color: #475569;
  background: rgba(255, 255, 255, 0.48);
  border: 1px solid rgba(15, 23, 42, 0.06);
  border-radius: 999px;
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.72);
  transition: transform 0.18s ease, border-color 0.18s ease, background-color 0.18s ease, color 0.18s ease, box-shadow 0.18s ease;
}

.machining-tool-actions__more:hover,
.machining-tool-actions__more:focus-visible {
  color: #020617;
  background: rgba(255, 255, 255, 0.86);
  border-color: rgba(15, 23, 42, 0.1);
  box-shadow: 0 10px 20px rgba(15, 23, 42, 0.06);
  transform: translateY(-1px);
}

.machining-tool-action-menu {
  display: flex;
  flex-direction: column;
  gap: 4px;
  min-width: 124px;
}

.machining-tool-action-menu__item {
  justify-content: flex-start;
  width: 100%;
  height: 36px;
  margin-left: 0;
  padding: 0 10px;
  border-radius: 8px;
}

.machining-tool-action-menu__item:hover {
  background: rgba(15, 23, 42, 0.04);
}

:deep(.machining-tool-action-popper) {
  padding: 8px;
  background: rgba(255, 255, 255, 0.88);
  border: 1px solid rgba(15, 23, 42, 0.08);
  border-radius: 12px;
  box-shadow: 0 18px 34px rgba(15, 23, 42, 0.1);
  backdrop-filter: blur(20px) saturate(130%);
}

:deep(.el-table__body tr.machining-tool-row-hovered > td.el-table__cell) {
  background: linear-gradient(90deg, rgba(249, 250, 251, 0.96) 0%, rgba(245, 247, 250, 0.98) 100%);
}
</style>
