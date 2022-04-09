import 'category.dart';

class Product {
    bool? active;
    List<ProductCategory>? categories;
    int? id;
    dynamic price;
    int? stock;
    String? title;

    Product({this.active, this.categories, this.id, this.price, this.stock, this.title});

    factory Product.fromJson(Map<String, dynamic> json) {
        return Product(
            active: json['active'], 
            categories: json['categories'] != null ? (json['categories'] as List).map((i) => ProductCategory.fromJson(i)).toList() : null,
            id: json['id'], 
            price: json['price'], 
            stock: json['stock'], 
            title: json['title'], 
        );
    }
}