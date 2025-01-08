import 'package:flutter/material.dart';
import 'package:tokokita/ui/produk/produk_form.dart';
import 'package:tokokita/ui/produk/produk_item.dart';
import '../../bloc/produk_bloc.dart';

class ProdukListPage extends StatefulWidget {
  const ProdukListPage({Key? key}) : super(key: key);

  @override
  _ProdukListPageState createState() => _ProdukListPageState();
}

class _ProdukListPageState extends State<ProdukListPage> {
  List? _originalList;
  List? _filteredList;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterList);
    _fetchProduks();
  }

  void _fetchProduks() async {
    try {
      List products = await ProdukBloc.getProduks();
      setState(() {
        _originalList = products;
        _filteredList = products;
      });
    } catch (e) {
      print(e);
    }
  }

  void _filterList() {
    List filtered = _originalList!.where((produk) {
      return produk.namaProduk
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
    }).toList();

    setState(() {
      _filteredList = filtered;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.amberAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          _filteredList == null
              ? const Center(child: CircularProgressIndicator())
              : ListProduk(list: _filteredList),
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
                          builder: (context) => const ProdukForm(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
      },
    );
  }
}
