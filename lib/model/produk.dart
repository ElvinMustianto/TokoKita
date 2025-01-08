class Produk {
  int? id;
  String? kodeProduk;
  String? namaProduk;
  String? deskripsi;
  int? hargaProduk;
  int? stok;


  Produk({
    this.id,
    this.kodeProduk,
    this.namaProduk,
    this.deskripsi,
    this.hargaProduk,
    this.stok,
  });

  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
      id: obj['id'],
      kodeProduk: obj['kode_produk'],
      namaProduk: obj['nama'],
      deskripsi: obj['deskripsi'],
      hargaProduk: obj['harga'],
      stok: obj['stok'],
    );
  }
}
