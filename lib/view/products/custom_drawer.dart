import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../shared/components/components.dart';
import '../../shared/const.dart';
import '../../view/login/login_view.dart';
import '../../view/login/login_view_controller.dart';
import '../../view/cart/cart_view.dart';
import '../../view/categories/categories_view.dart';
import '../../view/profile/profile_view.dart';

import '../../shared/style/colors.dart';
import 'home_view.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Widget buildListTile(String title,IconData icon,void Function() tapHandler,BuildContext ctx){
    return ListTile(
      leading: Icon(icon,size: 25.sp,color: charcoal,),
      title: Text(title,style: openSans(18.sp, charcoal, FontWeight.w600),textScaleFactor: 1,),
      onTap: tapHandler,
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20.r),
            color: charcoal,
            child: Text('Sample store',style: openSans(18.sp, darkGunmetal, FontWeight.w600),textScaleFactor: 1,),
          ),
          SizedBox(height:20.h),
          buildListTile("Home", Icons.home,()=>navigateToAndReplacement(context,const HomeScreen()),context),
          buildListTile("Categories", Icons.dashboard_outlined,()=>navigateToAndReplacement(context,const CategoriesScreen()),context ),
          buildListTile("Cart", Icons.shopping_cart,()=>navigateToAndReplacement(context,const CartScreen()),context ),
          buildListTile("Profile", Icons.person,()=>navigateToAndReplacement(context,const ProfileScreen()),context ),
          Divider(
            height: 15.h,
            color: Colors.black54,
          ),
          buildListTile("Logout", Icons.logout,()=>logout(context),context ),

        ],
      ),
    );
  }
  logout(context)async{
    await Provider.of<LoginProvider>(context,listen: false).logout().then((value) {
      if(value== "success")
      {
        navigateToAndFinish(context, LoginScreen());
      }
    });
  }
}
