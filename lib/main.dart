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
    final MainModel model =  MainModel();
    return
      ScopedModel<MainModel>(
          model: model,
          child:  _buildMaterialApp(model))
     ;
  }

  MaterialApp _buildMaterialApp(MainModel model) {
    return  MaterialApp(
      theme:_buildTheme(),
      routes: {
        '/': (BuildContext ctx) => AuthPage(),
        '/products':  (BuildContext context) => ProductsPage(model),
        'admin': (BuildContext context) => ProductsAdminPage(model),
      },
      onGenerateRoute: _buildDynamicRoute,
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext c) =>
            ProductsPage(model),
        );
      },
    );
  }

  Route _buildDynamicRoute(RouteSettings settings, MainModel model) {
      final List<String> pathElements = settings.name.split('/');
      if (pathElements[0] != '') {
        return null;
      }
      if (pathElements[1] == 'product') {
        final String pId=pathElements[2];
        model.selectProduct(pId);
        return MaterialPageRoute<bool>(
            builder: (BuildContext c) => ProductPage()
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
