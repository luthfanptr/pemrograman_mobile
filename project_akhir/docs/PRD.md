# Product Requirement Document
## Aplikasi POS Mobile Kopi Benteng

| Atribut | Isi |
|---|---|
| Versi | 1.0 (*Draft*) |
| Penyusun | Luthfan Putra Prakarsa |
| Tanggal | 25 Oct 2026 |
| Dokumen Acuan | BRD Aplikasi POS Mobile Kopi Benteng V 1.0 |
| Status | Draft |

### Riwayat Revisi

| Versi | Tanggal | Perubahan | Penyusun |
|---|---|---|---|
| 0.1 | 25 Oct 2026 | Versi awal | Luthfan Putra Prakarsa |

---

## 1. Ringkasan Produk

### 1.1 Deskripsi dan Visi Produk
Aplikasi POS Mobile Kopi Benteng adalah aplikasi kasir Android berbasis *offline-first* untuk mencatat transaksi penjualan harian 15 armada keliling Kopi Benteng, memverifikasi setoran harian (Tunai/QRIS), dan merekap data penjualan secara terpusat.

**Visi:** menjadi sistem pencatatan penjualan digital yang andal bagi seluruh armada keliling Kopi Benteng, sehingga setiap transaksi tercatat utuh dan akurat meskipun berjualan tanpa sinyal internet, serta setoran harian dapat diverifikasi dengan cepat tanpa selisih.

### 1.2 Masalah yang Diselesaikan
Pencatatan manual berbasis kertas membuat data penjualan rentan hilang, rusak, atau tidak terbaca (M-01). Kesalahan hitung manual saat memeriksa setoran memicu selisih uang dan verifikasi yang lambat (M-02). Rekapitulasi yang diinput manual memakan waktu lama dan rawan salah (M-03). Belum ada data penjualan per menu secara terpusat, sehingga stok dan pasokan bahan baku sulit ditentukan (M-04). Aplikasi menyelesaikannya dengan menyimpan setiap transaksi secara digital dan *offline-first*, menghitung ringkasan setoran Tunai dan QRIS per armada otomatis, serta menyediakan rekap individu dan laporan penjualan per menu tanpa input ulang.

| ID BRD | Masalah | Solusi Produk |
|---|---|---|
| M-01 | Catatan kertas rentan hilang/rusak/tidak terbaca | Transaksi disimpan di *database* lokal perangkat, lalu disinkronkan ke *server* pusat (FR-02, FR-03, NFR-04) |
| M-02 | Kesalahan hitung saat pemeriksaan setoran | Ringkasan Tunai dan QRIS per armada dihitung otomatis, dengan status verifikasi oleh *Mixer* (FR-04) |
| M-03 | Input rekapitulasi manual lama dan rawan salah | Rekap individu harian/mingguan/bulanan otomatis dari data terverifikasi (FR-05) |
| M-04 | Tidak ada data penjualan per menu secara terpusat | Setiap transaksi mencatat menu dan jumlah; laporan per varian menu dan *dashboard* tersedia (FR-05, IS-05) |

### 1.3 Tujuan Produk & Metrik Keberhasilan
| ID BRD | Tujuan | KPI | Target | Periode | Metode Pengukuran (PRD) |
|---|---|---|---|---|---|
| TM-01 | Mengamankan data riwayat penjualan secara digital | Tingkat kehilangan data transaksi harian | 0 kasus | Bulanan | Rekonsiliasi jumlah transaksi di perangkat dengan *server* setelah sinkronisasi [KONFIRMASI] |
| TM-02 | Mempercepat verifikasi setoran dan meminimalkan selisih | Waktu verifikasi per armada; selisih setoran | ≤ 5 menit; 0% | Harian | Pengukuran waktu pada UAT dan selisih total sistem vs uang/mutasi [KONFIRMASI] |
| TM-03 | Mengotomatisasi rekapitulasi penjualan individu | Waktu pemrosesan rekap | Turun ≥ 70% | Mingguan/Bulanan | Perbandingan waktu rekap manual (*baseline*) dengan waktu rekap di sistem [KONFIRMASI] |
| TM-04 | Menyediakan data penjualan per menu | Ketersediaan laporan *menu sales breakdown* | 100% menu terlacak | Harian/Mingguan/Bulanan | Jumlah menu aktif yang muncul di laporan dibanding total menu aktif |

