import 'package:flutter/material.dart';
import 'package:tokokita/ui/produk/produk_form.dart';
import 'package:tokokita/ui/produk/produk_item.dart';

import '../../bloc/produk_bloc.dart';

class ProdukListPage extends StatelessWidget {
  const ProdukListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FutureBuilder<List>(
          future: ProdukBloc.getProduks(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListProduk(
              list: snapshot.data,
            )
                : const Center(
              child: CircularProgressIndicator(),
            );
          }),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [Colors.redAccent, Colors.amberAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: GestureDetector(
                child: const Icon(
                  Icons.add,
                  size: 26.0,
                  color: Colors.black,
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProdukForm()));
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class ListProduk extends StatelessWidget {
  final List? list;

  const ListProduk({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemProduk(produk: list![i]);
        });
  }
}
