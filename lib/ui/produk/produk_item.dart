import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk/produk_detail.dart';
import 'package:tokokita/bloc/keranjang_bloc.dart';
import 'package:tokokita/model/Keranjang.dart';
import 'package:tokokita/helpers/user_info.dart'; // Tambahkan import ini

class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(produk: produk),
          ),
        );
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  produk.namaProduk!,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  _addToCart(context);
                },
              ),
            ],
          ),
          subtitle: Text(
            "Rp. ${produk.hargaProduk}",
            style: const TextStyle(fontFamily: "Poppins"),
          ),
        ),
      ),
    );
  }

  void _addToCart(BuildContext context) async {
    // Mengambil user ID dari SharedPreferences
    int? userId = await UserInfo().getUserID();

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal menambahkan ${produk.namaProduk} ke keranjang: user tidak ditemukan."),
        ),
      );
      return;
    }

    // Membuat objek Keranjang baru
    Keranjang keranjang = Keranjang(
      userId: userId,
      produkId: produk.id,
      jumlah: 1,
    );

    // Memanggil metode addKeranjang dari keranjangBloc
    bool status = await KeranjangBloc.addKeranjang(keranjang: keranjang);

    // Menampilkan SnackBar berdasarkan status
    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${produk.namaProduk} ditambahkan ke keranjang"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal menambahkan ${produk.namaProduk} ke keranjang"),
        ),
      );
    }
  }
}
