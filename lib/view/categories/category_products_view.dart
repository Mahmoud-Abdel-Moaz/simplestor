import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/products/category_details.dart';
import '../../shared/const.dart';
import '../../shared/style/colors.dart';
import '../products/product_view_item.dart';
import 'categories_view_controller.dart';


class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({Key? key}) : super(key: key);

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    CategoriesProvider _categoriesProvider =Provider.of<CategoriesProvider>(context);
    CategoryDetails? _categoryDetails = _categoriesProvider.categoryDetails;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Colors.white,
        centerTitle: true,
        title: Text(
          _categoryDetails!=null?_categoryDetails.title!:'...',
          style: openSans(16.sp, Colors.black, FontWeight.bold),
        ),),
      body:  ConditionalBuilder(
        condition: _categoryDetails != null,
        fallback: (context) => const Center(
          child: CircularProgressIndicator(
            color: charcoal,
          ),
        ),
        builder: (context) => ConditionalBuilder(
          condition: _categoryDetails!.products!.isNotEmpty,
          fallback: (context) =>Center(child:Text(
            'There is no products with this category ',
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
                      ProductItemView(_categoryDetails.products![index]),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 16.h,
                  ),
                  itemCount: _categoryDetails.products!.length,
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
