import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model{
  final String id;
  final String email;
  final String password;

  User({@required this.id, @required this.password, @required this.email});
}