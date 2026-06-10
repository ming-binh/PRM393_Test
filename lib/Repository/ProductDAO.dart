import '../Entities/Product.dart';

class Productdao {
  static List<Product> getAllProducts() {
    return [
      Product(
        id: "P01",
        name: "Samsung",
        price: 40.0,
        discountPercent: 10,
        starNumber: 4.5,
        image: "assets/images/samsung.jpg",
      ),
      Product(
        id: "P02",
        name: "Apple",
        price: 40.0,
        discountPercent: 5,
        starNumber: 4.8,
        image: "assets/images/apple.jpg",
      ),
      Product(
        id: "P03",
        name: "Xiaomi",
        price: 40.0,
        discountPercent: 15,
        starNumber: 4.2,
        image: "assets/images/xiaomi.jpg",
      ),
    ];
  }

  static List<Product> findProductByName(String keyword) {
    List<Product> allProducts = getAllProducts();

    return allProducts.where((product) {
      return product.name.toLowerCase().contains(keyword.toLowerCase());
    }).toList();
  }
}