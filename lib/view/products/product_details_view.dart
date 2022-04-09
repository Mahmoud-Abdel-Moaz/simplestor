import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simplestor/view/cart/cart_view_controller.dart';

import '../../model/products/product.dart';
import '../../shared/const.dart';
import '../../shared/style/colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

   const ProductDetailsScreen(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity =1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white,        iconTheme:const IconThemeData(color: charcoal),

        title: Text(
          widget.product.title!,
          style: openSans(16.sp, Colors.black, FontWeight.bold),
        ),),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Name :",
                  style: openSans(16.sp, darkGunmetal, FontWeight.w600),
                ),
                SizedBox(width: 16.w,),
                Text(
                  widget.product.title!,
                  style: openSans(16.sp, charcoal, FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Price :",
                  style: openSans(16.sp, darkGunmetal, FontWeight.w600),
                ),
                SizedBox(width: 16.w,),
                Text(
                  widget.product.price!.toString(),
                  style: openSans(16.sp, charcoal, FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Stock :",
                  style: openSans(16.sp, darkGunmetal, FontWeight.w600),
                ),
                SizedBox(width: 16.w,),
                Text(
                  widget.product.stock!.toString(),
                  style: openSans(16.sp, charcoal, FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: ()=>setState(() {
                    quantity++;
                  }),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 4.h),
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.r,color: charcoal),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child:const Center(
                      child: Icon(Icons.add,color: darkGunmetal,),
                    ),
                  ),
                ),
                SizedBox(width: 8.w,),
                Text(
                  quantity.toString(),
                  style: openSans(16.sp, charcoal, FontWeight.w500),
                ),
                SizedBox(width: 8.w,),
                GestureDetector(
                  onTap: ()=>setState(() {
                    if(quantity!=1) {
                      quantity--;
                    }
                  }),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 4.h),
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.r,color: charcoal),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child:const Center(
                      child: Icon(Icons.minimize,color: darkGunmetal,),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                Provider.of<CartProvider>(context,listen: false).addToCart(widget.product, quantity);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:24.w,vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: darkGunmetal,
                ),
                child: Center(
                  child:  Text(
                    "Add to card",
                    style: openSans(16.sp, Colors.white, FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
