# RuoYi-Vue3 分离版项目构思

## 1. 项目定位

本项目用于在 WSL 环境中搭建一套基于 RuoYi-Vue 后端 master 分支与 RuoYi-Vue3 前端的前后端分离开发环境，作为后续二次开发、业务模块扩展、权限管理和后台系统定制的基础工程。

当前项目不是直接使用 Windows 本地目录开发，而是运行在 WSL 内部目录：

```text
/home/lemon/test-project
```

## 2. 技术选型

后端：

- RuoYi-Vue master 分支
- Spring Boot 4.x
- JDK 17+，当前项目内置 JDK 21
- Maven 3.9.11
- Spring Security
- JWT
- MyBatis
- Druid
- Quartz

前端：

- RuoYi-Vue3 master 分支
- Vue 3
- Vite
- Element Plus
- Pinia
- Vue Router 4

基础设施：

- MySQL 8.0
- Redis 7
- Docker Compose
- Nginx 示例配置

## 3. 目录规划

```text
test-project/
├── backend/              # RuoYi-Vue 后端源码
├── frontend/             # RuoYi-Vue3 前端源码
├── infra/                # Docker Compose 和 Nginx 配置
├── scripts/              # 本地构建、启动、停止脚本
├── docs/                 # 项目文档
├── logs/                 # 本地运行日志
├── uploads/              # 后端上传文件目录
├── .tools/               # 项目内置 JDK / Maven
└── README.md             # 本地部署与运行说明
```

## 4. 当前部署状态

当前已经完成：

- 后端代码拉取并切在 `master` 分支
- 前端代码拉取并切在 `master` 分支
- MySQL / Redis 使用 Docker Compose 启动
- 数据库 `ry-vue` 初始化完成
- 后端数据库、Redis、日志目录、上传目录已配置为 WSL 本地路径
- 后端 jar 构建成功
- 前端依赖安装完成
- 前端开发服务启动成功
- 前端生产包 `dist/` 构建成功
- 前端代理到后端接口验证成功

当前访问地址：

```text
前端开发地址: http://localhost:5173
后端接口地址: http://localhost:8080
```

默认账号：

```text
admin / admin123
```

## 5. 本地开发流程

一键启动完整开发环境：

```bash
./scripts/start-dev.sh
```

查看运行状态：

```bash
./scripts/status-dev.sh
```

一键停止完整开发环境：

```bash
./scripts/stop-dev.sh
```

需要单独操作时，也可以分别启动基础服务、后端和前端：

```bash
docker compose -f infra/docker-compose.yml up -d
./scripts/start-backend.sh
./scripts/start-frontend.sh
```

访问系统：

```text
http://localhost:5173
```

停止服务：

```bash
./scripts/stop-frontend.sh
./scripts/stop-backend.sh
docker compose -f infra/docker-compose.yml down
```

## 6. 生产构建思路

后端构建产物：

```text
backend/ruoyi-admin/target/ruoyi-admin.jar
```

前端构建产物：

```text
frontend/dist/
```

生产部署可以采用以下方式：

```text
Nginx 托管 frontend/dist
Nginx 将 /prod-api/ 代理到后端 http://127.0.0.1:8080/
后端 jar 使用 Java 进程、systemd 或容器方式运行
MySQL / Redis 可继续使用 Docker，也可切换为独立数据库服务
```

当前已提供 Nginx 示例：

```text
infra/nginx.conf
```

## 7. 后续开发方向

第一阶段：稳定开发环境

- 固化本地启动命令，已提供 `start-dev.sh`、`stop-dev.sh`、`status-dev.sh`
- 补充环境变量说明
- 确认登录、菜单、权限、验证码、用户管理等基础功能正常
- 建立数据库备份和重置流程

第二阶段：业务模块扩展

- 明确具体业务对象和数据模型
- 使用 RuoYi 代码生成能力生成基础 CRUD
- 调整菜单、角色、按钮权限
- 完成前端页面、表单、列表、导入导出等功能

第三阶段：工程化增强

- 增加开发、测试、生产环境配置区分
- 增加后端接口测试或关键业务测试
- 增加前端构建检查
- 完善日志、异常处理、接口文档和部署文档

第四阶段：上线准备

- 梳理生产数据库账号和密码
- 修改 JWT 密钥、默认密码和公开配置
- 配置 Nginx、HTTPS、Gzip 和静态缓存
- 配置后端进程守护
- 准备备份、回滚和升级方案

## 8. 风险与注意事项

Node 版本：

当前 WSL 中 Node 为 v24.14.1。前端目前可以安装依赖并构建成功，但如果后续遇到依赖兼容问题，建议切换到 Node 20 LTS。

Maven 代理：

当前 Maven 使用项目内配置：

```text
backend/.mvn/settings.xml
```

里面配置了本地代理：

```text
127.0.0.1:7897
```

如果代理端口变化，需要同步修改该文件。

数据库初始化：

MySQL 首次创建容器时会自动导入 `backend/sql/` 下的 SQL。如果数据库卷已经存在，后续重启不会重复导入。需要重置数据库时，应先确认数据可丢弃，再删除 Docker volume。

日志目录：

后端日志已经从默认 `/home/ruoyi/logs` 改为：

```text
/home/lemon/test-project/logs/ruoyi
```

上传目录：

后端上传目录已经改为：

```text
/home/lemon/test-project/uploads
```

## 9. 项目目标总结

本项目的目标是先把 RuoYi-Vue3 分离版稳定跑起来，再在此基础上逐步进行业务开发。当前已经完成基础部署、构建和运行验证，后续可以直接围绕业务模块、权限模型、页面定制和生产部署继续推进。
