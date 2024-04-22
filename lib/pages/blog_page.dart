import 'dart:async';
import 'dart:ui';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hourglass/widgets/custom_app_bar.dart';
import 'package:hourglass/widgets/drawer_altrd.dart';
import 'package:hourglass/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class BlogPage extends ConsumerWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool shouldShowSideBar = MediaQuery.sizeOf(context).width < 724;
    ScrollController scrollController = ScrollController();
   dynamic args = ModalRoute.of(context)!.settings.arguments!;
    String image = args!["image"];
    String title = args!["title"];
    String content = args!["content"];
        "Sample Description is very huge just wanted to see how it will turn out hope it turns out well";
    return Scaffold(
      endDrawer: AltrdDrawer(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        shouldShow: shouldShowSideBar,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = MediaQuery.of(context).size.width > 1168;
          return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    image,
                    fit: BoxFit.fitWidth,
                    width: 1440,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: Text(
                      title,
                      softWrap: true,
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      content,
                      softWrap: true,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FooterWidget()
                ],
              ));
        },
      ),
    );
  }
}
