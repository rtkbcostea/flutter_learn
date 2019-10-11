import 'package:flutter/material.dart';
import 'package:flutter_app/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthPage extends StatefulWidget {
  @override
  State createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> {
  final Map<String, dynamic> _formaData = {'acceptedTerms': false};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        deviceWidth < 380.0 ? deviceWidth - 20 : deviceWidth * 0.7;

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
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              height:500.0,
              width: targetWidth,
              child: _buildForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext ctx, Widget child, MainModel model) {
      return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 5),
            children: <Widget>[
              _buildTextField('e-mail', (String val) {
                _formaData['e-mail'] = val;
              }),
              _buildTextField('password', (String val) {
                _formaData['password'] = val;
              }, true),
              SwitchListTile(
                  value: _formaData['acceptedTerms'],
                  onChanged: (bool value) {
                    setState(() {
                      _formaData['acceptedTerms'] = value;
                    });
                  }),
              RaisedButton(
                child: Icon(Icons.done),
                onPressed: () => _doLogIn(model),
              ),
            ],
          ));
    });
  }

  _doLogIn(MainModel model) {
    _formKey.currentState.validate() ;
    _formKey.currentState.save();
    model.login(_formaData['e-mail'], _formaData['password']);

    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildTextField(String caption, Function onValue,
      [bool isObscured = false]) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: caption,
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
        ),
        validator: (String val) {
          if (val.trim().length == 0) {
            return "$caption is required!";
          }
          return "";
        },
        obscureText: isObscured,
        onChanged: (String val) {
          setState(() {
            onValue(val);
          });
        });
  }
}
