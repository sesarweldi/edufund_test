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
              Text("Something went wrong!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: AppColors.black.withOpacity(.9),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Text("We so sorry about the error.please try again later.",
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