### 1.4 Keputusan Produk
| No | Keputusan | Alasan | Rujukan BRD |
|---|---|---|---|
| 1 | Aplikasi hanya untuk Android | Seluruh perangkat penjual berkelas *entry-level/low-end* | OS-05, Bab 8 |
| 2 | Pendekatan *offline-first* | Penjual sering tanpa sinyal; target kehilangan data 0 kasus | FR-03, NFR-04, TM-01 |
| 3 | Sinkronisasi manual pada MVP, otomatis pada tahap lanjutan | Menjaga MVP ringkas | FR-03, FR-06 |
| 4 | QRIS hanya penanda metode bayar, tanpa *payment gateway* | Tunai/QRIS adalah SOP; validasi oleh *Mixer* via mutasi rekening | OS-02, Bab 8 |
| 5 | Ringkasan setoran memisahkan Tunai dan QRIS per armada | Verifikasi ≤ 5 menit | FR-04, TM-02 |
| 6 | Kasir berupa tombol/ikon besar tanpa mengetik, label bahasa Indonesia | Literasi digital penjual rendah | NFR-01 |
| 7 | *Payroll*, bonus, slip gaji di luar aplikasi | Penggajian tunai di luar sistem | OS-01, FR-08 |
| 8 | Harga seragam; hanya Owner/Admin yang dapat mengubah | Konsistensi harga | Bab 7 |
| 9 | Stok awal yang dikonfirmasi penjual menjadi batas kuota Kasir | Menghubungkan stok harian dengan penjualan per menu | Bab 3.4 |
| 10 | SQLite lokal hanya menyimpan periode berjalan | RAM dan ruang simpan terbatas | Bab 8, RK-04 |
| 11 | *Single-tenant* (hanya Kopi Benteng) | Bukan produk multi-usaha | Bab 7 |
| 12 | Rilis bertahap berdasarkan MoSCoW | MVP memuat seluruh *Must Have* | Bab 6 |

### 1.5 Fitur Inti dan *User Stories*
| ID | Fitur Inti | *User Story* | Prioritas | Rujukan |
|---|---|---|---|---|
| CF-01 | Autentikasi berbasis peran | Sebagai pengguna, saya ingin *login* sesuai peran agar hanya mengakses fitur tanggung jawab saya. | *Must Have* | IS-01, FR-01 |
| CF-02 | Modul Kasir | Sebagai Penjual Keliling, saya ingin memilih menu, jumlah, dan metode bayar dengan tombol besar agar transaksi tercatat cepat tanpa mengetik. | *Must Have* | IS-02, FR-02, NFR-01 |
| CF-03 | Penyimpanan lokal dan sinkronisasi | Sebagai Penjual Keliling, saya ingin transaksi tersimpan di HP walau tanpa sinyal dan disinkronkan di pangkalan agar tidak ada data hilang. | *Must Have* | IS-07, FR-03, NFR-04 |
| CF-04 | Modul Produk | Sebagai Owner/Admin, saya ingin mengelola menu, harga seragam, dan status menu agar data konsisten di semua armada. | *Must Have* | IS-03 |
| CF-05 | Kuota stok harian | Sebagai *Mixer*, saya ingin mengatur ketersediaan menu dan kuota per armada agar penjualan sesuai stok yang dibawa. | *Must Have* | IS-03, Bab 3.4 |
| CF-06 | Ringkasan dan verifikasi setoran | Sebagai *Mixer*, saya ingin melihat total Tunai dan QRIS terpisah per armada agar verifikasi selesai ≤ 5 menit. | *Must Have* | FR-04, TM-02 |
| CF-07 | Modul Riwayat | Sebagai Penjual Keliling, saya ingin melihat riwayat dengan filter periode agar bisa memeriksa pendapatan dan transaksi saya. | *Must Have* | IS-04 |
| CF-08 | Laporan rekap individu dan per menu | Sebagai Admin (*Payroll*), saya ingin rekap penjualan individu per periode agar dasar gaji tersedia tanpa input ulang. | *Must Have* | IS-06, FR-05, TM-03 |
| CF-09 | *Dashboard* penjualan | Sebagai Owner, saya ingin memantau penjualan per menu dan performa bisnis agar keputusan berbasis data. | *Must Have* | IS-05, TM-04 |
| CF-10 | Sinkronisasi latar belakang otomatis | Sebagai Penjual Keliling, saya ingin data terkirim otomatis saat sinyal stabil. | *Should Have* | FR-06 |
| CF-11 | Pencarian menu dan filter kategori | Sebagai Penjual Keliling, saya ingin mencari menu lewat teks dan kategori. | *Could Have* | FR-07 |

