import 'package:flutter_app/models/user.dart';
import 'connected_prroducts.dart';

class UserModel extends ConnectedProductsModel {

  void login(String email, String password) {
    authenticatedUser = User(
      id: 'asdfasdfasdfd',
      email:  email,
      password: password,
    );
  }
}
