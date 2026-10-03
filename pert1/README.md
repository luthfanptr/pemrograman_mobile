# Catatan Pribadi

**Widget** di flutter fungsinya sebagai unit dasar pembangunan UI (blueprint)

### Widget Tree
- Root Node: Titik awal yang membungkus semua (MyApp)
```dart
void main() { // entrypoint app
  runApp (const MyApp()); // root widget
}
```
- Parent Node: Widget wadah yang nampung widget lain di dalamnya (Scaffold, Center, Column)
- Leaf Node: Widget ujung yang tidak punya child (text, icon)

### Karakteristik inti **widget** secara arsitektural:
- immutable (blueprint): seluruh properti di dalam widget sifatnya gabisa diubah setelah widget dibuat
- tersusun dalam widget tree: UI app tersusun secara bersarang, widget bersarang di dalam widget lain
- arsitektur tiga pohon: untuk kelola rendering lebih efisien
    - widget tree: lapisan awal
    - element tree: struktur perantara yang mengikat widget dengan objek render
    - renderObject tree: lapisan komputasi yang menghitung sizing, layout, dan pixel ke layar via engine rendering

