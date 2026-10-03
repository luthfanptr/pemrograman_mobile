import 'package:flutter/material.dart';

class Makanan {
  final String nama;
  final int harga;
  final String deskripsi;
  const Makanan(this.nama, this.harga, this.deskripsi);
}

const daftarMenu = [
  Makanan('Nasi Goreng', 15000, 'Nasi digoreng dengan bumbu spesial dan telur'),
  Makanan('Mie Ayam', 12000, 'Mie kenyal dengan potongan ayam kecap'),
  Makanan('Es Teh', 4000, 'Teh manis dingin menyegarkan'),
  Makanan('Ayam Bakar', 20000, 'Ayam bakar madu dengan sambal terasi'),
  Makanan('Sate Ayam', 18000, '10 tusuk sate ayam dengan bumbu kacang'),
  Makanan('Rendang Sapi', 25000, 'Daging sapi empuk bumbu rendang Padang'),
  Makanan('Jus Alpukat', 10000, 'Jus alpukat segar dengan susu kental manis'),
];

String formatRibuan(int angka) {
  String strAngka = angka.toString();
  String hasil = '';
  int hitung = 0;
  for (int i = strAngka.length - 1; i >= 0; i--) {
    hasil = strAngka[i] + hasil;
    hitung++;
    if (hitung % 3 == 0 && i != 0) {
      hasil = '.$hasil';
    }
  }
  return hasil;
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan Mandiri 2',
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Menu')),
      body: ListView.builder(
        itemCount: daftarMenu.length,
        itemBuilder: (context, index) {
          final item = daftarMenu[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.restaurant, color: Colors.green),
              title: Text(item.nama),
              subtitle: Text('Rp ${formatRibuan(item.harga)}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailPage(makanan: item)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Makanan makanan;

  const DetailPage({super.key, required this.makanan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(makanan.nama)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fastfood, size: 80, color: Colors.green),
              const SizedBox(height: 16),
              Text(makanan.nama, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Rp ${formatRibuan(makanan.harga)}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 16),
              Text(makanan.deskripsi, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}