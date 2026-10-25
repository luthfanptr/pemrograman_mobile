import 'package:flutter/material.dart';
import 'package:test_app/main.dart';

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
        itemCount: daftarMenu.length, // panggil class daftarMenu
        itemBuilder: (context, index) {
          final item = daftarMenu[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.restaurant),
              title: Text(item.nama),
              subtitle: Text('Rp ${item.harga}'),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}