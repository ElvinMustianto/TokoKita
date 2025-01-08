import 'dart:convert';

import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/model/Keranjang.dart';

import '../helpers/api_url.dart';

class KeranjangBloc {
  static Future<List<Keranjang>> getKeranjang() async {
    String apiUrl = ApiUrl.keranjang;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listKeranjang = (jsonObj as Map<String, dynamic>)['data'];
    List<Keranjang> keranjangs = [];
    for (int i = 0; i < listKeranjang.length; i++) {
      keranjangs.add(Keranjang.fromJson(listKeranjang[i]));
    }
    return keranjangs;
  }

  static Future addKeranjang({Keranjang? keranjang}) async {
    String apiUrl = ApiUrl.keranjang;
    var body = {
      "user_id" : keranjang!.userId,
      "produk_id" : keranjang.produkId,
      "jumlah" : keranjang.jumlah
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response);
    return jsonObj['status'];
  }

  static Future<bool> updateKeranjang({required Keranjang keranjang}) async {
    String apiUrl = ApiUrl.updateKeranjang(keranjang.id!);
    var body = {
      "user_id" : keranjang!.userId,
      "produk_id" : keranjang.produkId,
      "jumlah" : keranjang.jumlah
    };

    try {
      var response = await Api().put(apiUrl, body);
      var jsonObj = json.decode(response);
      return jsonObj['status']; // Pastikan ini sesuai dengan respons API Anda
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> deleteKeranjang({int? id}) async {
    String apiUrl = ApiUrl.deleteKeranjang(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
