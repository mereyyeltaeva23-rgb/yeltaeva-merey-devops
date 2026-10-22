# yeltaeva-merey-devops

Personal DevOps laboratory project of **Merey Yeltaeva** (group IT2-2301, ID 37603).

Workflow: **Linux → Git → GitHub → Docker → Jenkins**

## Project structure

```
yeltaeva_merey/
├── app/                      # Python web application (shows student info)
├── scripts/                  # Bash scripts
├── config/                   # Application configuration
├── logs/                     # Application logs (ignored by git)
├── backup/                   # Backups (ignored by git)
├── Yeltaeva_Merey_info.txt     # Student information
├── Dockerfile
├── docker-compose.yml
└── Jenkinsfile
```

## How to run

```bash
# Linux script
./scripts/Yeltaeva_Merey_system.sh

# Docker
docker build -t yeltaeva-merey-devops .
docker run -d -p 5000:5000 --name yeltaeva-merey-container yeltaeva-merey-devops
# open http://localhost:5000

# Docker Compose
docker compose up -d
docker compose down
```

## Naming

| Element | Name |
|---|---|
| Linux directory | `yeltaeva_merey` |
| Bash script | `Yeltaeva_Merey_system.sh` |
| GitHub repository / Docker image | `yeltaeva-merey-devops` |
| Docker container | `yeltaeva-merey-container` |
| Jenkins job | `Yeltaeva_Merey_DevOps` |
