import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../const.dart';
import '../style/colors.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

Future<void> navigateToAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (Route<dynamic> route) {
      return false;
    });

void navigateToAndReplacement(context, widget) => Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
  /*      (Route<dynamic> route){
      return false;
    }*/
);

void printFullText(String text) {
  final pattern = RegExp('.{1,800');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

void showToast({
  required String msg,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: _chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

Color _chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.WARNING:
      return Colors.yellow;
    case ToastStates.ERROR:
      return Colors.red;
  }
}

enum ToastStates { SUCCESS, ERROR, WARNING }




customTextField({
  required TextEditingController controller,
  required BuildContext context,
  required String hint,
  required FocusNode focusNode,
  double? height,
  double? verticalPadding,
  TextInputType type = TextInputType.text,
  required void Function() onSubmit,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(focusNode);
    },
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 8.h, horizontal: 16.w),
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor,width: 1.r),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextFormField(
        style: openSans(14.sp, eerieBlack, FontWeight.w500),
        decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            disabledBorder: InputBorder.none,
            hintText: hint,
            hintStyle: openSans(14.sp, auroMetalSaurus, FontWeight.w400)),
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: (value) {
          onSubmit();
        },
        focusNode: focusNode,
        validator: validator,
        onChanged: onChanged,
      ),
    ),
  );
}



Widget passwordTextField({
  required TextEditingController controller,
  required String hint,
  required bool passVisible,
  required FocusNode focusNode,
  required BuildContext context,
  required void Function() onTap,
  TextInputType type = TextInputType.text,
  double? verticalPadding,
  double? horizontalPadding,
  required void Function() onSubmit,
  void Function(String)? onChanged,
  required String? Function(String?)? validator,
}) {
  return GestureDetector(
    onTap: () {
      Focus.of(context).requestFocus(focusNode);
    },
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 8.h,
          horizontal: horizontalPadding ?? 8.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor,width: 1.r),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextFormField(
        style: openSans(14.sp, Colors.black, FontWeight.w600),
        obscureText: passVisible,
        decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            suffixIconConstraints:
                BoxConstraints(minWidth: 20.w, maxHeight: 20.h),
            disabledBorder: InputBorder.none,
            suffixIcon: GestureDetector(
              child: SizedBox(
                width: 20.r,
                height: 20.r,
                child: Icon(
                  passVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  // size: 20.w,
                  color: auroMetalSaurus,
                ),
              ),
              onTap: onTap,
            ),
            hintText: hint,
            hintStyle: openSans(14.sp, auroMetalSaurus, FontWeight.w400)),
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.visiblePassword,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: (value) {
          onSubmit();
        },
      ),
    ),
  );
}

