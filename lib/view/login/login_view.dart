import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/components/components.dart';
import '../../shared/const.dart';
import 'package:provider/provider.dart';

import '../../shared/components/constants.dart';
import '../../shared/style/colors.dart';
import '../products/home_view.dart';
import 'login_view_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();

  String _emailError = "";

  String _passwordError = "";
  var _key = GlobalKey<FormState>();
  bool _visible = true;
  bool _isLoading = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 16.w),
            margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.h),
            width: double.infinity,
            //  height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: const Offset(0, 0),
                  blurRadius: 75.r,
                )
              ],
            ),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sample store',
                      style: openSans(18.sp, darkGunmetal, FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Email:',
                    style: openSans(14.sp, darkGunmetal, FontWeight.w400),
                    textScaleFactor: 1,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  customTextField(
                    controller: _emailController,
                    context: context,
                    hint: 'Enter email',
                    focusNode: _emailFocusNode,
                    onSubmit: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    validator: (value) {
                      if (value != null&& value.isEmpty) {
                        setState(() {
                          _emailError = "email is required";
                        });
                      } else {
                        setState(() {
                          _emailError = "";
                        });
                      }
                      return null;
                    },
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    _emailError,
                    textScaleFactor: 1,
                    style: openSans(12.sp, Colors.red, FontWeight.w600),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Password:',
                    style: openSans(14.sp, darkGunmetal, FontWeight.w400),
                    textScaleFactor: 1,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  passwordTextField(
                    controller: _passwordController,
                    hint: 'Enter password',
                    passVisible: _visible,
                    focusNode: _passwordFocusNode,
                    context: context,
                    onTap: () => setState(() {
                      _visible = !_visible;
                    }),
                    onSubmit: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          _passwordError = 'password is required';
                        });
                      } else {
                        _passwordError = '';
                      }
                    },
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    _passwordError,
                    textScaleFactor: 1,
                    style: openSans(12.sp, Colors.red, FontWeight.w600),
                  ),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        await login(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: charcoal,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Login',
                                style: openSans(
                                    16.sp, Colors.white, FontWeight.w600),
                                textScaleFactor: 1,
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login(BuildContext context) async {
     if (_key.currentState!.validate() &&
        _emailError.isEmpty &&
        _passwordError.isEmpty) {
      if (!_isLoading) {
        setState(() {
          _isLoading = !_isLoading;
        });
        await Provider.of<LoginProvider>(context,
                listen: false)
            .login(_emailController.text,
                _passwordController.text)
            .then((value) {
          setState(() {
            _isLoading = !_isLoading;
          });
          if (value == "success") {

            navigateToAndFinish(
                context, const HomeScreen());
          } else {
            showToast(
                msg: value != null && value != 'null'
                    ? value
                    : "invalid email and password",
                state: ToastStates.ERROR);
          }
        }).catchError((e) {
          setState(() {
            _isLoading = !_isLoading;
          });
        });
        /*setState(() {
          _isLoading = !_isLoading;
        });*/
      }
    }
  }
}
