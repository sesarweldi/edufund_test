import 'package:cached_network_image/cached_network_image.dart';
import 'package:edufund_test/config/theme/app_colors.dart';
import 'package:edufund_test/model/testimonial.dart';
import 'package:edufund_test/presentation/widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestimonialItemSlider extends StatelessWidget {
  final Testimonial testimonial;

  const TestimonialItemSlider({super.key, required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: AppColors.white,
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: _body(),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CachedNetworkImage(
            imageUrl: testimonial.avatar ?? "",
            fit: BoxFit.cover,
            width: 70.w,
            height: 70.h,
          ),
        ),
        AppSpacerH(6.h),
        Text(
          testimonial.name ?? "",
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
              color: AppColors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold),
        ),
        AppSpacerH(10.h),
        Image.asset(
          "assets/images/quote.png",
          width: 20,
          height: 20,
        ),
        AppSpacerH(4.h),
        Expanded(
          child: Text(
            testimonial.content ?? "",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
