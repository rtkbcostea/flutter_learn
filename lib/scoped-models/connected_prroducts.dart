import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedProductsModel extends Model {
  final List<Product> _allproducts = [];
  User authenticatedUser;
  int _selectedProductIndex;

  void addNewProduct(
      String title, String description, String image, double price) {
    final Product p = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      isFavourite: false,
      userId: authenticatedUser.id,
      userEmail: authenticatedUser.email,
    );
    _allproducts.add(p);

    notifyListeners();
  }
}

class ProductModel extends ConnectedProductsModel {
  bool _showFavs = false;

  //*******************************
  //List ops
  //*******************************
  List<Product> get products {
    return List.from(_allproducts);
  }

  List<Product> get displayedProducts {
    if (_showFavs) {
      return _allproducts.where((Product p) => p.isFavourite).toList();
    }
    return List.from(_allproducts);
  }

  void selectProduct(int idx) {
    _selectedProductIndex = idx;
  }

  int getSelectedIndex() {
    return _selectedProductIndex;
  }

  Product getSelectedProduct() {
    return _selectedProductIndex == null
        ? null
        : products[_selectedProductIndex];
  }

  //*******************************
  //CRUD
  //*******************************
  void removeProduct(int index) {
    _allproducts.removeAt(index);
  }

  void updateProduct(Product aProduct) {
    _allproducts[_selectedProductIndex] = aProduct;
  }

  void upsert(Product aProduct) {
    if (getSelectedProduct() == null) {
      addNewProduct(aProduct.title, aProduct.description, aProduct.image, aProduct.price);
    } else {
      updateProduct(aProduct);
    }
  }

  //*******************************
  //Favourites
  //*******************************
  bool get showOnlyFavs{
    return _showFavs;
  }

  void toggleDisplayFavs() {
    _showFavs = !_showFavs;
    notifyListeners();
  }

  void toggleProductFavouriteStatus() {
    bool isCurrentlyFavourite = _allproducts[_selectedProductIndex].isFavourite;
    isCurrentlyFavourite = isCurrentlyFavourite ?? false;
    print(isCurrentlyFavourite);
    final bool newFavouriteStatus = !isCurrentlyFavourite;

    Product updatedProd =
        Product.fromProduct(getSelectedProduct(), newFavouriteStatus);
    updateProduct(updatedProd);
    notifyListeners();
  }
}