---

## 2. Pengguna & Hak Akses

### 2.1 Persona dan Target User
| Peran | Deskripsi | Kebutuhan Utama | Perangkat/Konteks Penggunaan | Posisi |
|---|---|---|---|---|
| Penjual Keliling | Menjual menu berpindah-pindah (*mobile selling*) dan mencatat transaksi | Pencatatan digital sederhana, pilihan Tunai/QRIS | Android *low-end*, sering tanpa sinyal, luar ruangan, literasi digital rendah | Utama |
| *Mixer* | Menyiapkan stok dan kuota harian, menerima tunai, memvalidasi QRIS | Rincian setoran Tunai vs QRIS per armada | Gerai/pangkalan dengan *Wi-Fi*, akhir jam operasional | Utama |
| Admin (*Payroll*) | Mengelola rekap transaksi terverifikasi untuk dasar gaji | Rekap otomatis, akurat, bebas salah hitung | Menarik laporan periodik; antarmuka web [KONFIRMASI] | Pendukung |
| Owner | Pemilik usaha, pengambil keputusan | Laporan transparan, konsisten, mudah dibaca | Memantau *dashboard*; antarmuka web [KONFIRMASI] | Pendukung |

### 2.2 Matriks Hak Akses (RBAC) — [KONFIRMASI]
| Fitur / Modul | Owner | Admin Payroll | Mixer | Penjual Keliling |
|---|---|---|---|---|
| *Login* | ✔ | ✔ | ✔ | ✔ |
| Modul Kasir | — | — | — | ✔ |
| Modul Produk (menu, harga, status) | ✔ | ✔ | Lihat | Lihat |
| Atur ketersediaan menu dan kuota stok harian | — | — | ✔ | — |
| Konfirmasi stok awal | — | — | — | ✔ |
| Modul Riwayat | — | — | — | ✔ (milik sendiri) |
| Verifikasi setoran | — | — | ✔ | — |
| *Dashboard* penjualan | ✔ | — | — | — |
| Modul Laporan | ✔ | ✔ | — | — |

---

## 3. Lingkup

### 3.1 Dalam Lingkup
| ID | Lingkup | Keterangan |
|---|---|---|
| IS-01 | Autentikasi RBAC | Akses sesuai peran |
| IS-02 | Modul Kasir | Pencarian menu per varian, transaksi, jumlah, harga, metode bayar |
| IS-03 | Modul Produk | Input/kelola menu, harga jual, stok yang dibawa armada, status menu |
| IS-04 | Modul Riwayat | Data historis (filter harian/mingguan/bulanan), pendapatan individu, total transaksi, metode bayar |
| IS-05 | *Dashboard* Penjualan | Ringkasan penjualan menu dan performa bisnis |
| IS-06 | Modul Laporan | Rekap transaksi individu pegawai keliling |
| IS-07 | Penyimpanan Lokal & Sinkronisasi | *Offline-first*, sinkronisasi ke *server* saat terhubung |

### 3.2 Luar Lingkup
| ID | Lingkup | Keterangan |
|---|---|---|
| OS-01 | Perhitungan *payroll*, bonus, slip gaji | Penggajian tunai, di luar sistem |
| OS-02 | Integrasi *payment gateway* | Tunai/QRIS berdasarkan SOP |
| OS-03 | Manajemen inventori bahan baku | Di luar sistem |
| OS-04 | Modul akuntansi lanjutan | Di luar sistem |
| OS-05 | Versi iOS | Hanya Android |

---

## 4. Alur Pengguna (*User Flow*)

