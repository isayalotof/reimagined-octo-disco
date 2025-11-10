# Настройка SSL сертификатов

Порт 80 остается свободным для получения SSL сертификатов через certbot.
Nginx слушает только порт 443 (HTTPS).

## Получение SSL сертификата

### 1. Установите certbot

```bash
sudo apt update
sudo apt install certbot -y
```

### 2. Получите сертификат (порт 80 должен быть свободен)

```bash
sudo certbot certonly --standalone -d max.isayalot.ru
```

Сертификаты будут сохранены в: `/etc/letsencrypt/live/max.isayalot.ru/`

### 3. Скопируйте сертификаты в папку проекта

```bash
cd ~/max
mkdir -p ssl

sudo cp /etc/letsencrypt/live/max.isayalot.ru/fullchain.pem ./ssl/cert.pem
sudo cp /etc/letsencrypt/live/max.isayalot.ru/privkey.pem ./ssl/key.pem

sudo chown $USER:$USER ./ssl/*.pem
chmod 600 ./ssl/key.pem
```

### 4. Запустите приложение

```bash
docker-compose down
docker-compose up -d --build
```

## Проверка

После запуска приложение будет доступно по HTTPS:

```bash
curl https://max.isayalot.ru
```

Или в браузере: **https://max.isayalot.ru**

## Автоматическое продление сертификата

Certbot автоматически создает cron задачу для продления. После продления нужно обновить сертификаты в проекте:

Создайте скрипт `/etc/letsencrypt/renewal-hooks/deploy/copy-certs.sh`:

```bash
sudo nano /etc/letsencrypt/renewal-hooks/deploy/copy-certs.sh
```

Добавьте:

```bash
#!/bin/bash
cp /etc/letsencrypt/live/max.isayalot.ru/fullchain.pem /home/YOUR_USER/max/ssl/cert.pem
cp /etc/letsencrypt/live/max.isayalot.ru/privkey.pem /home/YOUR_USER/max/ssl/key.pem
chown YOUR_USER:YOUR_USER /home/YOUR_USER/max/ssl/*.pem
chmod 600 /home/YOUR_USER/max/ssl/key.pem
cd /home/YOUR_USER/max && docker-compose restart nginx
```

Сделайте скрипт исполняемым:

```bash
sudo chmod +x /etc/letsencrypt/renewal-hooks/deploy/copy-certs.sh
```

## Альтернатива: использование volume для сертификатов

Можно монтировать сертификаты напрямую из Let's Encrypt:

В `docker-compose.yml`:

```yaml
volumes:
  - /etc/letsencrypt/live/max.isayalot.ru/fullchain.pem:/etc/nginx/ssl/cert.pem:ro
  - /etc/letsencrypt/live/max.isayalot.ru/privkey.pem:/etc/nginx/ssl/key.pem:ro
```

Тогда после продления просто перезапускайте nginx:
```bash
docker-compose restart nginx
```

