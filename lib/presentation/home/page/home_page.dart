import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:edufund_test/config/locale/locale_keys.g.dart';
import 'package:edufund_test/config/routes/app_router.dart';
import 'package:edufund_test/config/theme/app_colors.dart';
import 'package:edufund_test/model/testimonial.dart';
import 'package:edufund_test/presentation/home/cubit/home_cubit.dart';
import 'package:edufund_test/presentation/home/cubit/home_state.dart';
import 'package:edufund_test/presentation/home/page/language_bottom_sheet.dart';
import 'package:edufund_test/presentation/home/widget/testimonial_item.dart';
import 'package:edufund_test/presentation/home/widget/testimonial_item_slider.dart';
import 'package:edufund_test/presentation/widgets/delayed_display.dart';
import 'package:edufund_test/presentation/widgets/empty_or_error_state.dart';
import 'package:edufund_test/presentation/widgets/loading_widget.dart';
import 'package:edufund_test/presentation/widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: this,
    );
  }
}

class _HomePageState extends State<HomePage> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;
  final PagingController<int, Testimonial> _pagingController = PagingController(
    firstPageKey: 1,
  );

  final List<Testimonial> _testimonials = [];

  @override
  void initState() {
    _getSliderTestimonials();
    _listenPagingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          _onBlocStateChange(state);
        },
        child: CustomScrollView(
          slivers: [
            MultiSliver(
                children: [_body(), _textHeader(), _testimonialsPagedList()])
          ],
        ),
      ),
      backgroundColor: AppColors.background,
    );
  }

  Widget _textHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Expanded(
        child: Text(
          LocaleKeys.seeMore.tr(),
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
        ),
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => _testimonialSliderBuildWhen(current),
      builder: (context, state) {
        if (state is TestimonialsSliderLoaded) {
          return Stack(
            children: [
              CachedNetworkImage(
                  imageUrl: _testimonials[_current].avatar ?? "",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * .58),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        AppColors.background.withOpacity(1),
                        AppColors.background.withOpacity(1),
                        AppColors.background.withOpacity(.7),
                        AppColors.background.withOpacity(.6),
                        AppColors.background.withOpacity(.4),
                        AppColors.background.withOpacity(.3),
                        AppColors.background.withOpacity(0.5),
                        AppColors.background.withOpacity(0.3),
                        AppColors.background.withOpacity(0.0),
                        AppColors.background.withOpacity(0.0),
                      ])),
                ),
              ),
              Positioned(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .55,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade900.withOpacity(0.5),
                      alignment: Alignment.topLeft,
                      child: SafeArea(
                        child: Container(
                          margin: EdgeInsets.only(left: 16, right: 16, top: 30),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.testimonials,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black),
                              ).tr(),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _navigateToSearchPage();
                                      },
                                      child: Icon(
                                        CupertinoIcons.search,
                                        size: 28,
                                      )),
                                  AppSpacerW(10.w),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.language,
                                      size: 28,
                                    ),
                                    onTap: () => _showBottomSheet(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                height: MediaQuery.of(context).size.height * 0.28,
                width: MediaQuery.of(context).size.width,
                child: DelayedDisplay(
                  delay: const Duration(microseconds: 800),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.28,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                    carouselController: _carouselController,
                    items: _testimonials.map((testimonial) {
                      return Builder(
                        builder: (BuildContext context) {
                          return TestimonialItemSlider(
                              testimonial: testimonial);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        } else if (state is TestimonialsSliderLoading) {
          return _loadingWidget();
        } else if (state is TestimonialsSliderError) {
          _showSnackBar(state.error);
          return ErrorStateWidget();
        }
        return SizedBox();
      },
    );
  }

  Widget _testimonialsPagedList() {
    return SliverPadding(
      sliver: PagedSliverList(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Testimonial>(
          newPageProgressIndicatorBuilder: (context) => _loadingWidget(),
          firstPageProgressIndicatorBuilder: (context) => _loadingWidget(),
          itemBuilder: (context, testimonial, index) =>
              TestimonialItem(testimonial: testimonial),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _loadingWidget() {
    return const LoadingWidget();
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _listenPagingController() {
    _pagingController.addPageRequestListener((page) async {
      _getPagedTestimonials(page: page);
    });
  }

  void _getPagedTestimonials({
    required int page,
  }) {
    BlocProvider.of<HomeCubit>(context).getTestimonials(page);
  }

  void _getSliderTestimonials() {
    BlocProvider.of<HomeCubit>(context).getSliderTestimonials();
  }

  void _onTestimonialsLoaded(TestimonialsLoaded state) {
    final isLastPage = state.testimonials.length < 5;
    final snackBar = SnackBar(
      content: Text(LocaleKeys.endedList).tr(),
    );
    if (isLastPage) {
      _pagingController.appendLastPage(state.testimonials);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      _pagingController.appendPage(
        state.testimonials,
        state.page + 1,
      );
    }
  }

  void _onSliderTestimonialsLoaded(TestimonialsSliderLoaded state) {
    _testimonials.addAll(state.testimonials);
  }

  bool _testimonialSliderBuildWhen(HomeState current) =>
      current is TestimonialsSliderLoaded ||
      current is TestimonialsSliderLoading ||
      current is TestimonialsSliderError;

  void _navigateToSearchPage() {
    context.router.push(SearchRoute());
  }

  void _onBlocStateChange(HomeState state) {
    if (state is TestimonialsLoaded) {
      _onTestimonialsLoaded(state);
    } else if (state is TestimonialsSliderLoaded) {
      _onSliderTestimonialsLoaded(state);
    } else if (state is TestimonialPagedError) {
      _showSnackBar(state.error);
    } else if (state is TestimonialsSliderError) {
      _showSnackBar(state.error);
    }
  }

  void _showBottomSheet() {
    showBarModalBottomSheet(
      expand: false,
      backgroundColor: AppColors.white,
      context: context,
      builder: (context) {
        return ChangeLanguageBottomSheet();
      },
    );
  }
}
