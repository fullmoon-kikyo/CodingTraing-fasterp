package com.ruoyi.system.domain;

import java.util.Date;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.annotation.Excel.ColumnType;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 机加刀具历史版本快照 tool_machining_tool_version
 */
public class MachiningToolVersion extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 快照ID */
    @Excel(name = "快照ID", cellType = ColumnType.NUMERIC)
    private Long versionId;

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

    /** 流程实例ID */
    private String processInstanceId;

    /** 流程定义Key */
    private String processDefinitionKey;

    /** 快照创建人 */
    private String snapshotBy;

    /** 快照创建时间 */
    private Date snapshotTime;

    public Long getVersionId()
    {
        return versionId;
    }

    public void setVersionId(Long versionId)
    {
        this.versionId = versionId;
    }

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

    public String getSnapshotBy()
    {
        return snapshotBy;
    }

    public void setSnapshotBy(String snapshotBy)
    {
        this.snapshotBy = snapshotBy;
    }

    public Date getSnapshotTime()
    {
        return snapshotTime;
    }

    public void setSnapshotTime(Date snapshotTime)
    {
        this.snapshotTime = snapshotTime;
    }
}
