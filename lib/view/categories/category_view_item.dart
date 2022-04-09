import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/products/category.dart';
import '../../shared/components/components.dart';
import '../../shared/const.dart';
import '../../shared/style/colors.dart';
import 'categories_view_controller.dart';
import 'category_products_view.dart';

class CategoryViewItem extends StatelessWidget {
  final ProductCategory category;

  const CategoryViewItem(this.category,{Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Provider.of<CategoriesProvider>(context,listen: false).getCategoryProducts(category.id!);
        navigateTo(context,const CategoryProductsScreen());
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
              category.title!,
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
