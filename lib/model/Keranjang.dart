class Keranjang {
  int? id;
  int? userId;
  int? produkId;
  int? jumlah;

  Keranjang({this.id, this.userId, this.produkId, this.jumlah});

  factory Keranjang.fromJson(Map<String, dynamic> obj) {
    return Keranjang(
        id: obj['id'],
        userId: obj['user_id'],
        produkId: obj['produk_id'],
        jumlah: obj['jumlah']);
  }
}
