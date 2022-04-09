import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../model/products/product.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_point.dart';


class ProductsProvider with ChangeNotifier{
  List<Product>? _products;
  List<Product>? get products=>_products;

  Future<void> getProducts()async{
    try{
      final response = await http.get(
        Uri.parse(baseUrl + PRODUCTS),
        headers: {'Content-Type': 'application/json','accept': '*/*','Authorization':token!},
      );
      log(response.body);
      if(response.statusCode == 200){
        _products=(jsonDecode(response.body) as List).map((i) => Product.fromJson(i)).toList();
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