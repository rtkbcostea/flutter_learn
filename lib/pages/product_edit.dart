import 'package:flutter/material.dart';
import 'package:flutter_app/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/models/product.dart';

class ProductEditPage extends StatefulWidget {
  ProductEditPage();

  @override
  State createState() {
    return _ProductEditPage();
  }
}

class _ProductEditPage extends State<ProductEditPage> {
  final Product _formData = Product(
      title: null, description: null, price: null, 
      userEmail: '', userId: '',
      image: 'assets/polar.jpg', isFavourite: false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 750.0 ? 700 : deviceWidth * 0.5;
    final double targetPadding = deviceWidth - targetWidth;
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext ctx, Widget child, MainModel model) {
      Widget content = _buildPageContent(targetPadding, targetWidth, model);

      if (model.getSelectedIndex() == null) {
        return content;
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Product'),
          ),
          body: content,
        );
      }
    });
  }

  Widget _buildSubmitButton(MainModel model) {
    return RaisedButton(
      child: Icon(Icons.done),
      onPressed: () => _onSubmitProduct(model),
    );
  }

  Widget _buildPageContent(
      double targetPadding, double targetWidth, MainModel model) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: targetWidth,
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 8),
            children: <Widget>[
              _buildTextField('Product Title', (String val) {
                _formData.title = val;
              }, () {
                Product p = model.getSelectedProduct();
                return  p == null ? "" : p.title;
              }),
              _buildTextField('Product Description', (String val) {
                _formData.description = val;
              }, () {
                Product p = model.getSelectedProduct();
                return  p == null ? "" : p.description;
              }),
              _buildTextField('Product Price', (String val) {
                _formData.price = double.parse(val);
              },  () {
                Product p = model.getSelectedProduct();
                return  p == null ? "" : p.price.toString();
              }, true),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(model),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String caption, Function setter, Function getter,
      [bool useNumeric = false]) {
    TextInputType keyboardTYpe = TextInputType.text;
    if (useNumeric) {
      keyboardTYpe = TextInputType.numberWithOptions(decimal: true);
    }

    return TextFormField(
        decoration: InputDecoration(labelText: caption),
        initialValue: getter(),
        keyboardType: keyboardTYpe,
        validator: (String val) {
          if (val.trim().length == 0) {
            return "$caption is required!";
          }
          if (useNumeric &&
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(val)) {
            return "$caption needs to be a number!";
          }
          return "";
        },
        onSaved: (String val) {
          setter(val);
        });
  }

  void _onSubmitProduct(MainModel model) {
    _formKey.currentState.validate();
    _formKey.currentState.save();

    model.upsert(_formData);

    Navigator.pushReplacementNamed(context, '/products').then((_) => model.selectProduct(null));
  }
}
