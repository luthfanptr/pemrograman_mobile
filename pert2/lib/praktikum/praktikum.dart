import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final String deskripsi;
  const Makanan(this.nama, this.harga, this.deskripsi); // constructor, untuk instansiasi object dari class Makanan
}

const daftarMenu = [ // dipanggil semua kesini (list), var harus sesuai dengan constructornya
  Makanan('Nasi Goreng', 15000, 'Nasi goreng ati ampela dengan telur dadar dan rempah rempah'),
  Makanan('Mie Ayam', 12000, 'Mie ayam paling enak'),
  Makanan('Ayam Bakar', 20000, 'Ayam bakar kecap jos'),
  Makanan('Sate Ayam', 18000, 'Sate ayam rasa ayam'),
  Makanan('Soto', 15000, 'SOTO TANPA KECAP!!!'),
  Makanan('Mie Goreng', 18000, 'Mie goreng kecap manis mania mantap'),
  Makanan('Kwetiau', 18000, 'kwetiau goreng/rebus mantap'),
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
          // return Card(
          //   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          //   child: ListTile(
          //     leading: const Icon(Icons.restaurant),
          //     title: Text(item.nama),
          //     subtitle: Text('Rp ${item.harga}'),
          //     trailing: const Icon(Icons.chevron_right),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) =>  DetailPage(makanan: item)),
          //       );
          //     }
          //   ),
          // );
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
                leading: const Icon(Icons.restaurant, color: Colors.black),
                title: Text(item.nama),
                subtitle: Text(
                    NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp ',
                        decimalDigits: 0
                    ).format(item.harga)
                ),
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
            Text(makanan.deskripsi, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center,),
            Text(
                NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: 'Rp ',
                    decimalDigits: 0
                ).format(makanan.harga)
            ),
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