import 'package:easy_localization/easy_localization.dart';
import 'package:edufund_test/config/locale/locale_keys.g.dart';
import 'package:edufund_test/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error,
                size: 45,
                color: AppColors.white.withOpacity(.6),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(LocaleKeys.smthngWentWrong,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: AppColors.black.withOpacity(.9),
                  )).tr(),
              SizedBox(
                height: 10.h,
              ),
              Text("${LocaleKeys.tryAgainLater.tr()}.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.black.withOpacity(.9),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class NoResultsFound extends StatelessWidget {
  const NoResultsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      padding: const EdgeInsets.all(26),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                size: 45,
                color: Colors.black.withOpacity(.6),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                LocaleKeys.notFound,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold),
              ).tr(),
              const SizedBox(
                height: 10,
              ),
              Text("${LocaleKeys.notFoundSearch.tr()}.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