| Tahap | Aktor | Aktivitas | Layar/Modul Terkait | Output |
|---|---|---|---|---|
| 1. Persiapan stok harian | *Mixer* | Menyiapkan stok, mengatur ketersediaan menu dan kuota per armada | Kuota stok (CF-05) | Kuota stok per armada |
| 2. *Login* & muat data | Penjual Keliling | *Login*, memuat produk dan harga terbaru | Autentikasi, Produk (CF-01, CF-04) | Data produk lokal |
| 3. Pengambilan stok awal | Penjual Keliling | Memilih varian dan mengonfirmasi kuantitas stok yang dibawa | Konfirmasi stok awal | Alokasi stok awal harian (batas kuota Kasir) |
| 4. Transaksi keliling (*offline-first*) | Penjual Keliling | Pilih menu, jumlah, metode bayar (Tunai/QRIS) | Kasir (CF-02) | Transaksi tersimpan lokal, sisa stok berkurang |
| 5. Sinkronisasi di pangkalan | Penjual Keliling | Sinkronisasi data (*Wi-Fi* gerai) | Sinkronisasi (CF-03) | Data di *server* pusat |
| 6. Verifikasi setoran | *Mixer* | Cek rincian setoran, terima tunai, cocokkan QRIS dengan mutasi rekening pusat | Setoran (CF-06) | Setoran berstatus terverifikasi |
| 7. Rekap & pemantauan | Admin *Payroll*, Owner | Tarik laporan individu; pantau *dashboard* | Laporan, *Dashboard* (CF-08, CF-09) | Rekap individu, *menu sales breakdown* |

*Diagram alur / wireframe:* [ISI tautan atau lampiran]

---

## 5. Kebutuhan Fungsional

> Format: ID PRD → rujukan BRD → *user story* → kriteria penerimaan (*acceptance criteria*) → aturan bisnis.

