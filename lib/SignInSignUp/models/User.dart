class User{
  int id;
  String email;
  String pasword;
  User(this.email,this.pasword);
  Map<String,dynamic>toUserMap(){
    return {
     'email':email,
      'password':pasword,
    };
  }

  static  fromMap(Map<String, dynamic> c) {

    return User(c['email'],c['password']);


  }

}