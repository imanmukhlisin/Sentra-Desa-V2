# SENTRA DESA

> Platform Transformasi Digital Desa — Integrasi UMKM, Potensi Desa, Desa Wisata & Layanan Desa dalam Satu Ekosistem.

![Laravel](https://img.shields.io/badge/Laravel-12-FF2D20?style=for-the-badge&logo=laravel&logoColor=white)
![Next.js](https://img.shields.io/badge/Next.js-14.2-000000?style=for-the-badge&logo=nextdotjs&logoColor=white)
![React](https://img.shields.io/badge/React-18-61DAFB?style=for-the-badge&logo=react&logoColor=black)
![TypeScript](https://img.shields.io/badge/TypeScript-5.8-3178C6?style=for-the-badge&logo=typescript&logoColor=white)
![TailwindCSS](https://img.shields.io/badge/TailwindCSS-3.4-06B6D4?style=for-the-badge&logo=tailwindcss&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-8.2%2F8.4-777BB4?style=for-the-badge&logo=php&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Filament](https://img.shields.io/badge/Filament-3.3-FDAE4B?style=for-the-badge&logo=laravel&logoColor=white)

---

## Daftar Isi

- [Tentang Proyek](#tentang-proyek)
- [Arsitektur](#arsitektur)
- [Modul Utama](#modul-utama)
- [Tech Stack](#tech-stack)
- [Struktur Folder](#struktur-folder)
- [Prasyarat](#prasyarat)
- [Instalasi & Setup](#instalasi--setup)
  - [Backend (Laravel)](#backend-laravel)
  - [Frontend (Next.js)](#frontend-nextjs)
- [Deployment (Production)](#deployment-production)
- [Role & Permission (RBAC)](#role--permission-rbac)
- [API Endpoints](#api-endpoints)
- [Screenshot](#screenshot)
- [Kontribusi](#kontribusi)
- [Lisensi](#lisensi)

---

## Tentang Proyek

**SENTRA DESA** adalah platform digital yang bertujuan untuk:

- **Mengintegrasikan desa** ke dalam ekosistem digital nasional
- **Mempromosikan produk UMKM** desa ke pasar yang lebih luas
- **Memetakan potensi desa** (pertanian, kerajinan, wisata, dll.)
- **Menyediakan monitoring hierarkis** dari tingkat pusat hingga desa
- **Mendukung BUMDES** dan koperasi desa dalam pengelolaan usaha

Platform ini menggunakan pendekatan **multi-role hierarchy**:

```
Superadmin (Pusat/Kementerian)
  └── PEMDA (Provinsi / Kabupaten)
        └── Desa (Admin Desa)
              └── UMKM (Merchant)
                    └── Buyer (Publik)
```

---

## Arsitektur

```
┌─────────────────────────────────────────────────────┐
│                    NGINX (Reverse Proxy + SSL)       │
│                    sentradesa.id                     │
├──────────────┬──────────────┬───────────────────────┤
│  /           │  /admin      │  /api                 │
│  Next.js     │  Filament    │  Laravel API          │
│  (SSG Export)│  Admin Panel │  (REST + Sanctum)     │
├──────────────┴──────────────┴───────────────────────┤
│              Laravel 12 + PHP 8.2/8.4 FPM           │
├─────────────────────────────────────────────────────┤
│              MySQL 8.0 Database                     │
│              (Geospatial Hierarchy)                  │
└─────────────────────────────────────────────────────┘
```

| URL Path | Service | Keterangan |
|----------|---------|------------|
| `/` | Next.js (SSG Export) | Landing page & marketplace publik desa |
| `/admin` | Filament 3.3 | Dashboard admin & manajemen data (RBAC) |
| `/api/v1/*` | Laravel REST API | Backend API untuk Next.js Frontend |

---

## Modul Utama

| No | Modul | Deskripsi |
|----|-------|-----------|
| 1 | **Sentra Produk** | Marketplace produk UMKM desa |
| 2 | **Desa Wisata** | Katalog destinasi wisata desa |
| 3 | **Desa Kita** | Profil & konten desa |
| 4 | **Potensi Desa** | Pemetaan potensi sumber daya desa |
| 5 | **Desa Ekspor** | Produk desa siap ekspor |
| 6 | **BUMDES** | Manajemen Badan Usaha Milik Desa |
| 7 | **KDMP** | Kawasan Desa Mandiri Pangan |
| 8 | **Layanan Desa** | Layanan administrasi publik desa |

---

## Tech Stack

### Backend
| Teknologi | Versi | Fungsi |
|-----------|-------|--------|
| PHP | 8.4+ | Runtime |
| Laravel | 12.x | Framework Backend |
| Filament | 3.3 | Admin Panel |
| Filament Shield | 3.9 | RBAC & Permission Management |
| Spatie Permission | 6.x | Role & Permission |
| Laravel Sanctum | 4.x | API Authentication |
| MySQL | 8.0 | Database |
| Vite | 6.x | Asset Bundler |

### Frontend
| Teknologi | Versi | Fungsi |
|-----------|-------|--------|
| Next.js | 14.2+ | Framework Frontend (App Router, SSG) |
| React | 18.x | UI Library |
| TypeScript | 5.8+ | Bahasa Pemrograman (Type Safety) |
| Tailwind CSS | 3.4+ | Utility-first CSS Styling |
| Lucide React | latest | Icon System |

### Infrastructure
| Teknologi | Fungsi |
|-----------|--------|
| Nginx | Reverse Proxy & Static Files |
| Certbot / Let's Encrypt | SSL Certificate |
| CloudPanel | Server Management |

---

## Struktur Folder

```
sentra-desa/
├── sentra-desa-backend/            # Laravel 12 Backend
│   ├── app/
│   │   ├── Filament/               # Admin panel resources
│   │   │   └── Resources/          # CRUD untuk setiap modul
│   │   ├── Http/
│   │   │   └── Controllers/        # API controllers
│   │   ├── Models/                  # Eloquent models
│   │   ├── Policies/               # Authorization policies
│   │   └── Providers/              # Service providers
│   ├── config/                     # App configuration
│   ├── database/
│   │   ├── migrations/             # 23 migration files
│   │   └── seeders/                # Data seeders
│   ├── routes/
│   │   ├── api.php                 # API routes
│   │   └── web.php                 # Web routes
│   ├── resources/views/            # Blade templates
│   └── public/                     # Public assets
├── sentra-desa-frontend/           # Next.js 14 Frontend (Static Export)
│   ├── src/
│   │   ├── app/                    # Next.js App Router (pages & layouts)
│   │   ├── application/            # Use cases & business logic
│   │   ├── domain/                 # Entity types & repository contracts
│   │   ├── infrastructure/         # HTTP client & Laravel API repositories
│   │   └── presentation/           # UI components & interactive features
│   ├── public/                     # Static assets & icons
│   ├── out/                        # Production build output (static export)
│   ├── next.config.mjs             # Next.js config (output: export)
│   ├── tailwind.config.ts          # Tailwind CSS configuration
│   └── package.json                # Dependencies & scripts
└── README.md                       # Dokumentasi ini
```

---

## Prasyarat

### Backend
- PHP >= 8.4
- Composer >= 2.x
- MySQL >= 8.0
- Node.js >= 18.x (untuk Vite build)

### Frontend
- Node.js >= 18.x (disarankan 20.x LTS)
- npm >= 9.x atau yarn / pnpm

---

## Instalasi & Setup

### Backend (Laravel)

```bash
# 1. Masuk ke folder backend
cd sentra-desa-backend

# 2. Install dependencies
composer install

# 3. Copy dan konfigurasi environment
cp .env.example .env
php artisan key:generate

# 4. Konfigurasi database di .env
# DB_CONNECTION=mysql
# DB_HOST=127.0.0.1
# DB_PORT=3306
# DB_DATABASE=sentra_desa_db
# DB_USERNAME=root
# DB_PASSWORD=your_password

# 5. Jalankan migrasi dan seeder
php artisan migrate --seed

# 6. Buat storage symlink
php artisan storage:link

# 7. Build assets (Vite)
npm install && npm run build

# 8. Jalankan server development
php artisan serve
```

### Frontend (Next.js)

```bash
# 1. Masuk ke folder frontend
cd sentra-desa-frontend

# 2. Install dependencies
npm install

# 3. Konfigurasi environment
cp .env.example .env.local
# NEXT_PUBLIC_API_URL=https://sentradesa.id/api/v1 (atau /api/v1 untuk origin-relative)

# 4. Jalankan development server
npm run dev

# 5. Build untuk production (static export ke out/)
npm run build
```

---

## Deployment (Production)

### Server Requirements
- VPS / Cloud Server (min. 2GB RAM)
- Ubuntu 22.04+ / Debian 12+
- Nginx
- PHP 8.4 FPM
- MySQL 8.0
- SSL Certificate (Let's Encrypt)

### Quick Deploy

```bash
# 1. Upload Laravel ke server
rsync -avz sentra-desa-backend/ user@server:/var/www/html/sentradesa.id/laravel/

# 2. Konfigurasi .env production
# APP_ENV=production
# APP_DEBUG=false
# APP_URL=https://sentradesa.id

# 3. Install & optimize
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache

# 4. Build Next.js & upload
cd sentra-desa-frontend && npm run build
rsync -avz out/ user@server:/var/www/html/sentradesa.id/frontend/

# 5. Set permissions
chown -R www-data:www-data /var/www/html/sentradesa.id/
```

### Nginx Configuration

```nginx
server {
    listen 443 ssl http2;
    server_name sentradesa.id;

    # Next.js Frontend (Static Export)
    root /var/www/html/sentradesa.id/frontend;
    index index.html;

    # Laravel routes (admin, api, etc.)
    location ~ ^/(admin|api|sanctum|livewire)(/.*)?$ {
        root /var/www/html/sentradesa.id/laravel/public;
        try_files $uri $uri/ /index.php?$query_string;
        location ~ \.php$ {
            fastcgi_pass 127.0.0.1:9000;
            include fastcgi_params;
        }
    }

    # Laravel static assets
    location ~ ^/(build|css|js|storage|vendor|filament)/ {
        root /var/www/html/sentradesa.id/laravel/public;
        expires 30d;
    }

    # Next.js Static Export fallback
    location / {
        try_files $uri $uri/ $uri.html /index.html;
    }

    ssl_certificate /etc/letsencrypt/live/sentradesa.id/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/sentradesa.id/privkey.pem;
}
```

---

## Role & Permission (RBAC)

Menggunakan **Filament Shield** + **Spatie Permission**:

| Role | Akses |
|------|-------|
| `superadmin` | Semua fitur, semua data, semua daerah |
| `pemda` | Data di wilayah provinsi/kabupaten terkait |
| `desa` | Data di desa terkait |
| `merchant` | Produk & toko milik sendiri |
| `buyer` | Akses publik (read-only) |

Permission dibuat otomatis per-resource:
- `view_any_*`, `view_*`, `create_*`, `update_*`, `delete_*`, `restore_*`, `force_delete_*`

---

## API Endpoints

Base URL: `https://sentradesa.id/api/v1`

| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/products` | Daftar produk UMKM |
| GET | `/products/{id}` | Detail produk |
| GET | `/tourisms` | Daftar destinasi wisata |
| GET | `/tourisms/{id}` | Detail wisata |
| GET | `/villages` | Daftar desa |
| GET | `/villages/{id}` | Profil desa |
| GET | `/bumdes` | Daftar BUMDES |
| GET | `/kdmp` | Daftar KDMP |
| GET | `/export-products` | Daftar produk ekspor |
| GET | `/village-services` | Layanan desa |
| GET | `/village-potentials` | Potensi desa |
| GET | `/provinces` | Daftar provinsi |
| GET | `/regencies` | Daftar kabupaten |
| GET | `/districts` | Daftar kecamatan |
| POST | `/login` | Autentikasi (Sanctum) |
| POST | `/register` | Registrasi user |
| GET | `/user` | Profil user (auth) |

> **Auth:** Endpoint yang memerlukan autentikasi menggunakan Bearer Token (Laravel Sanctum).

---

## Screenshot

> *Screenshot akan ditambahkan setelah UI final.*

---

## Kontribusi

1. Fork repository ini
2. Buat feature branch (`git checkout -b feature/nama-fitur`)
3. Commit perubahan (`git commit -m 'feat: tambah fitur baru'`)
4. Push ke branch (`git push origin feature/nama-fitur`)
5. Buat Pull/Merge Request

### Commit Convention

```
feat: fitur baru
fix: perbaikan bug
docs: perubahan dokumentasi
style: formatting, missing semicolons, dll
refactor: refactoring kode
test: menambah/memperbaiki test
chore: maintenance
```

---

## Lisensi

Hak Cipta &copy; 2026 **SENTRA DESA**. All rights reserved.

Proyek ini bersifat **private** dan tidak untuk distribusi publik tanpa izin tertulis.
