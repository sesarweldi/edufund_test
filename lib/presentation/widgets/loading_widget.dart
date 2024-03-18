import 'package:edufund_test/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 2,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.grey.shade800,
          strokeWidth: 1.5,
          backgroundColor: AppColors.accent,
        ),
      ),
    );
  }
}
