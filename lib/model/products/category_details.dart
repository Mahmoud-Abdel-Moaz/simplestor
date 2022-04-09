import 'product.dart';

class CategoryDetails {
    int? id;
    List<Product>? products;
    String? title;

    CategoryDetails({this.id, this.products, this.title});

    factory CategoryDetails.fromJson(Map<String, dynamic> json) {
        return CategoryDetails(
            id: json['id'], 
            products: json['products'] != null ? (json['products'] as List).map((i) => Product.fromJson(i)).toList() : null, 
            title: json['title'], 
        );
    }

}