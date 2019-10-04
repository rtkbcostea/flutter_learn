import 'package:flutter/material.dart';


class PriceTag extends StatelessWidget{
  final String _price;

  PriceTag(this._price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 5.0),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
          '\$$_price'
      ),
    );
  }
}