### 5.1 Autentikasi & RBAC (IS-01, FR-01 — *Must Have*)
- **PRD-AUTH-01** — Sebagai pengguna, saya ingin *login* agar mengakses fitur sesuai tanggung jawab.
  - **Kriteria penerimaan:**
    - [ ] AC-01: *Given* pengguna memiliki akun berperan, *when* *login* dengan kredensial valid, *then* hanya menu sesuai perannya yang tampil (matriks 2.2)
    - [ ] AC-02: *Given* kredensial tidak valid, *when* menekan masuk, *then* akses ditolak dengan pesan berbahasa Indonesia
    - [ ] Metode *login*: [KONFIRMASI: *username*/PIN, lihat Pertanyaan Terbuka 4]
    - [ ] Perilaku *login* saat *offline* dan sesi/*logout*: [KONFIRMASI]
  - **Aturan bisnis:** Token API diterbitkan dan divalidasi melalui Laravel Sanctum; hak akses sesuai peran.

### 5.2 Modul Kasir (IS-02, FR-02, FR-07)
- **PRD-KSR-01** *(Must Have)* — Sebagai Penjual Keliling, saya ingin memilih menu, jumlah, dan metode bayar (Tunai/QRIS) agar transaksi tercatat digital.
  - **Kriteria penerimaan:**
    - [ ] AC-03: *Given* produk termuat dan kuota tersedia, *when* menu, jumlah, dan metode bayar dipilih lalu disimpan, *then* transaksi tersimpan, total terhitung otomatis sesuai harga jual, dan sisa stok berkurang
    - [ ] AC-04: Seluruh alur dapat diselesaikan tanpa mengetik, dengan tombol/ikon besar dan label bahasa Indonesia (NFR-01)
    - [ ] AC-05: *Given* metode bayar belum dipilih, *when* menyimpan, *then* transaksi tidak tersimpan dan penjual diminta memilih Tunai atau QRIS
    - [ ] AC-06: *Given* kuota menu habis, *when* menambah menu tersebut, *then* penambahan ditolak dan penjual diberi tahu stok habis
    - [ ] Konfirmasi sebelum simpan untuk memitigasi RK-03: [KONFIRMASI]
  - **Aturan bisnis:** Penjualan dibatasi kuota stok harian; pembatalan/koreksi transaksi: [KONFIRMASI, lihat Pertanyaan Terbuka 1].
- **PRD-KSR-02** *(Could Have)* — Pencarian menu berbasis teks (*search bar*) dan *filter* kategori.
  - **Kriteria penerimaan:**
    - [ ] AC-23: *Given* penjual di halaman Kasir, *when* mengetik teks atau memilih kategori, *then* daftar menu tersaring sesuai masukan

### 5.3 Modul Produk (IS-03)
- **PRD-PRD-01** — Sebagai Owner/Admin, saya ingin mengelola menu, harga jual, dan status menu; sebagai *Mixer*, saya ingin mengatur ketersediaan menu dan kuota stok per armada.
  - **Kriteria penerimaan:**
    - [ ] AC-12: *Given* pengguna Owner/Admin, *when* menambah, mengubah, atau menonaktifkan menu dan harga, *then* perubahan tersimpan dan harga baru berlaku seragam untuk seluruh armada setelah sinkronisasi
    - [ ] AC-13: *Given* pengguna selain Owner/Admin, *when* mencoba mengubah harga, *then* akses ditolak
    - [ ] AC-14: *Given* *Mixer* membuka pengaturan harian, *when* mengatur ketersediaan menu dan kuota per armada, *then* kuota tersimpan dan menjadi batas penjualan di Kasir armada tersebut
    - [ ] Apakah perubahan harga berlaku pada transaksi lama atau hanya baru: [KONFIRMASI]
  - **Aturan bisnis:** Harga seragam untuk semua armada; hanya Owner/Admin yang dapat mengubah.

### 5.4 Penyimpanan Lokal & Sinkronisasi (IS-07, FR-03, FR-06)
- **PRD-SYN-01** *(Must Have)* — Sebagai Penjual Keliling, saya ingin data tersimpan di perangkat dan dapat disinkronkan manual saat tersambung.
  - **Kriteria penerimaan:**
    - [ ] AC-07: *Given* perangkat tanpa internet, *when* menyimpan transaksi, *then* penyimpanan lokal selesai ≤ 1 detik
    - [ ] AC-08: *Given* transaksi tersimpan lokal, *when* aplikasi ditutup paksa atau baterai habis lalu dibuka kembali, *then* seluruh transaksi tetap ada
    - [ ] AC-09: *Given* ada transaksi belum tersinkron dan perangkat terhubung, *when* tombol sinkronisasi ditekan, *then* data terkirim dalam format JSON, status sinkron diperbarui, dan aset gambar tidak diunduh ulang
    - [ ] AC-10: *Given* sinkronisasi diulang untuk data yang sama, *when* ditekan kembali, *then* tidak ada transaksi ganda di *server*
    - [ ] AC-11: *Given* dua perangkat mengubah data yang sama (mis. harga/status), *when* keduanya tersinkron, *then* nilai dengan penanda waktu terbaru yang dipakai (*Last-Write-Wins*) tanpa kegagalan sinkronisasi
    - [ ] Indikator status sinkron (belum/sedang/berhasil/gagal) tampil jelas
  - **Aturan bisnis:** SQLite lokal hanya menyimpan periode berjalan; riwayat jangka panjang di *server*; kapan data lokal boleh dihapus setelah sinkron: [KONFIRMASI].
- **PRD-SYN-02** *(Should Have, pasca-MVP)* — Sinkronisasi latar belakang otomatis dengan *queue/retry*.
  - **Kriteria penerimaan:**
    - [ ] AC-22: *Given* ada data belum tersinkron dan sinyal kembali stabil, *when* perangkat terhubung, *then* data terkirim otomatis; jika gagal, dicoba ulang

### 5.5 Setoran Harian & Verifikasi (FR-04 — *Must Have*)
- **PRD-STR-01** — Sebagai *Mixer*, saya ingin melihat ringkasan setoran per armada yang memisahkan Tunai dan QRIS agar verifikasi cepat.
  - **Kriteria penerimaan:**
    - [ ] AC-15: *Given* transaksi harian armada sudah tersinkron, *when* *Mixer* membuka ringkasan setoran, *then* total Tunai dan QRIS tampil terpisah otomatis per armada
    - [ ] AC-16: *Given* *Mixer* telah mencocokkan uang tunai dan mutasi QRIS, *when* menandai setoran, *then* status berubah menjadi terverifikasi
    - [ ] AC-17: Verifikasi satu armada selesai ≤ 5 menit dengan selisih 0% terhadap catatan sistem (TM-02)
    - [ ] Input uang fisik oleh *Mixer* untuk menghitung selisih: [KONFIRMASI]
  - **Aturan bisnis:** Validasi dana QRIS dilakukan *Mixer* lewat mutasi rekening pusat, bukan integrasi API (OS-02); koreksi pasca-verifikasi: [KONFIRMASI, lihat Pertanyaan Terbuka 2].

### 5.6 Modul Riwayat (IS-04)
- **PRD-RWY-01** — Sebagai Penjual Keliling, saya ingin melihat riwayat penjualan dengan filter harian/mingguan/bbulanan.
  - **Kriteria penerimaan:**
    - [ ] AC-18: *Given* penjual memiliki transaksi tersimpan, *when* memilih filter harian/mingguan/bulanan, *then* tampil pendapatan individu, total transaksi, dan rincian metode bayar sesuai periode
    - [ ] Batas riwayat di perangkat vs *server*: [KONFIRMASI]

### 5.7 *Dashboard* Penjualan (IS-05)
- **PRD-DSB-01** — Sebagai Owner, saya ingin memantau ringkasan penjualan per menu dan performa bisnis.
  - **Kriteria penerimaan:**
    - [ ] AC-21: *Given* data terverifikasi sudah masuk ke *server*, *when* Owner membuka *dashboard*, *then* ringkasan penjualan per menu dan performa bisnis tampil sesuai data terbaru
    - [ ] Komponen visual (total, tren, menu terlaris, per armada): [KONFIRMASI]

### 5.8 Modul Laporan (IS-06, FR-05 — *Must Have*)
- **PRD-LPR-01** — Sebagai Admin (*Payroll*), saya ingin rekap penjualan individu per periode agar tidak perlu input ulang.
  - **Kriteria penerimaan:**
    - [ ] AC-19: *Given* data transaksi sudah tersinkron, *when* Admin memilih periode harian/mingguan/bulanan, *then* rekap penjualan individu tampil otomatis tanpa input ulang
    - [ ] AC-20: *Given* data transaksi tersedia, *when* laporan per varian menu dibuka, *then* seluruh menu aktif tercatat dan tampil (TM-04)
    - [ ] Cakupan data (terverifikasi saja/semua) dan format ekspor: [KONFIRMASI]
  - **Aturan bisnis:** Perhitungan gaji/bonus di luar sistem (OS-01, FR-08 *Won't Have*).

### 5.9 Di Luar Rilis Ini (*Won't Have*)
- FR-08: Slip gaji otomatis, pajak, pencairan bonus.

---

## 6. Kebutuhan Non-Fungsional

| ID | Aspek | Spesifikasi | Prioritas | Cara Verifikasi |
|---|---|---|---|---|
| NFR-01 | Kemudahan penggunaan | Kasir tanpa keyboard, ikon/tombol besar, label bahasa Indonesia | *Must Have* | UAT dengan penjual keliling (UAT-05) |
| NFR-02 | Keterbacaan luar ruangan | *High-Contrast Light Mode*, teks jelas di bawah terik matahari | *Should Have* | Uji lapangan di luar ruangan |
| NFR-03 | Kompatibilitas *low-end* | Android ≥ 8.0, RAM 2 GB, ruang kosong ≥ 100 MB, tanpa animasi transisi berat | *Must Have* | Uji pada perangkat spesifikasi minimum (AC-24) |
| NFR-04 | Keandalan *offline-first* | Simpan transaksi lokal ≤ 1 detik; data aman saat *force close*/baterai habis | *Must Have* | AC-07, AC-08 |
| NFR-05 | Efisiensi baterai & kuota | Sinkronisasi JSON ringan, tanpa muat ulang aset gambar | *Should Have* | AC-09 |
| NFR-06 | Keamanan *(tambahan, [KONFIRMASI])* | Autentikasi token (Sanctum) dan komunikasi HTTPS; enkripsi data lokal: [KONFIRMASI] | [KONFIRMASI] | [KONFIRMASI] |

