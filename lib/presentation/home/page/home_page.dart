import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:edufund_test/config/theme/app_colors.dart';
import 'package:edufund_test/model/testimonial.dart';
import 'package:edufund_test/presentation/home/widget/testimonial_item_slider.dart';
import 'package:edufund_test/presentation/widgets/delayed_display.dart';
import 'package:edufund_test/presentation/widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Testimonial> testimonials = [
      Testimonial(
          avatar:
              "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/324.jpg",
          content:
              "Laboriosam sed inventore quod alias consequatur repellendus asperiores. Perferendis assumenda laboriosam totam soluta eos vero repudiandae quia eveniet. Accusamus illum vitae. Recusandae labore eligendi at magnam dolorum voluptatum labore.\nAccusantium quam voluptas at totam iure saepe nam. Voluptatum dolorum totam. Quos cum temporibus beatae consequatur sunt veniam voluptates sequi saepe. Recusandae ipsa quam dolore.\nSapiente ea doloribus soluta voluptas et quas. A nobis tempore dolores incidunt nihil inventore temporibus. Dicta doloremque qui eos harum eligendi. Omnis nulla molestiae quos voluptates eius. Nulla perferendis modi in perspiciatis suscipit provident quasi modi.",
          createdAt: "2024-03-12T16:06:30.184Z",
          id: "1",
          name: "Maria Fisher",
          likes: 80725),
      Testimonial(
          avatar:
              "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1208.jpg",
          content:
              "Quos cum temporibus beatae consequatur sunt veniam voluptates sequi saepe. Recusandae ipsa quam dolore.\nSapiente ea doloribus soluta voluptas et quas. A nobis tempore dolores incidunt nihil inventore temporibus. Dicta doloremque qui eos harum eligendi. Omnis nulla molestiae quos voluptates eius. Nulla perferendis modi in perspiciatis suscipit provident quasi modi.",
          createdAt: "2024-03-12T16:06:30.184Z",
          id: "2",
          name: "Sesaru Mukherjee",
          likes: 80725),
      Testimonial(
          avatar:
              "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1227.jpg",
          content:
              "Quos cum temporibus beatae consequatur sunt veniam voluptates sequi saepe. Recusandae ipsa quam dolore.\nSapiente ea doloribus soluta voluptas et quas. A nobis tempore dolores incidunt nihil inventore temporibus. Dicta doloremque qui eos harum eligendi. Omnis nulla molestiae quos voluptates eius. Nulla perferendis modi in perspiciatis suscipit provident quasi modi.",
          createdAt: "2024-03-12T16:06:30.184Z",
          id: "3",
          name: "Mrs. Homer Veum",
          likes: 80725),
    ];
    return Scaffold(
      body: _body(testimonials),
      backgroundColor: AppColors.background,
    );
  }

  Widget _body(List<Testimonial> testimonials) {
    return Stack(
      children: [
        CachedNetworkImage(
            imageUrl: testimonials[_current].avatar ?? "",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * .48),
        Positioned(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * .56,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade400.withOpacity(0.5),
                alignment: Alignment.topLeft,
                child: SafeArea(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppSpacerH(50.h),
                          Text(
                            "Testimonials",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black),
                          ),
                          const SizedBox(
                            width: 26,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
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
          bottom: 80,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: DelayedDisplay(
            delay: const Duration(microseconds: 800),
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.4,
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
              items: testimonials.map((testimonial) {
                return Builder(
                  builder: (BuildContext context) {
                    return TestimonialItemSlider(testimonial: testimonial);
                  },
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
