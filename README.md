# RuoYi-Vue3 Local Deployment

This project runs the RuoYi separated stack in WSL:

- `backend/`: RuoYi-Vue `master`, Spring Boot 4.x
- `frontend/`: RuoYi-Vue3 `master`, Vue 3 + Vite
- `infra/`: MySQL, Redis, and Nginx examples
- `.tools/`: local JDK and Maven, ignored by Git

## Docs

- `docs/PROJECT_CONCEPT.md`: project positioning and development roadmap
- `docs/环境变量说明.md`: local configuration and environment notes
- `docs/基础功能验证记录.md`: login, menu, permission, captcha, and user management verification
- `docs/迭代编码规则.md`: coding rules for future feature iterations

## Services

Start the full development environment:

```bash
./scripts/start-dev.sh
```

Check status:

```bash
./scripts/status-dev.sh
```

Stop the full development environment:

```bash
./scripts/stop-dev.sh
```

Start MySQL and Redis:

```bash
docker compose -f infra/docker-compose.yml up -d
```

Stop them:

```bash
docker compose -f infra/docker-compose.yml down
```

The first MySQL startup imports:

- `backend/sql/quartz.sql`
- `backend/sql/ry_20260417.sql`

Database settings:

- database: `ry-vue`
- user: `ruoyi`
- password: `ruoyi123456`
- MySQL port: `3306`
- Redis port: `6379`

## Backend

Build:

```bash
./scripts/build-backend.sh
```

Start:

```bash
./scripts/start-backend.sh
```

Stop:

```bash
./scripts/stop-backend.sh
```

Backend URL:

```text
http://localhost:8080
```

Logs:

```text
logs/backend-console.log
logs/ruoyi/
```

## Frontend

Install dependencies:

```bash
cd frontend
npm install --registry=https://registry.npmmirror.com
```

Start:

```bash
./scripts/start-frontend.sh
```

Stop:

```bash
./scripts/stop-frontend.sh
```

Frontend URL:

```text
http://localhost:5173
```

Build:

```bash
./scripts/build-frontend.sh
```

Production files are generated in:

```text
frontend/dist/
```

## Login

Default account:

```text
admin / admin123
```

## Notes

The Maven project uses `backend/.mvn/settings.xml` for the local proxy at `127.0.0.1:7897`, matching this WSL environment. If your proxy port changes, update that file or run Maven with another settings file.
