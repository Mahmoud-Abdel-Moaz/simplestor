import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'view/cart/cart_view_controller.dart';
import 'view/categories/categories_view_controller.dart';
import 'view/login/login_view.dart';

import 'shared/components/constants.dart';
import 'shared/network/local/cache_helper.dart';
import 'view/login/login_view_controller.dart';
import 'view/products/home_view.dart';
import 'view/products/products_view_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  token = CacheHelper.getData(key: "token");
  username = CacheHelper.getData(key: "name");
  mail = CacheHelper.getData(key: "email");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginProvider()),
        ChangeNotifierProvider.value(value: ProductsProvider()),
        ChangeNotifierProvider.value(value: CategoriesProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
      ],
      child: /*ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () =>MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Simple Store',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: token!=null?const HomeScreen(): LoginScreen(),
        ),
      ),*/
        ScreenUtilInit(
          designSize: Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter_ScreenUtil',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(button: TextStyle(fontSize: 45.sp)),
            ),
            builder: (context, widget) {
              ScreenUtil.setContext(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            home: token!=null?const HomeScreen(): LoginScreen(),
          ),
        ),
    );
  }
}
