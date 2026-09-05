# CLAUDE.md — Sentra Desa Project Instructions

## Workflow Wajib Setelah Selesai Kerja

**SELALU lakukan ini setiap selesai mengerjakan task:**

1. **Commit semua perubahan ke git**
2. **Push ke GitLab** (`git push origin main`)
3. **Deploy ke VPS** (45.80.181.191, user: root, key: ~/.ssh/id_ed25519)

### Deploy Backend (Laravel)
```bash
rsync -avz --delete -e "ssh -i ~/.ssh/id_ed25519" \
  sentra-desa-backend/ \
  root@45.80.181.191:/var/www/sentradesa.id/sentra-desa-backend/ \
  --exclude='.env' --exclude='vendor/' --exclude='node_modules/' --exclude='.git/'

ssh -i ~/.ssh/id_ed25519 root@45.80.181.191 "
  cd /var/www/sentradesa.id/sentra-desa-backend &&
  COMPOSER_ALLOW_SUPERUSER=1 composer install --optimize-autoloader --no-dev --ignore-platform-reqs &&
  php8.4 artisan config:cache &&
  php8.4 artisan route:cache &&
  php8.4 artisan view:cache &&
  chown -R www-data:www-data . &&
  chmod -R 755 app/ config/ routes/ database/ resources/ storage/ bootstrap/
"
```

### Deploy Flutter Web
```bash
cd sentra_desa
flutter build web --release --pwa-strategy=none

rsync -avz --delete -e "ssh -i ~/.ssh/id_ed25519" \
  build/web/ \
  root@45.80.181.191:/var/www/html/sentradesa.id/flutter/

ssh -i ~/.ssh/id_ed25519 root@45.80.181.191 \
  "chown -R www-data:www-data /var/www/html/sentradesa.id/flutter/ && chmod -R 755 /var/www/html/sentradesa.id/flutter/"
```

## VPS Info
- IP: 45.80.181.191
- User: root
- SSH Key: ~/.ssh/id_ed25519
- Laravel path: /var/www/sentradesa.id/sentra-desa-backend/  ← PATH NGINX AKTIF
- Flutter path: /var/www/html/sentradesa.id/flutter/
- Domain: https://sentradesa.id

## GitLab
- Remote: https://gitlab.com/pilar-cipta-solusi-integratika/sentra-desa.git
- Branch utama: main
- Auth: pakai Personal Access Token (user perlu sediakan token)

## Tech Stack
- Backend: Laravel 12, PHP 8.2 (VPS), Filament v3, Spatie Permission, FilamentShield
- Frontend: Flutter Web 3.10+
- DB: MySQL 8.0
- Server: Nginx, PHP-FPM

## Catatan Penting
- PHP CLI default adalah 8.2 tapi **nginx/FPM menggunakan PHP 8.4** (port 19000) → SELALU pakai `php8.4 artisan` untuk cache commands, bukan `php artisan`
- Selalu pakai `--ignore-platform-reqs` untuk composer (biar kompatibel)
- Flutter TIDAK terinstall di VPS → build lokal dulu, upload build/web/
- Service worker Flutter: pakai `--pwa-strategy=none` agar browser selalu ambil fresh content
- Setelah upload file PHP baru via scp/rsync → pastikan: `chmod 755` untuk dir, `chmod 644` untuk file
- Permission cache Spatie: sudah diset ke 'file' (bukan Redis)
- Shield superadmin: role name = 'superadmin', define_via_gate = true
