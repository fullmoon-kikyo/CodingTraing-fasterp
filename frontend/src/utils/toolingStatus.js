export const TOOL_USAGE_STATUS_OPTIONS = [
  { label: "生效", value: "0", elTagType: "success", elTagClass: "" },
  { label: "失效", value: "1", elTagType: "danger", elTagClass: "" }
]

export const TOOL_MATERIAL_STATUS_OPTIONS = [
  { label: "草稿", value: "draft" },
  { label: "审签中", value: "processing" },
  { label: "已归档", value: "effective" }
]

export function getToolUsageStatusLabel(status, options = TOOL_USAGE_STATUS_OPTIONS) {
  return options.find(item => item.value === status)?.label || "未知"
}

export function getToolUsageStatusTagType(status, options = TOOL_USAGE_STATUS_OPTIONS) {
  return options.find(item => item.value === status)?.elTagType || "info"
}

export function getToolMaterialStatusLabel(status) {
  return TOOL_MATERIAL_STATUS_OPTIONS.find(item => item.value === status)?.label || "未知"
}
