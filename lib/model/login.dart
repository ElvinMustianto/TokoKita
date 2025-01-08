class Login {
  int? code;
  bool? status;
  String? username;
  String? email;
  String? token;
  String? userID;
  String? userEmail;

  Login(
      {this.code,
      this.status,
      this.username,
      this.email,
      this.token,
      this.userID,
      this.userEmail});

  factory Login.fromJson(Map<String, dynamic> obj) {
    return Login(
        code: obj['code'],
        status: obj['status'],
        token: obj['data']['token'],
        username: obj['data']['user']['nama'],
        email: obj['data']['user']['email'],
        userID: obj['data']['user']['id'],
        userEmail: obj['data']['user']['email']);
  }
}