---

## 7. Model Data (Tingkat Konseptual)

| Entitas | Atribut Utama | Catatan |
|---|---|---|
| Pengguna | id, nama, peran, kredensial | RBAC |
| Armada | id, nama/kode, penjual aktif | 15 unit aktif |
| Menu/Varian | id, nama, kategori, harga, status, gambar | Harga seragam |
| Stok Harian Armada | tanggal, armada, menu, kuota | Batas penjualan Kasir; sisa stok dihitung dari kuota dikurangi transaksi |
| Transaksi | id, waktu (*timestamp*), penjual, armada, metode bayar, total, status sinkron | Waktu dari jam perangkat; bersifat *append-only* |
| Item Transaksi | transaksi, menu, jumlah, harga satuan | |
| Setoran Harian | tanggal, armada, total Tunai, total QRIS, status verifikasi, diverifikasi oleh | |

Setiap entitas yang dapat diubah memuat penanda waktu perubahan dan identitas perangkat untuk penggabungan LWW.

*ERD:* [ISI tautan atau lampiran]

---

## 8. Pertimbangan Teknis

### 8.1 Arsitektur Aplikasi
| Komponen | Teknologi | Deskripsi Peran |
|---|---|---|
| Aplikasi POS (*mobile client*) | Flutter (Android) | Dipakai Penjual Keliling dan *Mixer*: Kasir, Produk, Riwayat, setoran. Dioptimalkan untuk perangkat *low-end* (NFR-03). |
| Pola arsitektur aplikasi | MVVM | *View* menampilkan antarmuka; *ViewModel* mengelola *state* dan aturan transaksi; *Model/Repository* menjadi satu-satunya akses data lokal dan *server*. |
| Penyimpanan lokal | SQLite di perangkat | Sumber data utama (*offline-first*); hanya periode berjalan. |
| Mekanisme alur data | CRDT dengan *Last-Write-Wins* (LWW) | Perubahan diberi penanda waktu dan identitas perangkat; saat sinkronisasi digabung dua arah tanpa konflik, nilai terbaru dipakai. |
| Lapisan sinkronisasi | JSON melalui HTTPS | Mengirim/menerima perubahan (*delta*) tanpa memuat ulang aset gambar (NFR-05). |
| *Backend* dan API | Laravel 13 | Menerima dan menggabungkan perubahan, menyediakan data produk, menghitung ringkasan setoran dan rekap laporan. |
| Autentikasi dan otorisasi | Laravel Sanctum | Token API untuk aplikasi POS dan pembatasan akses per peran. |
| *Dashboard* dan panel admin | Filament v5 | Antarmuka web untuk Owner dan Admin: *dashboard*, laporan, pengelolaan menu dan harga. |
| *Database* pusat | SQLite di *server* | Riwayat transaksi jangka panjang. |

