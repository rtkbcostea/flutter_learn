import 'package:flutter/material.dart';
import 'package:flutter_app/pages/products_admin.dart';

class ProductMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('choose'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            title: Text('managed products'),
            leading: Icon(Icons.shop),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}