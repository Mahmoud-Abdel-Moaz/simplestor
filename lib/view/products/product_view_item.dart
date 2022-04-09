import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/components/components.dart';

import '../../model/products/product.dart';
import '../../shared/const.dart';
import '../../shared/style/colors.dart';
import 'product_details_view.dart';

class ProductItemView extends StatelessWidget {

  final Product product;

   const ProductItemView(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateTo(context, ProductDetailsScreen(product));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.symmetric(horizontal:8.w,vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: const Offset(0, 0),
              blurRadius: 75.r,
            )
          ],
        ),
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              product.title!,
              style: openSans(16.sp, charcoal, FontWeight.w600),
              textScaleFactor: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
