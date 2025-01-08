class User {
  int? id;
  String? nama;
  String? email;
  String? userId;

  User({this.userId, this.id, this.nama, this.email});
    factory User.fromJson(Map<String, dynamic>obj) {
      return User(
        userId : obj['data']['keranjang']['user_id'],
        id: obj['id'],
        nama: obj['nama'],
        email: obj['email']
      );
  }
}