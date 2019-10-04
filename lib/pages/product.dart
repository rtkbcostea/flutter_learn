import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String image;

  ProductPage(this.title, this.image);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure'),
        content: Text('cant undoe!'),
        actions: <Widget>[
          FlatButton(child: Text('CANCEL'),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(child: Text('DELETE'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(child:
        Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(image),
              Text(title),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('delete'),
                onPressed: () => _showWarningDialog(context)
              ),
            ]),
        ),
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        });
  }
}
