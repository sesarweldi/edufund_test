import 'package:edufund_test/config/theme/app_colors.dart';
import 'package:edufund_test/presentation/widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TestimonialItem extends StatelessWidget {
  // final Testimonial testimonial;

  const TestimonialItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: AppColors.accent),
        width: 320.w,
        height: 320.w,
        child: Padding(
          child: _body(),
          padding: EdgeInsets.all(8.w),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "assets/images/test_image.png",
            fit: BoxFit.cover,
            width: 50.w,
            height: 50.h,
          ),
        ),
        Text(
          "lorem ipsum",
          style: TextStyle(
              color: AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
        AppSpacerH(16.h),
        Image.asset(
          "assets/images/quote.png",
          width: 20,
          height: 20,
        ),
        AppSpacerH(8.h),
        Text(
          "lorem ipsum ajsndkjasn dakjsdn jaksndakjs njasnd akjs kdnasjdnl mdas askjdn asjdn",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}

class TestimonialItemShimmer extends StatelessWidget {
  const TestimonialItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
