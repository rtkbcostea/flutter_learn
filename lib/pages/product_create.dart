import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {

  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State createState() {
    return _ProductCreatePage();
  }
}

class _ProductCreatePage extends State<ProductCreatePage> {
  String titleValue = '';
  String descrValue = '';
  double priceValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return
      Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Product Title'),
          onChanged: (String val){
          setState(() {
            titleValue = val;
          }); {}
        },),
        TextField(
          decoration: InputDecoration(labelText: 'Product Description'),
          maxLines: 5,
          onChanged: (String val){
          setState(() {
            descrValue = val;
          }); {}
        },),
        TextField(
          decoration: InputDecoration(labelText: 'Product Price'),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (String val){
          setState(() {
            priceValue = double.parse(val);
          }); {}
        },),
        FlatButton(
          child: Icon(Icons.done) ,
          color: Theme.of(context).accentColor,
          onPressed: () {
            final Map<String, dynamic> product = {
              'title': titleValue,
              'descr': descrValue,
              'price': priceValue,
              'image': 'assets/polar.jpg',
            };
            widget.addProduct(product);

            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    ),
    );
  }
}