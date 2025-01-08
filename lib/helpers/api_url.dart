class ApiUrl {
  // static const String baseUrl = 'http://10.0.2.2:8888/toko-api/public';
  // static const String baseUrl = 'http://192.168.1.15:8888/toko-api/public';
  static const String baseUrl = 'http://10.0.2.2:8888/toko-kita/public';

  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String produk = '$baseUrl/produk';
  static const String kategori = '$baseUrl/kategori';
  static const String keranjang = '$baseUrl/keranjang';

  static String updateProduk(int id) {
    return '$baseUrl/produk/$id';
  }

  static String showProduk(int id) {
    return '$baseUrl/produk/$id';
  }

  static String deleteProduk(int id) {
    return '$baseUrl/produk/$id';
  }

  static String updateKeranjang(int id) {
    return '$baseUrl/keranjang/$id';
  }

  static String showKeranjang(int id) {
    return '$baseUrl/keranjang/$id';
  }

  static String deleteKeranjang(int id) {
    return '$baseUrl/keranjang/$id';
  }
}
