class ProductCategory {
    int? id;
    String? title;

    ProductCategory({this.id, this.title});

    factory ProductCategory.fromJson(Map<String, dynamic> json) {
        return ProductCategory(
            id: json['id'], 
            title: json['title'], 
        );
    }


}