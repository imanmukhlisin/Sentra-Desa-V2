# Sentra Desa Frontend

Next.js SSG rewrite dari Flutter Web Sentra Desa.

## Arsitektur

- `src/domain`: tipe entity dan kontrak repository.
- `src/application`: use case yang dipakai halaman.
- `src/infrastructure`: HTTP client dan implementasi repository Laravel API.
- `src/presentation`: komponen UI dan fitur client-side.
- `src/app`: routing Next.js App Router.

## Perintah

```bash
npm.cmd install
npm.cmd run dev
npm.cmd run build
```

Build memakai static export. Hasil build tersedia di folder `out/` dan dapat langsung dilayani Nginx.
Konten awal beranda tertanam saat build, lalu daftar produk disegarkan dari API ketika halaman dibuka agar perubahan database tampil tanpa menunggu build berikutnya.
Tipografi mengikuti Flutter Material: Roboto untuk seluruh UI dan monospace untuk konten kode.
Pada browser, URL API otomatis mengikuti origin deployment (`/api/v1`) sehingga build lokal aman diunggah ke domain produksi.

Rute interaktif dengan ID yang tidak diketahui saat build memakai query string, misalnya `/merchant/products/edit/?id=123`.
