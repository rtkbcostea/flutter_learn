import 'package:flutter_app/scoped-models/connected_prroducts.dart';
import 'package:flutter_app/scoped-models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with ConnectedProductsModel, ProductModel, UserModel{

}