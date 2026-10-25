import 'package:flutter/material.dart';
import 'package:pert2/modul/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // root awal app secara global
      title: 'praktikum2',
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const MenuPage(), // entrypoint, class apa dulu yang mau ditampilkan
    );
  }
}

class Makanan {
  final String nama;
  final int harga;
  const Makanan(this.nama, this.harga); // constructor, untuk instansiasi object dari class Makanan
}

const daftarMenu = [ // dipanggil semua kesini (list), var harus sesuai dengan constructornya
  Makanan('Nasi Goreng', 15000),
  Makanan('Mie Ayam', 12000),
  Makanan('Ayam Bakar', 20000),
  Makanan('Sate Ayam', 18000),
];

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Menu')),
      body: ListView.builder(
        itemCount: daftarMenu.length, // jumlah loop/callback yang dilakukan untuk buat satu baris layar
        itemBuilder: (context, index) { // callback/loop yang dipanggil ListView.builder
          final item = daftarMenu[index]; // operasi membaca List berdasarkan no urut
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.restaurant),
              title: Text(item.nama),
              subtitle: Text('Rp ${item.harga}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  DetailPage(makanan: item)),
                );
              }
            ),
          );
        },
      ),
    );
  }
}

// halaman detail yang menerima data lewat constructor
class DetailPage extends StatelessWidget {
  final Makanan makanan; // declare var, [tipe data] [var], Makanan dari class Makanan, makanan hanya penamaan variable (properti)
  const DetailPage({super.key, required this.makanan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(makanan.nama)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restaurant_menu, size: 80),
            const SizedBox(height: 16),
            Text(makanan.nama, style: const TextStyle(fontSize: 24)),
            Text('Rp ${makanan.harga}'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}