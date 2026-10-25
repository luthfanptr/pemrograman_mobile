import 'package:flutter/material.dart';
import 'package:pert2/tugas/tugas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Pert2',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.grey)),
      home: const MyContact(),
    );
  }
}

class Contact {
  final String nama;
  final int nomor;
  final String email;
  const Contact(this.nama, this.nomor, this.email);
}

const daftarKontak = [
  Contact('Aiman', 0812345, 'aiman@gmail.com'),
  Contact('Bambina', 0212345, 'bambi@gmail.com'),
  Contact('Cahyani', 081289034, 'cahyani@gmail.com'),
  Contact('Dendi', 0212310513, 'dendi@gmail.com'),
  Contact('Evan', 08581230, 'evan@gmail.com'),
  Contact('Fahmi', 0812381023, 'fahmi@gmail.com'),
];

class MyContact extends StatelessWidget {
  const MyContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kontak Saya')),
      body: ListView.builder(
        itemCount: daftarKontak.length,
        itemBuilder: (context, index) {
          final item = daftarKontak[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(item.nama),
              subtitle: Text(item.email),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailContact(contact: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailContact extends StatelessWidget {
  final Contact contact;
  const DetailContact({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(contact.nama)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.contacts, size: 50),
            const SizedBox(height: 16),
            Text(contact.nama, style: const TextStyle(fontSize: 25)),
            Text(contact.email, style: const TextStyle(fontSize: 15)),
            Text('0${contact.nomor}', style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
