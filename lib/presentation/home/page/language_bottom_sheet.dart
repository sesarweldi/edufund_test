import 'package:easy_localization/easy_localization.dart';
import 'package:edufund_test/config/locale/locale_keys.g.dart';
import 'package:edufund_test/config/theme/app_colors.dart';
import 'package:edufund_test/presentation/widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLanguageBottomSheet extends StatefulWidget {
  const ChangeLanguageBottomSheet({super.key});

  @override
  State<ChangeLanguageBottomSheet> createState() =>
      _ChangeLanguageBottomSheetState();
}

class _ChangeLanguageBottomSheetState extends State<ChangeLanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    String selectedLocaleKey = EasyLocalization.of(context)!.locale.toString();

    return Container(
      height: 200.h,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _header(),
            AppSpacerH(16.h),
            LanguageCard(
              localeKey: LocaleKeys.indonesian,
              flag: "🇮🇩",
              isSelected: selectedLocaleKey == "id",
              onTap: () {
                setState(() {
                  selectedLocaleKey = "id";
                });
                context.setLocale(Locale('id'));
                _showSnackbar();
              },
            ),
            AppSpacerH(8.h),
            LanguageCard(
                localeKey: LocaleKeys.english,
                flag: "🇬🇧",
                isSelected: selectedLocaleKey == "en",
                onTap: () {
                  setState(() {
                    selectedLocaleKey = "en";
                  });
                  context.setLocale(Locale('en'));
                  _showSnackbar();
                })
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Text(
      LocaleKeys.chngeLang,
      style: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.black),
    ).tr();
  }

  void _showSnackbar() {
    final snackBar = SnackBar(
      content: Text(LocaleKeys.languageChanged).tr(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }
}

class LanguageCard extends StatelessWidget {
  final Function()? onTap;
  final bool isSelected;
  final String localeKey;
  final String flag;

  const LanguageCard(
      {super.key,
      this.onTap,
      this.isSelected = false,
      required this.localeKey,
      required this.flag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.white,
          borderRadius: BorderRadius.circular(5.h),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$flag ${localeKey == LocaleKeys.indonesian ? LocaleKeys.indonesian.tr() : LocaleKeys.english.tr()}",
                  ).tr(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
