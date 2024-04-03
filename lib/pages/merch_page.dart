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
part 'merch_page.g.dart';

@riverpod
class Count extends _$Count {
  @override
  int build() => 1;

  void increment() {
    state++;
  }

  void initialise() {
    state = 1;
  }

  void decrement(BuildContext context) {
    if (state != 1) {
      state--;
    } else {
      IconSnackBar.show(
          context: context,
          snackBarType: SnackBarType.alert,
          label: 'Sorry! The Quantity Cannot be Less than 1');
    }
  }
}

@riverpod
class MerchTypeState extends _$MerchTypeState {
  @override
  bool build() => true;

  void changeState(bool newState) {
    state = newState;
  }
}

@riverpod
class CurrentItemState extends _$CurrentItemState {
  @override
  int build() => 0;

  void changeState(int newState) {
    state = newState;
  }
}

class MerchPage extends ConsumerWidget {
  const MerchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PageController pageViewController = PageController();
    bool isNewReleases = ref.watch(merchTypeStateProvider);
    double firstFoldHeight = MediaQuery.of(context).size.height * 0.75;
    int value = ref.watch(countProvider);
    int currentItem = ref.watch(currentItemStateProvider);
    ScrollController scrollController = ScrollController();

    Timer.periodic(Duration(seconds: 5), (timer) {
      int currentPage = pageViewController.page!.toInt();
      pageViewController.animateToPage(currentPage == 3 ? 0 : currentPage + 1,
          duration: Duration(seconds: 1), curve: Curves.decelerate);
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

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: isDesktop? 0: 60.0),
                    child: Image.asset(
                      'assets/merch_header.jpeg',
                      fit: BoxFit.fitWidth,
                      width: 1440,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: isDesktop ? 60 : 30),
                      child: Column(
                        children: [
                          const Text(
                            "Merch",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    ref
                                        .read(merchTypeStateProvider.notifier)
                                        .changeState(true);
                                  },
                                  child: const Text(
                                    "New Releases",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              SizedBox(
                                width: 0.06944444444 *
                                    MediaQuery.sizeOf(context).width,
                              ),
                              TextButton(
                                  onPressed: () {
                                    ref
                                        .read(merchTypeStateProvider.notifier)
                                        .changeState(false);
                                  },
                                  child: const Text("Accessories",
                                      style: TextStyle(color: Colors.white))),
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          isDesktop
                              ? isNewReleases
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 1",
                                                    3.2,
                                                    20,
                                                    90.00,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 1",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 2",
                                                    3.9,
                                                    40.00,
                                                    70,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 2",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 3",
                                                    3.0,
                                                    100,
                                                    220.00,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 3",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 4",
                                                    4.2,
                                                    312,
                                                    134,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 4",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 3",
                                                    3.0,
                                                    100,
                                                    220.00,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 5",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 5",
                                                    3.7,
                                                    120,
                                                    190.00,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 6",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 7",
                                                    4.8,
                                                    200,
                                                    280.00,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 7",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                      ],
                                    )
                              : isNewReleases
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 1",
                                                    3.2,
                                                    20,
                                                    90.00,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 1",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 2",
                                                    3.9,
                                                    40.00,
                                                    70,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 2",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 3",
                                                    3.0,
                                                    100,
                                                    220.00,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 3",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 4",
                                                    4.2,
                                                    312,
                                                    134,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 4",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 3",
                                                    3.0,
                                                    100,
                                                    220.00,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 5",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 5",
                                                    3.7,
                                                    120,
                                                    190.00,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 6",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/indivisualMerchPage',
                                                  arguments: [
                                                    "Merch 7",
                                                    4.8,
                                                    200,
                                                    280.00,
                                                    'assets/merch-shirt.png'
                                                  ]);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    'assets/merch-shirt.png',
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Prod 7",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                      ],
                                    ),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: const Size(180, 50),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          onPressed: () {},
                          child: const Text(
                            "All new arrivals",
                            style: TextStyle(color: Colors.black),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: const Size(180, 50),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          onPressed: () {},
                          child: const Text(
                            "Shop Now",
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FooterWidget()
                ],
              ));
        },
      ),
    );
  }
}
