import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/cart.dart';
import '../../shared/const.dart';
import '../../shared/style/colors.dart';
import '../products/custom_drawer.dart';
import 'cart_item_view.dart';
import 'cart_view_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider _cartProvider=Provider.of<CartProvider>(context);
    List<CartItem>? _cart=_cartProvider.cart;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Colors.white,        iconTheme:const IconThemeData(color: charcoal),

        centerTitle: true,
        title: Text(
          'Cart',
          style: openSans(18.sp, Colors.black, FontWeight.bold),
        ),),
      body:ConditionalBuilder(
        condition: _cart.isNotEmpty,
        fallback: (context) =>Center(child:Text(
          'There is no products add some',
          style: openSans(18.sp, darkGunmetal, FontWeight.bold),
        )),
        builder: (context) =>SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 16.h,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) =>
                    CartItemView(_cart[index]),
                separatorBuilder: (context, index) => SizedBox(
                  height: 16.h,
                ),
                itemCount: _cart.length,
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
      drawer:const CustomDrawer(),
    );
  }
}
