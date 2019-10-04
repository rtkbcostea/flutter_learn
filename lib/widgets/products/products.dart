import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/products/price_tag.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  Products(this.products) ;

  Widget _buildProductItem(BuildContext context, int index) {
    String title = products[index]['title'];
    String image = products[index]['image'];

    return Card(
        child: Column(
          children: <Widget> [
            Image.asset(image),
            Container(
              padding: EdgeInsets.only(top: 1.5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Text(products[index]['title'],
                  style: TextStyle(
                    fontSize: 26.6,
                    fontWeight: FontWeight.bold,
                )),
                  SizedBox(width: 8.0),
                  PriceTag((products[index]['price']).toString()),
              ]),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5) ,
                  child: Text('Somewhere, Someplace')
                  ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () =>
                      Navigator.pushNamed<bool>(context, '/product/'+index.toString())
                ),
                IconButton(
                    icon: Icon(Icons.favorite_border),
                    color: Colors.red,
                    onPressed: () {}
                ),
              ],),
          ],),
      );
    }

  Widget build(BuildContext context) {
    if (products.length > 0) {
      return ListView.builder(
          itemBuilder: _buildProductItem,
          itemCount: products.length,
        );
    } else {
       return Center(child: Text('No items'),);
    }
  }
}