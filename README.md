# FastAPI + Nginx Application

Простое приложение с FastAPI и Nginx в Docker.

## Структура проекта

```
max/
├── app/
│   └── main.py              # FastAPI приложение с hello world
├── nginx/
│   └── nginx.conf           # Конфигурация Nginx
├── Dockerfile.app           # Dockerfile для FastAPI
├── Dockerfile.nginx         # Dockerfile для Nginx
├── docker-compose.yml       # Docker Compose конфигурация
├── requirements.txt         # Python зависимости
├── .dockerignore           # Исключения для Docker
├── README.md               # Этот файл
└── DEPLOY.md               # Инструкции по развертыванию на сервере
```

## Быстрый старт (локально)

```bash
docker-compose up -d --build
```

Приложение будет доступно:
- http://localhost:8080
- http://127.0.0.1:8080

## Развертывание на сервере

**См. подробные инструкции в [DEPLOY.md](DEPLOY.md)**

Кратко:
1. Установите Docker на Ubuntu сервер
2. Скопируйте файлы проекта
3. Настройте DNS для домена max.isayalot.ru
4. Откройте порт 8080
5. Запустите: `docker-compose up -d --build`

## Особенности

- **Nginx слушает порт 8080** (не 80, как требовалось)
- Nginx проксирует все запросы на FastAPI приложение
- Контейнеры автоматически перезапускаются при падении
- Работает с доменом max.isayalot.ru и localhost

## Управление

```bash
# Запустить
docker-compose up -d

# Остановить
docker-compose down

# Перезапустить
docker-compose restart

# Логи
docker-compose logs -f

# Пересобрать
docker-compose up -d --build
```

## Проверка работы

```bash
curl http://localhost:8080
# Ответ: {"message":"Hello World"}
```

## API

- `GET /` - возвращает `{"message": "Hello World"}`

