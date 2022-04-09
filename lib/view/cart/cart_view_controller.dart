import 'package:flutter/material.dart';

import '../../model/cart.dart';
import '../../model/products/product.dart';


class CartProvider with ChangeNotifier{
  List<CartItem> _cart=[];
  List<CartItem> get cart=> _cart;


  addToCart(Product product,int quantity){
    int index=_cart.indexWhere((element) => element.product!.id==product.id);
        if(index>=0){
          CartItem item=_cart[index];
          int q=item.quantity!+quantity;
          _cart[index]=CartItem(product,q);
        }else{
          _cart.add(CartItem(product,quantity));
        }
        notifyListeners();
  }
  removeFromCart(int productId){
    _cart.removeWhere((element) => element.product!.id==productId);
    notifyListeners();
  }
  updateCart(int quantity,int id){
    int index=_cart.indexWhere((element) => element.product!.id==id);
      if(quantity==0){
        _cart.removeAt(index);
      }else{
        CartItem item=_cart[index];
        int q=item.quantity!+quantity;
        _cart[index]=CartItem(item.product,q);
      }
      notifyListeners();
  }
}