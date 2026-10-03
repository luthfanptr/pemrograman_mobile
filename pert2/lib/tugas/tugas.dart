import 'package:flutter/material.dart';

class Kontak {
  final String nama;
  final String telepon;
  final String email;

  const Kontak(this.nama, this.telepon, this.email);
}

const daftarKontak = [
  Kontak('Ahmad Suseno', '081234567890', 'ahmad@email.com'),
  Kontak('Bunga Citra', '082345678901', 'bunga@email.com'),
  Kontak('Chantika', '083456789012', 'chantika@email.com'),
  Kontak('Dian Sastro', '084567890123', 'dian@email.com'),
  Kontak('Eko Gandoz', '085678901234', 'eko@email.com'),
  Kontak('Fajar M', '086789012345', 'fajar@email.com'),
];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Praktikum 2',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: const KontakPage(),
    );
  }
}

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Kontak')),
      body: ListView.builder(
        itemCount: daftarKontak.length,
        itemBuilder: (context, index) {
          final kontak = daftarKontak[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(kontak.nama[0].toUpperCase()),
              ),
              title: Text(kontak.nama),
              subtitle: Text(kontak.telepon),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailKontakPage(kontak: kontak)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailKontakPage extends StatelessWidget {
  final Kontak kontak;

  const DetailKontakPage({super.key, required this.kontak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kontak.nama)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(kontak.nama[0].toUpperCase(), style: const TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 24, width: double.infinity),
            Text(kontak.nama, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: Text(kontak.telepon),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.email),
                title: Text(kontak.email),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}