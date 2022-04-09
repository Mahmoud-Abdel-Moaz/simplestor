import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'custom_drawer.dart';

import '../../model/products/product.dart';
import '../../shared/const.dart';
import '../../shared/style/colors.dart';
import 'product_view_item.dart';
import 'products_view_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Provider.of<ProductsProvider>(context,listen: false).getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ProductsProvider _productsProvider=Provider.of<ProductsProvider>(context);
    List<Product>? _products=_productsProvider.products;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:  Colors.white,        iconTheme:const IconThemeData(color: charcoal),

        title: Text(
        'Sample store',
        style: openSans(18.sp, Colors.black, FontWeight.bold),
    ),),
      body: RefreshIndicator(
        onRefresh: Provider.of<ProductsProvider>(context,listen: false).getProducts,
        child: ConditionalBuilder(
          condition: _products != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: charcoal,
            ),
          ),
          builder: (context) => ConditionalBuilder(
            condition: _products!.isNotEmpty,
            fallback: (context) =>Center(child:Text(
              'There is no products ',
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
                        ProductItemView(_products[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16.h,
                    ),
                    itemCount: _products.length,
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
