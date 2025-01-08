import 'package:flutter/material.dart';
import 'package:tokokita/bloc/keranjang_bloc.dart';
import 'package:tokokita/model/keranjang.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text("Keranjang"),
      ),
    );
  }
}

class ListKeranjang extends StatelessWidget {
  final List<Keranjang>? list;

  const ListKeranjang({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, index) {
        var keranjang = list![index];
        return Card(
          elevation: 3,
          color: Colors.white,
          child: ListTile(
            title: Text('Produk ID: ${keranjang.produkId}'),
            subtitle: Text('Jumlah: ${keranjang.jumlah}'),
          ),
        );
      },
    );
  }
}
