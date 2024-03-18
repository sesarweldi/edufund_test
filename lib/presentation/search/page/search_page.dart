import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:edufund_test/config/locale/locale_keys.g.dart';
import 'package:edufund_test/config/theme/app_colors.dart';
import 'package:edufund_test/presentation/home/widget/testimonial_item.dart';
import 'package:edufund_test/presentation/search/cubit/search_cubit.dart';
import 'package:edufund_test/presentation/search/cubit/search_state.dart';
import 'package:edufund_test/presentation/widgets/empty_or_error_state.dart';
import 'package:edufund_test/presentation/widgets/loading_widget.dart';
import 'package:edufund_test/presentation/widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

@RoutePage()
class SearchPage extends StatefulWidget implements AutoRouteWrapper {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: this,
    );
  }
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) => {
        if (state is TestimonialsError)
          {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(LocaleKeys.smthngWentWrong.tr()))),
          }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: _body(),
        );
      },
    );
  }

  Widget _initialWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.search,
              size: 45,
              color: AppColors.black.withOpacity(.6),
            ),
            AppSpacerH(
              10.h,
            ),
            Text(LocaleKeys.letsSearch,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: AppColors.black.withOpacity(.9),
                )).tr(),
            SizedBox(
              height: 10.h,
            ),
            Text("${LocaleKeys.initialSearch.tr()}.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.black.withOpacity(.9),
                )),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return CustomScrollView(
      slivers: [
        MultiSliver(children: [_body2(), AppSpacerH(16.h), _listTestimonials()])
      ],
    );
  }

  Widget _body2() {
    return SafeArea(
      child: Column(
        children: [
          AppSpacerH(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => context.router.maybePop(),
                  icon: Icon(CupertinoIcons.chevron_back)),
              Text(
                LocaleKeys.searchTestimonials,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: AppColors.black),
              ).tr(),
              AppSpacerW(32)
            ],
          ),
          AppSpacerH(16.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              cursorColor: AppColors.accent,
              onSubmitted: (value) {
                if (value != "") {
                  context.read<SearchCubit>().getTestimonials(value);
                }
              },
              autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppColors.accent,
                ),
                hintText: "${LocaleKeys.searchTestimonials.tr()} ...",
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
                hintStyle: TextStyle(
                  letterSpacing: .0,
                  color: Colors.black.withOpacity(.7),
                ),
                fillColor: Colors.grey.shade400.withOpacity(.1),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: .2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: .2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: .2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTestimonials() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is TestimonialsLoading) {
          return _loadingWidget();
        } else if (state is TestimonialsLoaded) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        TestimonialItem(testimonial: state.testimonials[index]),
                    childCount: state.testimonials.length)),
          );
        } else if (state is TestimonialsError) {
          return ErrorStateWidget();
        } else {
          return _initialWidget();
        }
      },
    );
  }

  Widget _loadingWidget() {
    return const LoadingWidget();
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
