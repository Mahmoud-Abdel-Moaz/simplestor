import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../shared/const.dart';
import '../../shared/style/colors.dart';
import '../login/login_view_controller.dart';
import '../products/custom_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    Provider.of<LoginProvider>(context,listen: false).userInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    LoginProvider _loginProvider =Provider.of<LoginProvider>(context);
    User? _user=_loginProvider.user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Profile',
          style: openSans(18.sp, Colors.black, FontWeight.bold),
        ),
        iconTheme:const IconThemeData(color: charcoal),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h),
        child: ConditionalBuilder(
          condition:_user!=null ,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: charcoal,
            ),
          ),
          builder:(context) =>  Column(
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
                    _user!.name!,
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
                    "Email :",
                    style: openSans(16.sp, darkGunmetal, FontWeight.w600),
                  ),
                  SizedBox(width: 16.w,),
                  Text(
                    _user.email!,
                    style: openSans(16.sp, charcoal, FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer:const CustomDrawer(),
    );
  }
}
