import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {
  final String _address;
  AddressTag(this._address);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).accentColor),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5) ,
          child: Text(_address)
      ),
    );
  }
}