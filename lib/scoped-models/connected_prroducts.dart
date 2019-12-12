import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ConnectedProductsModel extends Model {
  final apiUrl = 'https://text-s3s2.firebaseio.com';

  List<Product> allProducts = [];
  User authenticatedUser;
  String _selectedProdId;
  bool _isLoading = false;

  Future<Null> addNewProduct(
      String title, String description, String image, double price) {
    Map<String, dynamic> prodData = productToMap(title, description, price);

    _isLoading = true;
    notifyListeners();
    return http
        .post('$apiUrl/products.json', body: json.encode(prodData))
        .then((http.Response resp) {
      final Map<String, dynamic> respData = json.decode(resp.body);
      _isLoading = false;
      final Product p = Product(
        id: respData['name'],
        title: title,
        description: description,
        image: image,
        price: price,
        isFavourite: false,
        userId: authenticatedUser.id,
        userEmail: authenticatedUser.email,
      );
      allProducts.add(p);

      notifyListeners();
    });
  }

  Map<String, dynamic> productToMap(
      String title, String description, double price) {
    final Map<String, dynamic> prodData = {
      'title': title,
      'description': description,
      'image':
          'https://www.bestglycol.com/wp-content/uploads/2015/07/Double-Chocolate-clear.jpg',
      'price': price,
      'userEmail': authenticatedUser.email,
      'userId': authenticatedUser.id,
    };

    return prodData;
  }
}

class ProductModel extends ConnectedProductsModel {
  bool _showFavs = false;

  //*******************************
  //List ops
  //*******************************
  List<Product> get products {
    return List.from(allProducts);
  }

  List<Product> get displayedProducts {
    if (_showFavs) {
      return allProducts.where((Product p) => p.isFavourite).toList();
    }
    return List.from(allProducts);
  }

  void selectProduct(String pId) {
    _selectedProdId = pId;
  }

  String getSelectedProdId() {
    return _selectedProdId;
  }

  Product getSelectedProduct() {
    return _selectedProdId == null || products == null
        ? null
        : products.singleWhere((Product p) => _selectedProdId == p.id);
  }

  //*******************************
  //CRUD
  //*******************************
  Future<Null> removeProduct() {
    final String id = getSelectedProduct().id;

    final int idx = products.indexWhere((Product p) {
      return p.id == id;
    });

    allProducts.removeAt(idx);
    return execWithLoadIndicator((Function after) {
      return http
          .delete('$apiUrl/products/$id.json')
          .then((http.Response resp) {
            _selectedProdId = null;
        after();
      });
    });
  }

  Future<Null> execWithLoadIndicator(Function f) {
    _isLoading = true;
    notifyListeners();

    return f(() {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> updateProduct(Product aProduct) {
    final prodData =
        productToMap(aProduct.title, aProduct.description, aProduct.price);
    aProduct.id = getSelectedProduct().id;

    return http
        .put('$apiUrl/products/${aProduct.id}.json',
            body: json.encode(prodData))
        .then((http.Response resp) {

      _isLoading = false;
      notifyListeners();

      final int idx =  products.indexWhere((Product p) => _selectedProdId == p.id);
      products[idx]=aProduct;
    });
  }

  Future<Null> upsert(Product aProduct) {
    if (getSelectedProduct() == null) {
      return addNewProduct(
          aProduct.title, aProduct.description, aProduct.image, aProduct.price);
    } else {
      return updateProduct(aProduct);
    }
  }

  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    return http.get('$apiUrl/products.json').then((http.Response resp) {
      final Map<String, dynamic> listData = json.decode(resp.body);
      final List<Product> fetchedProdList = [];

      if (listData != null) {
        listData.forEach((String prodId, dynamic data) {
          final Product p = Product(
            id: prodId,
            title: data['title'],
            description: data['description'],
            image: data['image'],
            price: data['price'],
            isFavourite: false,
            userId: data['userId'],
            userEmail: data['userEmail'],
          );
          fetchedProdList.add(p);
        });
        allProducts = fetchedProdList;
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  //*******************************
  //Favourites
  //*******************************
  bool get showOnlyFavs {
    return _showFavs;
  }

  void toggleDisplayFavs() {
    _showFavs = !_showFavs;
    notifyListeners();
  }

  void toggleProductFavouriteStatus() {
    bool isCurrentlyFavourite = getSelectedProduct().isFavourite;
    isCurrentlyFavourite = isCurrentlyFavourite ?? false;
    print(isCurrentlyFavourite);
    final bool newFavouriteStatus = !isCurrentlyFavourite;

    Product updatedProd =
        Product.fromProduct(getSelectedProduct(), newFavouriteStatus);
    updateProduct(updatedProd);
    notifyListeners();
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
