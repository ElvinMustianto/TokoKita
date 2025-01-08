import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk/produk_list.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  const ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();
  final _deskripsiProdukTextboxController = TextEditingController();
  final _jumlahProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
        _deskripsiProdukTextboxController.text = widget.produk!.deskripsi ?? '';
        _jumlahProdukTextboxController.text = widget.produk!.stok.toString();
        // Assign kategori dan user ID sesuai kebutuhan
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: "Poppins"
          ),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _kodeProdukTextField(),
                    _namaProdukTextField(),
                    _hargaProdukTextField(),
                    _deskripsiProdukTextField(),
                    _jumlahProdukTextField(),
                    // Tambahkan form field untuk kategori dan user ID di sini jika diperlukan
                    const SizedBox(height: 10),
                    _buttonSubmit(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Produk"),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _deskripsiProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deskripsi"),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: _deskripsiProdukTextboxController,
      validator: (value) {
        // Validasi opsional, bisa disesuaikan sesuai kebutuhan
        return null;
      },
    );
  }

  Widget _jumlahProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jumlah"),
      keyboardType: TextInputType.number,
      controller: _jumlahProdukTextboxController,
      validator: (value) {
        // Validasi opsional, bisa disesuaikan sesuai kebutuhan
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.produk != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });

    Produk createProduk = Produk(id: null);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    createProduk.deskripsi = _deskripsiProdukTextboxController.text;
    createProduk.stok = int.parse(_jumlahProdukTextboxController.text);
    // Assign kategori dan user ID sesuai kebutuhan

    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const ProdukListPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
        const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });

    setState(() {
      _isLoading = false;
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });

    Produk updateProduk = Produk(id: widget.produk!.id);
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    updateProduk.deskripsi = _deskripsiProdukTextboxController.text;
    updateProduk.stok  = int.parse(_jumlahProdukTextboxController.text);
    // Assign kategori dan user ID sesuai kebutuhan

    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      setState(() {
        _isLoading = false;
      });
      if (value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukListPage(),
        ));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
          const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ),
        );
      }
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) =>
        const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
  }
}
