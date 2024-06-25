import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk/produk_form.dart';

import '../../helpers/api_url.dart';

class ProdukDetail extends StatefulWidget {
  Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _produkDetailState createState() => _produkDetailState();
}

class _produkDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Produk",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700, fontFamily: "Poppins"),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.amberAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft
              )
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.produk!.kodeProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 20.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProdukForm(
                            produk: widget.produk!,
                          )));
            },
            child: const Text("Edit")),
        OutlinedButton(
            onPressed: () => confirmHapus(), child: const Text("Delete"))
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin Data ini akan dihapus"),
      actions: [
        OutlinedButton(
          onPressed: () async {
            bool success = await hapusData(widget.produk!.id as int);
            if (success) {
              Navigator.pop(context);
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            } else {
              // Tampilkan pesan error jika gagal menghapus
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Gagal menghapus data")),
              );
            }
          },
          child: const Text("Ya"),
        ),
        OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tidak")),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}

Future<bool> hapusData(int id) async {
  final response = await delete(Uri.parse(ApiUrl.deleteProduk(id)));
  return response.statusCode == 200;
}
