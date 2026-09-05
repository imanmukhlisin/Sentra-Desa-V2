#!/bin/bash
# Script untuk deploy perubahan logging dan debug error 500

echo "=== DEPLOY LOGGING CHANGES ==="

# 1. Upload Nginx config baru
echo "[1/4] Upload Nginx config..."
scp -i ~/.ssh/id_ed25519 sentradesa.id.conf root@45.80.181.191:/etc/nginx/sites-available/sentradesa.id.conf

# 2. Upload middleware debug
echo "[2/4] Upload DebugRequestMiddleware..."
scp -i ~/.ssh/id_ed25519 \
  sentra-desa-backend/app/Http/Middleware/DebugRequestMiddleware.php \
  root@45.80.181.191:/var/www/sentradesa.id/sentra-desa-backend/app/Http/Middleware/

# 3. Upload bootstrap/app.php dan AdminPanelProvider yang sudah dimodifikasi
echo "[3/4] Upload bootstrap/app.php dan AdminPanelProvider..."
scp -i ~/.ssh/id_ed25519 \
  sentra-desa-backend/bootstrap/app.php \
  root@45.80.181.191:/var/www/sentradesa.id/sentra-desa-backend/bootstrap/app.php

scp -i ~/.ssh/id_ed25519 \
  sentra-desa-backend/app/Providers/Filament/AdminPanelProvider.php \
  root@45.80.181.191:/var/www/sentradesa.id/sentra-desa-backend/app/Providers/Filament/AdminPanelProvider.php

# 4. Reload Nginx dan clear Laravel cache
echo "[4/4] Reload services..."
ssh -i ~/.ssh/id_ed25519 root@45.80.181.191 "
  # Set permission yang benar
  chown www-data:www-data /var/www/sentradesa.id/sentra-desa-backend/app/Http/Middleware/DebugRequestMiddleware.php
  chown www-data:www-data /var/www/sentradesa.id/sentra-desa-backend/bootstrap/app.php
  chown www-data:www-data /var/www/sentradesa.id/sentra-desa-backend/app/Providers/Filament/AdminPanelProvider.php
  
  # Clear Laravel cache
  cd /var/www/sentradesa.id/sentra-desa-backend &&
  php artisan config:clear &&
  php artisan route:clear &&
  php artisan view:clear &&
  php artisan cache:clear
  
  # Test dan reload Nginx
  nginx -t && nginx -s reload
  
  echo '=== DONE ==='
"

echo ""
echo "=== CARA CEK LOG SETELAH DEPLOY ==="
echo ""
echo "1. Cek Nginx error log (utama):"
echo "   ssh -i ~/.ssh/id_ed25519 root@45.80.181.191 'tail -100 /var/log/nginx/sentradesa-error.log'"
echo ""
echo "2. Cek Nginx Laravel location log:"
echo "   ssh -i ~/.ssh/id_ed25519 root@45.80.181.191 'tail -100 /var/log/nginx/sentradesa-laravel.log'"
echo ""
echo "3. Cek Nginx FastCGI error log:"
echo "   ssh -i ~/.ssh/id_ed25519 root@45.80.181.191 'tail -100 /var/log/nginx/sentradesa-fastcgi-error.log'"
echo ""
echo "4. Cek Laravel log:"
echo "   ssh -i ~/.ssh/id_ed25519 root@45.80.181.191 'tail -100 /var/www/sentradesa.id/sentra-desa-backend/storage/logs/laravel.log'"
echo ""
echo "5. Live tail semua log saat akses /admin/login:"
echo "   ssh -i ~/.ssh/id_ed25519 root@45.80.181.191 'tail -f /var/log/nginx/sentradesa-error.log /var/log/nginx/sentradesa-laravel-error.log /var/www/sentradesa.id/sentra-desa-backend/storage/logs/laravel.log'"
echo ""
echo "6. Cek apakah PHP-FPM running:"
echo "   ssh -i ~/.ssh/id_ed25519 root@45.80.181.191 'systemctl status php8.2-fpm && ss -tlnp | grep 19000'"
echo ""
echo "7. Cek routes Filament yang terdaftar:"
echo "   ssh -i ~/.ssh/id_ed25519 root@45.80.181.191 'cd /var/www/sentradesa.id/sentra-desa-backend && php artisan route:list | grep admin'"
