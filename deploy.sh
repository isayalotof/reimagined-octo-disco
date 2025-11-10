#!/bin/bash

# Скрипт для развертывания приложения на Ubuntu сервере

set -e

echo "🚀 Развертывание приложения max.isayalot.ru"
echo "============================================"

# Проверяем Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не установлен!"
    echo "Установите Docker командой:"
    echo "curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh"
    exit 1
fi

# Проверяем Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose не установлен!"
    echo "Установите Docker Compose"
    exit 1
fi

echo "✅ Docker установлен"

# Останавливаем старые контейнеры
echo "🛑 Останавливаем старые контейнеры..."
docker-compose down 2>/dev/null || true

# Собираем и запускаем
echo "🔨 Собираем приложение..."
docker-compose build

echo "🚀 Запускаем контейнеры..."
docker-compose up -d

# Ждем запуска
echo "⏳ Ожидание запуска приложения..."
sleep 5

# Проверяем статус
echo ""
echo "📊 Статус контейнеров:"
docker-compose ps

echo ""
echo "✅ Развертывание завершено!"
echo ""
echo "Проверьте работу приложения:"
echo "  curl http://localhost:8080"
echo ""
echo "Логи:"
echo "  docker-compose logs -f"
echo ""
echo "Приложение доступно на:"
echo "  - http://localhost:8080"
echo "  - http://max.isayalot.ru:8080 (если DNS настроен)"

