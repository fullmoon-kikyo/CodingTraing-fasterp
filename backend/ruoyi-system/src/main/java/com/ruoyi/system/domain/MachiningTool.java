package com.ruoyi.system.domain;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.annotation.Excel.ColumnType;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 机加刀具信息 tool_machining_tool
 *
 * @author lemon
 */
public class MachiningTool extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 刀具ID */
    @Excel(name = "刀具ID", cellType = ColumnType.NUMERIC)
    private Long toolId;

    /** 刀具物料编码 */
    @Excel(name = "刀具物料编码")
    private String materialCode;

    /** 刀具名称 */
    @Excel(name = "刀具名称")
    private String toolName;

    /** 刀具牌号 */
    @Excel(name = "刀具牌号")
    private String toolBrand;

    /** 刀具规格 */
    @Excel(name = "刀具规格")
    private String toolSpec;

    /** 刀具型号 */
    @Excel(name = "刀具型号")
    private String toolModel;

    /** 刀具类别 */
    @Excel(name = "刀具类别")
    private String toolCategory;

    /** 生产厂家 */
    @Excel(name = "生产厂家")
    private String manufacturer;

    /** 状态（0正常 1停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /** 物料版本 */
    @Excel(name = "版本")
    private String materialVersion;

    /** 物料状态 */
    @Excel(name = "物料状态", readConverterExp = "draft=草稿,processing=审签中,effective=生效")
    private String materialStatus;

    /** 流程状态 */
    @Excel(name = "流程状态", readConverterExp = "draft=待提交,processing=审批流,effective=审签完成,rejected=驳回,change_processing=变更审批中,changing=变更中,change_rejected=变更驳回")
    private String approvalStatus;

    /** 变更申请人 */
    private String changeApplyBy;

    /** 流程实例ID */
    private String processInstanceId;

    /** 流程定义Key */
    private String processDefinitionKey;

    public Long getToolId()
    {
        return toolId;
    }

    public void setToolId(Long toolId)
    {
        this.toolId = toolId;
    }

    @NotBlank(message = "刀具物料编码不能为空")
    @Size(min = 0, max = 64, message = "刀具物料编码长度不能超过64个字符")
    public String getMaterialCode()
    {
        return materialCode;
    }

    public void setMaterialCode(String materialCode)
    {
        this.materialCode = materialCode;
    }

    @NotBlank(message = "刀具名称不能为空")
    @Size(min = 0, max = 100, message = "刀具名称长度不能超过100个字符")
    public String getToolName()
    {
        return toolName;
    }

    public void setToolName(String toolName)
    {
        this.toolName = toolName;
    }

    @Size(min = 0, max = 100, message = "刀具牌号长度不能超过100个字符")
    public String getToolBrand()
    {
        return toolBrand;
    }

    public void setToolBrand(String toolBrand)
    {
        this.toolBrand = toolBrand;
    }

    @Size(min = 0, max = 100, message = "刀具规格长度不能超过100个字符")
    public String getToolSpec()
    {
        return toolSpec;
    }

    public void setToolSpec(String toolSpec)
    {
        this.toolSpec = toolSpec;
    }

    @Size(min = 0, max = 100, message = "刀具型号长度不能超过100个字符")
    public String getToolModel()
    {
        return toolModel;
    }

    public void setToolModel(String toolModel)
    {
        this.toolModel = toolModel;
    }

    @Size(min = 0, max = 100, message = "刀具类别长度不能超过100个字符")
    public String getToolCategory()
    {
        return toolCategory;
    }

    public void setToolCategory(String toolCategory)
    {
        this.toolCategory = toolCategory;
    }

    @Size(min = 0, max = 100, message = "生产厂家长度不能超过100个字符")
    public String getManufacturer()
    {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer)
    {
        this.manufacturer = manufacturer;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getMaterialVersion()
    {
        return materialVersion;
    }

    public void setMaterialVersion(String materialVersion)
    {
        this.materialVersion = materialVersion;
    }

    public String getMaterialStatus()
    {
        return materialStatus;
    }

    public void setMaterialStatus(String materialStatus)
    {
        this.materialStatus = materialStatus;
    }

    public String getApprovalStatus()
    {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus)
    {
        this.approvalStatus = approvalStatus;
    }

    public String getChangeApplyBy()
    {
        return changeApplyBy;
    }

    public void setChangeApplyBy(String changeApplyBy)
    {
        this.changeApplyBy = changeApplyBy;
    }

    public String getProcessInstanceId()
    {
        return processInstanceId;
    }

    public void setProcessInstanceId(String processInstanceId)
    {
        this.processInstanceId = processInstanceId;
    }

    public String getProcessDefinitionKey()
    {
        return processDefinitionKey;
    }

    public void setProcessDefinitionKey(String processDefinitionKey)
    {
        this.processDefinitionKey = processDefinitionKey;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("toolId", getToolId())
            .append("materialCode", getMaterialCode())
            .append("toolName", getToolName())
            .append("toolBrand", getToolBrand())
            .append("toolSpec", getToolSpec())
            .append("toolModel", getToolModel())
            .append("toolCategory", getToolCategory())
            .append("manufacturer", getManufacturer())
            .append("status", getStatus())
            .append("materialVersion", getMaterialVersion())
            .append("materialStatus", getMaterialStatus())
            .append("approvalStatus", getApprovalStatus())
            .append("changeApplyBy", getChangeApplyBy())
            .append("processInstanceId", getProcessInstanceId())
            .append("processDefinitionKey", getProcessDefinitionKey())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
