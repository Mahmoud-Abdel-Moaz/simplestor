import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../model/products/category.dart';
import '../../model/products/category_details.dart';
import '../../model/products/product.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_point.dart';

class CategoriesProvider with ChangeNotifier{
  List<ProductCategory>? _categories;
  List<ProductCategory>? get categories=>_categories;

  CategoryDetails? _categoryDetails;
  CategoryDetails? get categoryDetails=>_categoryDetails;

  Future<void> getCategories()async{
    try{
      final response = await http.get(
        Uri.parse(baseUrl + CATEGORIES),
        headers: {'Content-Type': 'application/json','accept': '*/*','Authorization':token!},
      );
      log(response.body);
      if(response.statusCode == 200){
        _categories=(jsonDecode(response.body) as List).map((i) => ProductCategory.fromJson(i)).toList();
        notifyListeners();
      }
    }catch(e) {
      if (kDebugMode) {
        print("Error: " + e.toString());
      }
      rethrow;
    }
  }

  Future<void> getCategoryProducts(int categoryId)async{
    _categoryDetails=null;
    try{
      final response = await http.get(
        Uri.parse(baseUrl + CATEGORIES+'/$categoryId'),
        headers: {'Content-Type': 'application/json','accept': '*/*','Authorization':token!},
      );
      log(response.body);
      if(response.statusCode == 200){
        _categoryDetails=CategoryDetails.fromJson(jsonDecode(response.body));
        notifyListeners();
      }
    }catch(e) {
      if (kDebugMode) {
        print("Error: " + e.toString());
      }
      rethrow;
    }
  }
}