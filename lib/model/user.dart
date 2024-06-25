class User {
  int? id;
  String? nama;
  String? email;
  String? password;

  User({this.id, this.nama, this.email, this.password});
  factory User.fromJson(Map<String,dynamic>obj) {
    return User(
      id: obj['id'],
      nama: obj['nama'],
      email: obj['email']
    );
  }
}
