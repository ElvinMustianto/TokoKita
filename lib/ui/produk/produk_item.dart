import 'package:flutter/material.dart';
import 'package:tokokita/ui/produk/produk_detail.dart';

import '../../model/produk.dart';

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
                builder: (context) => ProdukDetail(produk: produk)));
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: ListTile(
          title: Text(
            produk.namaProduk!,
            style: const TextStyle(
                fontFamily: "Poppins", fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "Rp. ${produk.hargaProduk!}",
            style: const TextStyle(fontFamily: "Poppins"),
          ),
        ),
      ),
    );
  }
}