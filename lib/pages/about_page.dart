import 'dart:async';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:hourglass/widgets/card_grid.dart';
import 'package:hourglass/widgets/custom_app_bar.dart';
import 'package:hourglass/widgets/drawer_altrd.dart';
import 'package:hourglass/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PageController pageViewController = PageController();
    ScrollController scrollController = ScrollController();

    Timer.periodic(const Duration(seconds: 10), (timer) {
      int currentPage = pageViewController.page!.toInt();
      pageViewController.animateToPage(currentPage == 3 ? 0 : currentPage + 1,
          duration: const Duration(seconds: 1), curve: Curves.decelerate);
    });

    List<String> urls = [
      "https://placekitten.com/1440/500",
      "https://placekitten.com/1440/600",
      "https://placekitten.com/1440/700"
    ];
    IndexController _controller = IndexController();
    bool shouldShowSideBar = MediaQuery.sizeOf(context).width < 724;
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
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                      padding: isDesktop
                          ? EdgeInsets.only(left: 50, top: 60, bottom: 60)
                          : EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          isDesktop
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          'assets/about_header.jpeg',
                                          fit: BoxFit.cover,
                                          width: 700,
                                          height: 500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 120,
                                    ),
                                    const Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 30),
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Who We Are",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 35),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                SizedBox(
                                                  width: 400,
                                                  child: Text(
                                                    "Hourglass Extracts stands as a testament to the timeless quality and enduring value of premium cannabis. Rooted in the heart of Oklahoma, we are dedicated to providing our patients with the highest caliber of medicinal cannabis at the best possible value.",
                                                    softWrap: true,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          'assets/about_header.jpeg',
                                          fit: BoxFit.cover,
                                          width: 700,
                                          height: 500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    const Text(
                                      "Who We Are",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 35),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      width: 400,
                                      child: Text(
                                        "Hourglass Extracts stands as a testament to the timeless quality and enduring value of premium cannabis. Rooted in the heart of Oklahoma, we are dedicated to providing our patients with the highest caliber of medicinal cannabis at the best possible value.",
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 100,
                          ),
                          const Text(
                            "TAKE YOUR TIME",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 42),
                          ),
                        ],
                      )),
                  FooterWidget()
                ],
              ));
        },
      ),
    );
  }
}