**Alur data:** *View* → *ViewModel* → *Repository* → SQLite lokal → (saat tersambung) sinkronisasi JSON ke Laravel dengan penggabungan LWW → *database* pusat → Filament.

### 8.2 Lainnya
- **Platform:** Android saja (OS-05); minimal Android 8.0.
- **Sinkronisasi:** manual (MVP), otomatis dengan *queue/retry* (pasca-MVP).
- **Integrasi eksternal:** tidak ada API perbankan/*payment gateway* (OS-02).
- **Keterbatasan:** *timestamp* bergantung pada jam perangkat; mitigasi (mis. validasi waktu saat sinkronisasi): [KONFIRMASI].
- ***Hosting*:** [ISI]
- **Spesifikasi API:** [ISI tautan]

---

## 9. Rencana Rilis

| Fase | Isi | Prioritas BRD | Target Tanggal |
|---|---|---|---|
| MVP | FR-01 – FR-05 (CF-01 – CF-09), NFR-01, NFR-03, NFR-04 | *Must Have* | [ISI] |
| Rilis 2 | FR-06 (CF-10), NFR-02, NFR-05 | *Should Have* | [ISI] |
| Rilis 3 | FR-07 (CF-11) | *Could Have* | [ISI] |
| Tidak dikerjakan | FR-08 | *Won't Have* | — |

---

## 10. Pengujian & Kriteria Penerimaan (UAT)

Kriteria rinci per fitur (AC-01 sampai AC-23) ada pada Bagian 5. Skenario UAT berikut menguji target BRD secara menyeluruh.

| ID | Skenario | Terkait | Hasil yang Diharapkan | Status |
|---|---|---|---|---|
| UAT-01 | Transaksi tanpa internet, aplikasi di-*force close*, dibuka kembali | TM-01, NFR-04 (AC-07, AC-08) | Data tetap ada | [ISI] |
| UAT-02 | Verifikasi setoran 1 armada | TM-02, FR-04 (AC-17) | ≤ 5 menit, selisih 0% | [ISI] |
| UAT-03 | Tarik rekap bulanan individu | TM-03, FR-05 (AC-19) | Instan, tanpa input ulang | [ISI] |
| UAT-04 | Laporan penjualan per menu | TM-04, FR-05 (AC-20) | Semua menu terlacak | [ISI] |
| UAT-05 | Pengoperasian oleh penjual berliterasi digital rendah | NFR-01, RK-01 (AC-04) | Transaksi selesai tanpa bantuan | [ISI] |
| UAT-06 | Penggunaan di perangkat spesifikasi minimum | NFR-03 (AC-24) | Berjalan lancar tanpa animasi berat | [ISI] |

---

## 11. Risiko & Mitigasi Produk

| ID BRD | Risiko | Dampak | Probabilitas | Mitigasi di Level Produk |
|---|---|---|---|---|
| RK-01 | Resistensi pengguna (literasi digital rendah) | Tinggi | Sedang | Kasir tanpa mengetik, tombol besar, label bahasa Indonesia (NFR-01); pelatihan dan masa transisi: [KONFIRMASI] |
| RK-02 | Perangkat mati sebelum sinkronisasi | Tinggi | Sedang | Transaksi langsung tersimpan lokal dan tahan *force close*/baterai habis (NFR-04) |
| RK-03 | Salah pilih metode bayar (Tunai/QRIS) | Sedang | Tinggi | Metode bayar wajib dipilih (AC-05); konfirmasi sebelum simpan dan koreksi oleh *Mixer*: [KONFIRMASI] |
| RK-04 | Penumpukan data lokal di HP *low-end* | Sedang | Rendah | SQLite hanya periode berjalan; pembersihan data tersinkron dan peringatan ruang: [KONFIRMASI] |

