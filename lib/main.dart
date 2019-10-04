import 'package:flutter/material.dart';
import 'package:flutter_app/pages/product.dart';
import 'package:flutter_app/pages/products.dart';
import 'package:flutter_app/pages/products_admin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _MyAppState([]);
 }}

 class _MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> _products;

  _MyAppState(this._products);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      routes: {
        '/':  (BuildContext context) => ProductsPage(_products),
        'admin': (BuildContext context) => ProductsAdminPage(_addProduct, _removeProduct),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index =int.parse(pathElements[2]);

          return MaterialPageRoute<bool>(
            builder: (BuildContext c) => ProductPage(
                _products[index]['title'],
                _products[index]['image'])
          );
        }
        
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext c) =>
            ProductsPage(_products),
        );
      },
    );
  }

  void _removeProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _addProduct(Map<String, dynamic> aProduct) {
    setState(() {
      _products.add(aProduct);
    });
  }
}
