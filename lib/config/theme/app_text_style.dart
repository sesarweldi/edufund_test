import 'dart:ui';

import 'package:edufund_test/config/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle osRegular18white = TextStyle(
    color: AppColors.white,
    fontSize: 18.sp,
  );
  static TextStyle osRegular16white = TextStyle(
    color: AppColors.white,
    fontSize: 16.sp,
  );
  static TextStyle osRegular14white = TextStyle(
    color: AppColors.white,
  );

  static TextStyle osSemiBold10White = TextStyle(
    color: AppColors.white,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle osBold20Black = TextStyle(
    color: AppColors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  TextStyle? osBold14White = TextStyle(
    color: AppColors.white,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );
}
