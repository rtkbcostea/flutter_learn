import 'package:flutter/material.dart';
import 'package:flutter_app/pages/products.dart';
import 'package:flutter_app/pages/product.dart';

class AuthPage extends StatefulWidget {

  @override
  State createState() {
    return _AuthPage();
  }
}


class _AuthPage extends State<AuthPage> {
  bool _acceptedTerms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/green.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.dstATop,
            ),
        ),
        ),
        padding: EdgeInsets.all(5.0),
        child:
        Center(child: SingleChildScrollView(
          child: Column(
          children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'E-mail', filled: true, fillColor: Theme.of(context).backgroundColor),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SwitchListTile(
            value: _acceptedTerms,
            onChanged: (bool value) {
              setState(() {
                _acceptedTerms = value;
              });
            }),
          RaisedButton(
            child: Icon(Icons.done) ,
            color: Theme.of(context).accentColor,
            onPressed: (){},
          ),
          ],
         ),)
          ,
         ),
         ),
      );
  }
}