import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk/produk_form.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/ui/produk/produk_list.dart';

import '../../bloc/produk_bloc.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Produk",
          style: TextStyle(color: Colors.black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.amberAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem("Kode", widget.produk!.kodeProduk.toString()),
            _buildDetailItem("Nama", widget.produk!.namaProduk.toString()),
            _buildDetailItem("Deskripsi", widget.produk!.deskripsi.toString()),
            _buildDetailItem(
                "Harga", "Rp. ${widget.produk!.hargaProduk.toString()}"),
            _buildDetailItem("Jumlah", widget.produk!.stok.toString()),
            SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(produk: widget.produk!),
              ),
            );
          },
          icon: Icon(Icons.edit),
          label: Text("Edit"),
        ),
        SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () => confirmHapus(),
          icon: Icon(Icons.delete),
          label: Text("Delete"),
        ),
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const ProdukListPage())); // Kembali ke halaman sebelumnya
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
