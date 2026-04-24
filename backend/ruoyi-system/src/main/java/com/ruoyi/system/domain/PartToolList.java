package com.ruoyi.system.domain;

import java.math.BigDecimal;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.annotation.Excel.ColumnType;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 零件刀具清单 tool_part_tool_list
 *
 * @author lemon
 */
public class PartToolList extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 清单ID */
    @Excel(name = "清单ID", cellType = ColumnType.NUMERIC)
    private Long listId;

    /** 零件号 */
    @Excel(name = "零件号")
    private String partNo;

    /** 零件名称 */
    @Excel(name = "零件名称")
    private String partName;

    /** 生产机组 */
    @Excel(name = "生产机组")
    private String productionUnit;

    /** 工序号 */
    @Excel(name = "工序号")
    private String processNo;

    /** 工序名称 */
    @Excel(name = "工序名称")
    private String processName;

    /** 引用刀具ID */
    private Long toolId;

    /** 刀具物料编码快照 */
    @Excel(name = "刀具物料编码")
    private String materialCode;

    /** 刀具名称快照 */
    @Excel(name = "刀具名称")
    private String toolName;

    /** 刀具牌号快照 */
    @Excel(name = "刀具牌号")
    private String toolBrand;

    /** 刀具规格快照 */
    @Excel(name = "刀具规格")
    private String toolSpec;

    /** 刀具型号快照 */
    @Excel(name = "刀具型号")
    private String toolModel;

    /** 刀具类别快照 */
    @Excel(name = "刀具类别")
    private String toolCategory;

    /** 生产厂家快照 */
    @Excel(name = "生产厂家")
    private String manufacturer;

    /** 刀具寿命 */
    @Excel(name = "刀具寿命")
    private BigDecimal toolLife;

    /** 寿命单位 */
    @Excel(name = "寿命单位")
    private String toolLifeUnit;

    /** 状态（0正常 1停用） */
    private String status;

    /** 流程状态 */
    @Excel(name = "流程状态", readConverterExp = "draft=待提交,processing=审批流,effective=审签完成,rejected=驳回")
    private String approvalStatus;

    /** 流程实例ID */
    private String processInstanceId;

    /** 流程定义Key */
    private String processDefinitionKey;

    /** 展示状态 */
    @Excel(name = "状态")
    private String displayStatus;

    /** 刀具数据库信息是否变化（1是 0否） */
    private Integer toolInfoChanged;

    public Long getListId()
    {
        return listId;
    }

    public void setListId(Long listId)
    {
        this.listId = listId;
    }

    @NotBlank(message = "零件号不能为空")
    @Size(min = 0, max = 64, message = "零件号长度不能超过64个字符")
    public String getPartNo()
    {
        return partNo;
    }

    public void setPartNo(String partNo)
    {
        this.partNo = partNo;
    }

    @NotBlank(message = "零件名称不能为空")
    @Size(min = 0, max = 100, message = "零件名称长度不能超过100个字符")
    public String getPartName()
    {
        return partName;
    }

    public void setPartName(String partName)
    {
        this.partName = partName;
    }

    @Size(min = 0, max = 100, message = "生产机组长度不能超过100个字符")
    public String getProductionUnit()
    {
        return productionUnit;
    }

    public void setProductionUnit(String productionUnit)
    {
        this.productionUnit = productionUnit;
    }

    @Size(min = 0, max = 64, message = "工序号长度不能超过64个字符")
    public String getProcessNo()
    {
        return processNo;
    }

    public void setProcessNo(String processNo)
    {
        this.processNo = processNo;
    }

    @Size(min = 0, max = 100, message = "工序名称长度不能超过100个字符")
    public String getProcessName()
    {
        return processName;
    }

    public void setProcessName(String processName)
    {
        this.processName = processName;
    }

    @NotNull(message = "引用刀具不能为空")
    public Long getToolId()
    {
        return toolId;
    }

    public void setToolId(Long toolId)
    {
        this.toolId = toolId;
    }

    public String getMaterialCode()
    {
        return materialCode;
    }

    public void setMaterialCode(String materialCode)
    {
        this.materialCode = materialCode;
    }

    public String getToolName()
    {
        return toolName;
    }

    public void setToolName(String toolName)
    {
        this.toolName = toolName;
    }

    public String getToolBrand()
    {
        return toolBrand;
    }

    public void setToolBrand(String toolBrand)
    {
        this.toolBrand = toolBrand;
    }

    public String getToolSpec()
    {
        return toolSpec;
    }

    public void setToolSpec(String toolSpec)
    {
        this.toolSpec = toolSpec;
    }

    public String getToolModel()
    {
        return toolModel;
    }

    public void setToolModel(String toolModel)
    {
        this.toolModel = toolModel;
    }

    public String getToolCategory()
    {
        return toolCategory;
    }

    public void setToolCategory(String toolCategory)
    {
        this.toolCategory = toolCategory;
    }

    public String getManufacturer()
    {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer)
    {
        this.manufacturer = manufacturer;
    }

    public BigDecimal getToolLife()
    {
        return toolLife;
    }

    public void setToolLife(BigDecimal toolLife)
    {
        this.toolLife = toolLife;
    }

    public String getToolLifeUnit()
    {
        return toolLifeUnit;
    }

    public void setToolLifeUnit(String toolLifeUnit)
    {
        this.toolLifeUnit = toolLifeUnit;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getApprovalStatus()
    {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus)
    {
        this.approvalStatus = approvalStatus;
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

    public String getDisplayStatus()
    {
        return displayStatus;
    }

    public void setDisplayStatus(String displayStatus)
    {
        this.displayStatus = displayStatus;
    }

    public Integer getToolInfoChanged()
    {
        return toolInfoChanged;
    }

    public void setToolInfoChanged(Integer toolInfoChanged)
    {
        this.toolInfoChanged = toolInfoChanged;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("listId", getListId())
            .append("partNo", getPartNo())
            .append("partName", getPartName())
            .append("productionUnit", getProductionUnit())
            .append("processNo", getProcessNo())
            .append("processName", getProcessName())
            .append("toolId", getToolId())
            .append("materialCode", getMaterialCode())
            .append("toolName", getToolName())
            .append("toolBrand", getToolBrand())
            .append("toolSpec", getToolSpec())
            .append("toolModel", getToolModel())
            .append("toolCategory", getToolCategory())
            .append("manufacturer", getManufacturer())
            .append("toolLife", getToolLife())
            .append("toolLifeUnit", getToolLifeUnit())
            .append("status", getStatus())
            .append("approvalStatus", getApprovalStatus())
            .append("processInstanceId", getProcessInstanceId())
            .append("processDefinitionKey", getProcessDefinitionKey())
            .append("displayStatus", getDisplayStatus())
            .append("toolInfoChanged", getToolInfoChanged())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
