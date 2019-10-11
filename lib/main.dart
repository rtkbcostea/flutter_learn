import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth.dart';
import 'package:flutter_app/pages/product.dart';
import 'package:flutter_app/pages/products.dart';
import 'package:flutter_app/pages/products_admin.dart';
import 'package:flutter_app/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
 }}

 class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return
      ScopedModel<MainModel>(
          model: MainModel(),
          child:  _buildMaterialApp())
     ;
  }

  MaterialApp _buildMaterialApp() {
    return  MaterialApp(
      theme:_buildTheme(),
      routes: {
        '/': (BuildContext ctx) => AuthPage(),
        '/products':  (BuildContext context) => ProductsPage(),
        'admin': (BuildContext context) => ProductsAdminPage(),
      },
      onGenerateRoute: _buildDynamicRoute,
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext c) =>
            ProductsPage(),
        );
      },
    );
  }

  Route _buildDynamicRoute(RouteSettings settings) {
      final List<String> pathElements = settings.name.split('/');
      if (pathElements[0] != '') {
        return null;
      }
      if (pathElements[1] == 'product') {
        final int index =int.parse(pathElements[2]);

        return MaterialPageRoute<bool>(
            builder: (BuildContext c) => ProductPage(index)
        );
      }

      return null;
    }

  ThemeData _buildTheme() {
    return  ThemeData(
      primarySwatch: Colors.red,
      appBarTheme: AppBarTheme(color: Colors.deepOrange),
      accentColor: Colors.deepOrange,
      brightness: Brightness.dark,
      buttonColor: Colors.teal,
    );
  }

}
