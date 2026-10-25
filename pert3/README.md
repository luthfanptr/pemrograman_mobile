# Catatan

### # setState()
Fungsi ***setState()*** digunakan buat ubah state dari widget tanpa framework harus menggambar ulang. ***State*** adalah "data atau kondisi" yang bisa berubah ubah selama aplikasi berjalan, dan perubahan itu memengaruhi tampilan di layar.

- State merupakan bagian dari StatefulWidget karena sifat tampilannya dinamis/punya memori. Widget ini bisa mengingat data saat ini dan bisa menggambar ulang layarnya jika data tersebut berubah (menggunakan setState()).

```dart
class FormPage extends StatefulWidget {...} // kerangka luar

class _FormPageState extends State<FormPage> {...} // Otak & memorinya (state)
```
Di dalam class _FormPageState:
- Tempat menyimpan variabel yang bisa berubah
- Memiliki siklus hidup:
    - ***initState()***: Dijalankan hanya satu kali saja saat halaman pertama kali dibuka.
    - ***build()***: Tempat menggambar UI (bisa dipanggil berkali-kali).
    - ***dispose()***: Dijalankan saat halaman ditutup/dihancurkan untuk bersih-bersih memori.

### # context.watch<T>()
Berfungsi untuk mengambil instans objek (Lookup) dari 'T' terdekat. Membaca dan membangun ulang saat data berubah. Dalam contoh konteks ***main3.dart*** yaitu
```dart
final model = context.watch<TugasModel>();
```
Mengambil instans objek ***TugasModel*** terdekat yang disediakan oleh ***ChangeNotifierProvider***. Instans tersebut kemudian disimpan ke dalam variabel ***model***.

### # context.read<T>()
Berfungsi untuk membaca data tanpa membangun ulang