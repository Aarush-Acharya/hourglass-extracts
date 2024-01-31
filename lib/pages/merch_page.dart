import 'dart:async';
import 'dart:ui';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fineartsociety/widgets/custom_app_bar.dart';
import 'package:fineartsociety/widgets/footer_widget.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = MediaQuery.of(context).size.width > 1168;
          return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    child: Stack(
                      children: [
                        PageView(
                          controller: pageViewController,
                          onPageChanged: (value) {
                            print(value);
                            ref
                                .read(currentItemStateProvider.notifier)
                                .changeState(value);
                          },
                          children: <Widget>[
                            Image.network(
                              'https://placekitten.com/1440/500',
                              fit: BoxFit.cover,
                              width: 250,
                              height: 250,
                            ),
                            Image.network(
                              'https://placekitten.com/1440/600',
                              fit: BoxFit.cover,
                              width: 250,
                              height: 250,
                            ),
                            Image.network(
                              'https://placekitten.com/1440/400',
                              fit: BoxFit.cover,
                              width: 250,
                              height: 250,
                            ),
                            Image.network(
                              'https://placekitten.com/1440/700',
                              fit: BoxFit.cover,
                              width: 250,
                              height: 250,
                            ),
                          ],
                        ),
                        Positioned(
                          top: 480,
                          child: PageViewDotIndicator(
                              currentItem: currentItem,
                              count: 4,
                              unselectedColor:
                                  const Color.fromARGB(255, 219, 219, 219),
                              selectedColor: Colors.white,
                              size: const Size(12, 12),
                              unselectedSize: const Size(8, 8),
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              onItemClicked: (index) {}),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://placekitten.com/350/600'))),
                        height: 600,
                        width: 350,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 500, left: 200, right: 50, bottom: 50),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white, width: 2))),
                              onPressed: () {},
                              child: Text(
                                "Mens",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://placekitten.com/350/600'))),
                        height: 600,
                        width: 350,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 500, left: 200, right: 50, bottom: 50),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white, width: 2))),
                              onPressed: () {},
                              child: Text(
                                "Womens",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://placekitten.com/350/600'))),
                        height: 600,
                        width: 350,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 500, left: 220, right: 30, bottom: 50),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white, width: 2))),
                              onPressed: () {},
                              child: Text(
                                "Hats",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 60),
                    child: isDesktop
                        ? Column(
                            children: [
                              const Text(
                                "Merch",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
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
                                            .read(
                                                merchTypeStateProvider.notifier)
                                            .changeState(true);
                                      },
                                      child: const Text(
                                        "New Releases",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                                merchTypeStateProvider.notifier)
                                            .changeState(false);
                                      },
                                      child: const Text("Accessories",
                                          style:
                                              TextStyle(color: Colors.black))),
                                ],
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              isNewReleases
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  'https://placekitten.com/900/500',
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
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  'https://placekitten.com/900/500',
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
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  'https://placekitten.com/900/500',
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
                                                    color: Colors.black),
                                              )
                                            ],
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
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  'https://placekitten.com/600/500',
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
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  'https://placekitten.com/600/500',
                                                  fit: BoxFit.cover,
                                                  width: 250,
                                                  height: 250,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "Prod 8",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  'https://placekitten.com/600/500',
                                                  fit: BoxFit.cover,
                                                  width: 250,
                                                  height: 250,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "Prod 9",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                          height: 300,
                                          width: 250,
                                        ),
                                      ],
                                    ),
                              const SizedBox(
                                height: 60,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "All New Accessories",
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Shop All",
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              Divider(),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "Smoking",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://placekitten.com/700/500',
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
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    ),
                                    height: 300,
                                    width: 250,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://placekitten.com/700/500',
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
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    ),
                                    height: 300,
                                    width: 250,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://placekitten.com/700/500',
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
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    ),
                                    height: 300,
                                    width: 250,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "All Smocking Products",
                                  )),
                              SizedBox(
                                height: 40,
                              ),
                              Divider(),
                              SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "Non Smoking",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://placekitten.com/700/500',
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
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    ),
                                    height: 300,
                                    width: 250,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://placekitten.com/700/500',
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
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    ),
                                    height: 300,
                                    width: 250,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://placekitten.com/700/500',
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
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    height: 300,
                                    width: 250,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "All Non-Smocking Products",
                                  )),
                              const SizedBox(
                                height: 40,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      'https://placekitten.com/500/500',
                                      fit: BoxFit.contain,
                                      width: 700,
                                      height: 500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 120,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        child: SizedBox(
                                          width: 300,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Bar Accessories Travel Set",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 35),
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  scrollController.animateTo(
                                                      2200,
                                                      duration:
                                                          Duration(seconds: 2),
                                                      curve: Curves.decelerate);
                                                },
                                                child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      RatingBar.builder(
                                                        unratedColor:
                                                            Colors.grey,
                                                        // tapOnlyMode: true,
                                                        itemSize: 30,
                                                        ignoreGestures: true,
                                                        initialRating: 4.5,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "·",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 30),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "4.5",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 25),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  "313 ratings",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              const Text(
                                                "\$ 2,000.00",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 30),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Shipping calculated at checkout",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              const Text(
                                                "Quantity",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 23),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors.amber,
                                                        width: 0.2)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        ref
                                                            .read(countProvider
                                                                .notifier)
                                                            .increment();
                                                      },
                                                      icon: const Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      '$value',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 24),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        ref
                                                            .read(countProvider
                                                                .notifier)
                                                            .decrement(context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    minimumSize: const Size(
                                                        double.maxFinite, 50),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "Buy Now",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black),
                                                  )),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    minimumSize: const Size(
                                                        double.maxFinite, 50),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "Add to Cart",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.handshake,
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                "Safe\nTransactions",
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.people,
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                "Connect\nwith Artist",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.verified,
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Verified and\nTrusted Artist",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const Text(
                                        "☝️ One-Time Payment, No Monthly Fees",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 30, bottom: 60, left: 60),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            child: Text(
                                              "Boost your Wall Decour, form your Villa.",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 40),
                                              softWrap: true,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Text(
                                            "This Artwork was meant to be hung on walls of the\nplace you call home",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check_box,
                                                color: Colors.green,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Purely HandMade",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check_box,
                                                color: Colors.green,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  "Directly from the hands of the Artist to your wall",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check_box,
                                                color: Colors.green,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  "Non-Standard, Artist Centric Prices",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://placekitten.com/700/500',
                                        fit: BoxFit.cover,
                                        width: 700,
                                        height: 500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://placekitten.com/700/500',
                                        fit: BoxFit.cover,
                                        width: 700,
                                        height: 500,
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 60, right: 100),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            child: Text(
                                              "Things to Note",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 40),
                                              softWrap: true,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Text(
                                            "what's unique in this artwork?",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.brush,
                                                color: Colors.pink,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  "Conventional Paint Art Style",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.rectangle_rounded,
                                                color: Colors.yellow,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  "Dimensions (Height, Width):  820cm X 1920cm",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.water_drop,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  "100mm Water Resistant paint",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 130,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 100),
                                child: Column(
                                  children: [
                                    Text("They trust us",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 25)),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    CarouselSlider(
                                      items: [
                                        'assets/press1.png',
                                        'assets/press2.png',
                                        'assets/press3.png',
                                        'assets/press1.png',
                                        'assets/press2.png',
                                        'assets/press3.png',
                                      ].map((pressImagePath) {
                                        return Image.asset(pressImagePath);
                                      }).toList(),
                                      options: CarouselOptions(
                                        height: constraints.maxWidth <= 600
                                            ? firstFoldHeight * 0.2
                                            : firstFoldHeight * 0.2,
                                        enlargeCenterPage: true,
                                        autoPlay: true,
                                        viewportFraction:
                                            constraints.maxWidth <= 600
                                                ? 0.2
                                                : 0.2,
                                        enableInfiniteScroll: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 120,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Reviews",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        RatingBar.builder(
                                          unratedColor: Colors.grey,
                                          // tapOnlyMode: true,
                                          itemSize: 30,
                                          ignoreGestures: true,
                                          initialRating: 4.5,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "4.5",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "·",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "313 ratings",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      // height: 10,
                                      // width: 50,
                                      child: ClipRRect(
                                        child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: SizedBox(
                                              height: 100,
                                              width: double.maxFinite,
                                              child: Center(
                                                  child: Text(
                                                      "Under Construction")),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                height: 400,
                                width: 600,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                "TITLE",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 40),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              const Text(
                                "DATE/TIME",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "LOCATION",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "DESCRIPTION",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 23),
                              ),
                            ],
                          ),
                  ),
                  FooterWidget()
                ],
              ));
        },
      ),
    );
  }
}
