import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:edufund_test/config/locale/locale_keys.g.dart';
import 'package:edufund_test/config/theme/app_colors.dart';
import 'package:edufund_test/model/testimonial.dart';
import 'package:edufund_test/presentation/widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double _width = 150;

class TestimonialItem extends StatelessWidget {
  final Testimonial testimonial;
  final double? height;
  final double width;

  const TestimonialItem(
      {super.key, required this.testimonial, this.height, this.width = _width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 8, color: Colors.grey.shade300),
      ], borderRadius: BorderRadius.circular(16), color: AppColors.white),
      width: width,
      child: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        AppSpacerH(8.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            "assets/images/icon_quote_start.png",
            width: 20,
            height: 20,
          ),
        ),
        AppSpacerH(4.h),
        AnimatedReadMoreText(
          testimonial.content ?? "",
          animationCurve: Curves.easeInOut,
          maxLines: 4,
          readMoreText: LocaleKeys.readMore.tr(),
          readLessText: LocaleKeys.readLess.tr(),
          textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black),
          buttonTextStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
        ),
        AppSpacerH(4.h),
        Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            "assets/images/icon_quote_end.png",
            width: 20,
            height: 20,
          ),
        ),
        AppSpacerH(16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_likeWidget(), _userWidget()],
        ),
      ],
    );
  }

  Widget _likeWidget() {
    return Row(
      children: [
        Icon(CupertinoIcons.heart_fill, color: AppColors.primary, size: 20),
        AppSpacerW(4.w),
        Text(testimonial.likes.toString(),
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.black,
            )),
      ],
    );
  }

  Widget _userWidget() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: testimonial.avatar ?? "",
            fit: BoxFit.cover,
            width: 20.w,
            height: 20.h,
          ),
        ),
        AppSpacerW(4.w),
        Text(testimonial.name ?? "",
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.black,
            )),
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
