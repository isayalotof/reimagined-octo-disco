# FastAPI + Nginx Application

Простое приложение с FastAPI и Nginx в Docker.

## Структура проекта

- `app/main.py` - FastAPI приложение с hello world
- `nginx/nginx.conf` - конфигурация Nginx
- `Dockerfile.app` - Dockerfile для FastAPI приложения
- `Dockerfile.nginx` - Dockerfile для Nginx
- `docker-compose.yml` - сборка и запуск всех сервисов

## Запуск

```bash
docker-compose up --build
```

Приложение будет доступно на порту 8080 (не 80).

Nginx перенаправляет весь трафик с домена `max.isayalot.ru` на FastAPI приложение.

## Проверка

После запуска откройте в браузере:
- http://localhost:8080

Или используйте curl:
```bash
curl http://localhost:8080
```

