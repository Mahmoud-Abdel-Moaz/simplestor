import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simplestor/view/categories/category_view_item.dart';

import '../../model/products/category.dart';
import '../../shared/const.dart';
import '../../shared/style/colors.dart';
import '../products/custom_drawer.dart';
import 'categories_view_controller.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoriesProvider _categoriesProvider=Provider.of<CategoriesProvider>(context);
    List<ProductCategory>? _categories=_categoriesProvider.categories;
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,        iconTheme:const IconThemeData(color: charcoal),

        centerTitle: true,
        title: Text(
          'Categories',
          style: openSans(18.sp, Colors.black, FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: Provider.of<CategoriesProvider>(context,listen: false).getCategories,
        child: ConditionalBuilder(
          condition: _categories != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: charcoal,
            ),
          ),
          builder: (context) => ConditionalBuilder(
            condition: _categories!.isNotEmpty,
            fallback: (context) =>Center(child:Text(
              'There is no categories ',
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
                        CategoryViewItem(_categories[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16.h,
                    ),
                    itemCount: _categories.length,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer:const CustomDrawer(),
    );
  }
}
