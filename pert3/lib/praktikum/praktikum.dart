import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// #1 Model & entrypoint
class Tugas {
  String judul;
  bool selesai;
  Tugas(this.judul, {this.selesai = false});
}

class TugasModel extends ChangeNotifier {
  final List<Tugas> _items = [];

  // encapsulation (data hiding)
  List<Tugas> get items => List.unmodifiable(_items); // List.unmodifiable membungkus list supaya read-only | items = public getter, _items = private var/encapsulated state
  int get jumlahSelesai => _items.where((t) => t.selesai).length; // ini memory querying, dimana var jumlahSelesai menangkap hasil query list _items WHERE t (alias Tugas) itu .selesai, .length untuk mengambil semua data yang memenuhi kondisi selesai

  // fungsi buat nambah Judul Tugas
  void tambah(String judul) {
    _items.add(Tugas(judul));
    notifyListeners();
  }

  // fungsi buat ambil status centang tugas ke 'index' saat ini, balik nilainya (negasi), lalu simpan nilai baru ke status centang tugas
  void toggle(int index) {
    _items[index].selesai = !_items[index].selesai; // sisi kiri simpan hasil perhitungan sebelah kanan ke dlm properti selesai milik item pada posisi index. sisi kanan negasi untuk membalik nilai
    notifyListeners();
  }

  // fungsi hapus status centang tugas yang ada di index
  void hapus(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  // fungsi hapus semua tugas yang sudah selesai
  void hapusSelesai() {
    _items.removeWhere((t) => t.selesai);
    notifyListeners();
  }

}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TugasModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Tugas',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const TugasPage(),
    );
  }
}

// # 2 Halaman daftar
class TugasPage extends StatelessWidget {
  const TugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TugasModel>(); // ambil instans objek TugasModel dari provider dan disimpan di variable model

    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas (${model.jumlahSelesai}/${model.items.length})'), // ambil model yang udah ditandai selesai / model yang ada di provider
        actions: <Widget> [
          TextButton.icon(
            icon: const Icon(Icons.delete_sweep),
            label: const Text('Hapus Selesai', style: TextStyle(fontSize: 12),),
            onPressed: () => context.read<TugasModel>().hapusSelesai(),
          ),
        ],
      ),
      body: model.items.isEmpty // kalau data kosong bool tampilkan Text, kalau ada data tampilkan ListView
          ? const Center(
        child: Text(
          'Belum ada tugas', style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
      : ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, i) {
          final t = model.items[i]; // akses daftar kumpulan tugas di dalam TugasModel, ambil satu elemen spesifik urutan index ke i dst
          return ListTile(
            leading: Checkbox(
              value: t.selesai,
              onChanged: (_) => context.read<TugasModel>().toggle(i),
            ),
            title: Text(
              t.judul,
              style: TextStyle(
                decoration: t.selesai ? TextDecoration.lineThrough : null, // kalau tugas dinyatakan selesai ada garis horizontal coretan
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => context.read<TugasModel>().hapus(i),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TambahPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// # 3 Halaman tambah tugas (halaman terpisah tapi menggunakan model yang sama)
class TambahPage extends StatefulWidget {
  const TambahPage({super.key});

  @override
  State<TambahPage> createState() => _TambahPageState();
}

class _TambahPageState extends State<TambahPage> {
  final _controller = TextEditingController();
    final _formKey = GlobalKey<FormState>(); // FormState sebagai pengontrol bawaan untuk widget yang dipasangi key Form
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      final judul = _controller.text.trim();
      //if (judul.isEmpty) return;
      context.read<TugasModel>().tambah(judul);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tugas Ditambahkan!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: Form(
        key: _formKey, // dari FormState
        //padding: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Judul tugas',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().length < 3) ? 'Judul minimal 3 karakter' : null,
                // validator: (v) {
                //   if (v == null || v.trim().length < 3) return 'Judul minimal 3 karakter';
                //   return null;
                // },
                //onSubmitted: (_) => _simpan(),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: _simpan,
                  child: const Text('Simpan')
              ),
            ],
          ),
        ),
      ),
    );
  }
}