---

## 12. Asumsi, Ketergantungan, & Pertanyaan Terbuka

### 12.1 Asumsi (dari BRD)
- Hanya Android; semua penjual memiliki *smartphone* Android yang berfungsi.
- *Single-tenant* (Kopi Benteng).
- *Wi-Fi* tersedia di gerai untuk sinkronisasi.
- Harga seragam antar-armada; hanya Owner/Admin yang dapat mengubah.

### 12.2 Ketergantungan
- Kedisiplinan penjual (mencatat saat transaksi) dan *Mixer* (verifikasi harian).
- Ketersediaan *backend server* dan *database* pusat.
- Akses *Mixer* ke aplikasi *merchant*/mutasi rekening QRIS.

### 12.3 Pertanyaan Terbuka
| No | Pertanyaan | Pemilik | Status |
|---|---|---|---|
| 1 | Apakah transaksi yang sudah tersimpan boleh diedit/dibatalkan, dan oleh siapa? | [ISI] | Terbuka |
| 2 | Bagaimana penanganan selisih setoran yang ditemukan *Mixer*? | [ISI] | Terbuka |
| 3 | Apakah satu penjual selalu terikat ke satu armada? | [ISI] | Terbuka |
| 4 | Metode *login* yang sesuai untuk pengguna berliterasi digital rendah? | [ISI] | Terbuka |
| 5 | Bagaimana mencegah jam perangkat yang salah memengaruhi LWW dan *timestamp* transaksi? | [ISI] | Terbuka |

---

## 13. Matriks Keterlacakan (BRD → PRD)

| BRD | PRD |
|---|---|
| TM-01 | PRD-SYN-01, NFR-04, UAT-01 |
| TM-02 | PRD-STR-01, UAT-02 |
| TM-03 | PRD-LPR-01, UAT-03 |
| TM-04 | PRD-LPR-01, PRD-DSB-01, UAT-04 |
| IS-01 / FR-01 | PRD-AUTH-01 |
| IS-02 / FR-02 | PRD-KSR-01 |
| FR-07 | PRD-KSR-02 |
| IS-03 | PRD-PRD-01 |
| IS-04 | PRD-RWY-01 |
| IS-05 | PRD-DSB-01 |
| IS-06 / FR-05 | PRD-LPR-01 |
| IS-07 / FR-03 | PRD-SYN-01 |
| FR-04 | PRD-STR-01 |
| FR-06 | PRD-SYN-02 |

---

## 14. Lampiran
- Glosarium: merujuk BRD Bab 11 (Armada keliling, *Low-End Device*, *Mixer*, MoSCoW, MVP, *Offline-First*, POS, RBAC)
- *Wireframe*/*mockup*: [ISI]
- ERD: [ISI]
- Spesifikasi API: [ISI]