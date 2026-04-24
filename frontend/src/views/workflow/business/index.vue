<template>
  <div class="app-container">
    <el-table :data="bindingList">
      <el-table-column label="业务类型" align="center" prop="businessType" width="180" />
      <el-table-column label="业务名称" align="center" prop="businessName" width="180" />
      <el-table-column label="流程定义Key" align="center" prop="processDefinitionKey" min-width="220" />
      <el-table-column label="说明" align="left" prop="remark" min-width="260" :show-overflow-tooltip="true" />
    </el-table>
  </div>
</template>

<script setup name="WorkflowBusiness">
const bindingList = ref([
  {
    businessType: "machining_tool",
    businessName: "机加刀具信息",
    processDefinitionKey: "machining_tool_approval",
    remark: "第一版内置绑定，后续可扩展为可配置业务流程绑定表。"
  }
])
</script>
