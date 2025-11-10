# Инструкция по развертыванию на Ubuntu сервере

## Требования

- Ubuntu 20.04+ 
- Docker и Docker Compose
- Домен max.isayalot.ru должен указывать на IP вашего сервера (A-запись в DNS)

## Установка Docker (если не установлен)

```bash
# Обновляем пакеты
sudo apt update
sudo apt upgrade -y

# Устанавливаем Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Добавляем пользователя в группу docker
sudo usermod -aG docker $USER

# Перелогиниваемся или перезагружаем сервер
exit
```

## Развертывание приложения

### 1. Загрузите файлы на сервер

```bash
# Создайте директорию
mkdir -p ~/max
cd ~/max

# Скопируйте все файлы проекта на сервер
# Можно использовать scp, git, или любой другой способ
```

### 2. Откройте порт 8080 в файрволе

```bash
# Если используете ufw
sudo ufw allow 8080/tcp
sudo ufw status
```

### 3. Запустите приложение

```bash
cd ~/max

# Соберите и запустите контейнеры
docker-compose up -d --build

# Проверьте статус
docker-compose ps

# Проверьте логи
docker-compose logs -f
```

### 4. Проверка работы

```bash
# Локально на сервере
curl http://localhost:8080

# С вашего компьютера (замените YOUR_SERVER_IP)
curl http://YOUR_SERVER_IP:8080

# По домену
curl http://max.isayalot.ru:8080
```

## Управление приложением

```bash
# Остановить
docker-compose down

# Перезапустить
docker-compose restart

# Посмотреть логи
docker-compose logs -f nginx
docker-compose logs -f app

# Пересобрать после изменений
docker-compose up -d --build
```

## Автозапуск

Контейнеры настроены с `restart: always`, поэтому они автоматически запустятся после перезагрузки сервера.

## Настройка DNS

Убедитесь, что в настройках вашего домена есть A-запись:

```
Тип: A
Имя: max
Значение: <IP вашего сервера>
TTL: 3600 (или по умолчанию)
```

После настройки DNS может потребоваться до 24 часов для распространения изменений (обычно 5-15 минут).

## Проверка DNS

```bash
# Проверьте, что домен указывает на ваш сервер
nslookup max.isayalot.ru
# или
dig max.isayalot.ru
```

## Troubleshooting

### Контейнеры не запускаются

```bash
docker-compose logs
```

### Порт занят

```bash
# Проверьте, что занимает порт 8080
sudo netstat -tulpn | grep 8080
# или
sudo lsof -i :8080
```

### Не доступно по домену

1. Проверьте DNS: `nslookup max.isayalot.ru`
2. Проверьте файрволл: `sudo ufw status`
3. Проверьте логи nginx: `docker-compose logs nginx`

## Добавление HTTPS (опционально)

Если хотите добавить HTTPS позже, можно использовать:
- Caddy (автоматически получает сертификаты)
- Certbot + Nginx
- Cloudflare (как прокси)

Но это потребует использования стандартных портов (443 для HTTPS).

