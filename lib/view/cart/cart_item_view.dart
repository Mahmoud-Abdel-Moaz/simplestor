import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/cart.dart';
import '../../shared/const.dart';
import '../../shared/style/colors.dart';
import 'cart_view_controller.dart';

class CartItemView extends StatefulWidget {
  final CartItem cartItem;

  const CartItemView(this.cartItem,{Key? key,} ) : super(key: key);

  @override
  State<CartItemView> createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child:Column(
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
                widget.cartItem.product!.title!,
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
                "Price :",
                style: openSans(16.sp, darkGunmetal, FontWeight.w600),
              ),
              SizedBox(width: 16.w,),
              Text(
                widget.cartItem.product!.price!.toString(),
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
                "Total :",
                style: openSans(16.sp, darkGunmetal, FontWeight.w600),
              ),
              SizedBox(width: 16.w,),
              Text(
                (widget.cartItem.product!.price!*widget.cartItem.quantity).toString(),
                style: openSans(16.sp, charcoal, FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: (){
                  Provider.of<CartProvider>(context,listen: false).updateCart(1, widget.cartItem.product!.id!);
    },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 4.h),
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.r,color: charcoal),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child:const Center(
                    child: Icon(Icons.add,color: darkGunmetal,),
                  ),
                ),
              ),
              SizedBox(width: 8.w,),
              Text(
                widget.cartItem.quantity.toString(),
                style: openSans(16.sp, charcoal, FontWeight.w500),
              ),
              SizedBox(width: 8.w,),
              GestureDetector(
                onTap: () {
                  if(widget.cartItem.quantity!=1) {
                    Provider.of<CartProvider>(context, listen: false)
                        .updateCart(-1, widget.cartItem.product!.id!);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 4.h),
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.r,color: charcoal),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child:const Center(
                    child: Icon(Icons.minimize,color: darkGunmetal,),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Provider.of<CartProvider>(context,listen: false).removeFromCart( widget.cartItem.product!.id!);

                },
                child: Icon(Icons.delete_outline,color: Colors.red,size: 24.r,),
              )
            ],
          ),
        ],
      ),
    );
  }
}
