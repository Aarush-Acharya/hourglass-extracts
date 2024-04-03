import 'dart:convert';
import 'package:hourglass/pages/home_page.dart';
import 'package:hourglass/widgets/drawer_altrd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/blocks_grid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/footer_widget.dart';

class MyAnimationProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'ticker');
  }
}

class ProductPage extends ConsumerWidget {
  ProductPage({super.key});
  final MyAnimationProvider animationProvider = MyAnimationProvider();

  Future<List<dynamic>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/artists_data.json');
    var data = await json.decode(response);
    List<dynamic> artists = data['artists'];
    List<dynamic> featuredArtists = artists.where((item) {
      return item['featured'] == true;
    }).toList();
    print(featuredArtists);
    return featuredArtists;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List scales = ref.watch(cardScaleStateProvider);
    var controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: animationProvider);
    var animation = new CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut);
    List<String> productNames = [
      "Edibles",
      "Moonrocks",
      "Resins",
      "Thundersticks",
      "Moonrocks"
    ];
    bool isDesktop = MediaQuery.of(context).size.width > 1168;
    bool shouldShowSideBar = MediaQuery.sizeOf(context).width < 724;
    double firstFoldHeight = MediaQuery.of(context).size.height * 0.75;
    Map products = {
      "Cart": "cartrage_yellow",
      "Disposables": "disposables",
      "Pre-Roll Pack": "preeroll_pack_blue",
      "Single Pre-Roll": "single_prerolls_blue",
      "Jar": "prod 5"
    };

    return Scaffold(
        endDrawer: AltrdDrawer(),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: CustomAppBar(
          shouldShow: shouldShowSideBar,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text('Products',
                    style: TextStyle(fontSize: 30, color: Colors.white)),
                isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Ensures equal spacing
                        children: List.generate(products.length, (index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                hoverColor: null,
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Cart",
                                          [
                                            "Cartrage",
                                            "The STIIIZY Battery Starter Kit is your essential power pack, featuring a standard battery, a USB charging cable, and easy charging via any USB port.",
                                            "assets/cartrage_yellow.png"
                                          ],
                                        ]);
                                  } else if (index == 1) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Disposables",
                                          [
                                            "Disposables",
                                            "Whatever this is it is disposable for sure.",
                                            "assets/disposables.png"
                                          ],
                                        ]);
                                  } else if (index == 2) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Pre-Roll Pack",
                                          [
                                            "Pre-Roll Pack Blue",
                                            "Packs of pre-rolls blue represents some flavour I guess.",
                                            "assets/preeroll_pack_blue.png"
                                          ],
                                          [
                                            "Pre-Roll Pack Yellow",
                                            "Pack of pre-rolls but yellow indicating a different colour.",
                                            "assets/preeroll_pack_yellow.png"
                                          ]
                                        ]);
                                  } else if (index == 3) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Single Pre-Roll",
                                          [
                                            "Single Pre-Roll Blue",
                                            "Single pre-roll of blue colour wrapping indicating a flavour",
                                            "assets/single_prerolls_blue.png"
                                          ],
                                          [
                                            "Single Pre-Roll Red",
                                            "Single pre-roll but red in colour this time, exciting isnt it.",
                                            "assets/single_prerolls_red.png"
                                          ],
                                          [
                                            "Single Pre-Roll Yellow",
                                            "Again single pre-roll just yellow now.",
                                            "assets/single_prerolls_yellow.png"
                                          ]
                                        ]);
                                  } else {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Jars",
                                          [
                                            "A Mystry Jar",
                                            "=== No info yet need more info asap XD ===",
                                            "assets/prod 5.png"
                                          ],
                                        ]);
                                  }
                                },
                                onHover: (value) {
                                  ref
                                      .watch(cardScaleStateProvider.notifier)
                                      .changeScale(index);
                                },
                                child: ClipRRect(
                                  child: AnimatedContainer(
                                    height: 300,
                                    width: 230,
                                    color: Colors.black,
                                    transformAlignment: Alignment.center,
                                    duration: const Duration(
                                        milliseconds:
                                            300), // Adjust the duration as needed
                                    curve: Curves
                                        .easeInOut, // Adjust the curve as needed
                                    transform: Matrix4.identity()
                                      ..scale(scales[index]),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Image.asset(
                                          'assets/${products.values.toList()[index]}.png',
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                products.keys.toList()[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          );
                        }),
                      )
                    : Column(
                        // Ensures equal spacing
                        children: List.generate(products.length, (index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                hoverColor: null,
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Cart",
                                          [
                                            "Cartrage",
                                            "The STIIIZY Battery Starter Kit is your essential power pack, featuring a standard battery, a USB charging cable, and easy charging via any USB port.",
                                            "assets/cartrage_yellow.png"
                                          ],
                                        ]);
                                  } else if (index == 1) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Disposables",
                                          [
                                            "Disposables",
                                            "Whatever this is it is disposable for sure.",
                                            "assets/disposables.png"
                                          ],
                                        ]);
                                  } else if (index == 2) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Pre-Roll Pack",
                                          [
                                            "Pre-Roll Pack Blue",
                                            "Packs of pre-rolls blue represents some flavour I guess.",
                                            "assets/preeroll_pack_blue.png"
                                          ],
                                          [
                                            "Pre-Roll Pack Yellow",
                                            "Pack of pre-rolls but yellow indicating a different colour.",
                                            "assets/preeroll_pack_yellow.png"
                                          ]
                                        ]);
                                  } else if (index == 3) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Single Pre-Roll",
                                          [
                                            "Single Pre-Roll Blue",
                                            "Single pre-roll of blue colour wrapping indicating a flavour",
                                            "assets/single_prerolls_blue.png"
                                          ],
                                          [
                                            "Single Pre-Roll Red",
                                            "Single pre-roll but red in colour this time, exciting isnt it.",
                                            "assets/single_prerolls_red.png"
                                          ],
                                          [
                                            "Single Pre-Roll Yellow",
                                            "Again single pre-roll just yellow now.",
                                            "assets/single_prerolls_yellow.png"
                                          ]
                                        ]);
                                  } else {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Jars",
                                          [
                                            "A Mystry Jar",
                                            "=== No info yet need more info asap XD ===",
                                            "assets/prod 5.png"
                                          ],
                                        ]);
                                  }
                                },
                                onHover: (value) {
                                  ref
                                      .watch(cardScaleStateProvider.notifier)
                                      .changeScale(index);
                                },
                                child: ClipRRect(
                                  child: AnimatedContainer(
                                    height: 300,
                                    width: 230,
                                    color: Colors.black,
                                    transformAlignment: Alignment.center,
                                    duration: const Duration(
                                        milliseconds:
                                            300), // Adjust the duration as needed
                                    curve: Curves
                                        .easeInOut, // Adjust the curve as needed
                                    transform: Matrix4.identity()
                                      ..scale(scales[index]),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Image.asset(
                                          'assets/${products.values.toList()[index]}.png',
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                products.keys.toList()[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                const SizedBox(height: 100),
                Text(
                  "#1 BRAND IN CALIFORNIA FOR INNOVATIVE CANNABIS PRODUCTS",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "ALTRD specializes in a diverse array of cannabis delights, ranging from gourmet edibles to potent moonrocks, pure resins, and our signature thundersticks. Explore the pinnacle of flavor and effect with our meticulously crafted edibles, indulge in the celestial experience of our premium moonrocks, or dive deep into the essence of cannabis with our rich, aromatic resins. Our thundersticks offer an unparalleled experience, combining innovation and tradition for a truly electrifying session.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "EDIBLES:",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "ALTRD's edibles redefine the boundaries of taste and potency, offering a gourmet journey through an array of flavors. Each edible is crafted with the finest ingredients and the purest extracts, ensuring a consistent and enjoyable experience. From the subtle elegance of our infused chocolates to the bold burst of our gummy delights, our edibles are designed for discerning palates and refined effects.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "MOONROCKS:",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "Experience the zenith of potency with ALTRD's moonrocks, a harmonious blend of top-shelf flower, golden hash oil, and kief. Each moonrock is a masterpiece of flavor and intensity, designed to elevate your experience to cosmic proportions. Whether enjoyed alone or shared among friends, our moonrocks promise an unforgettable journey.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "RESINS & THUNDERSTICKS:",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "Dive into the pure essence of cannabis with ALTRD's resins, capturing the full spectrum of cannabinoids and terpenes for an authentic and potent experience. Our thundersticks, a bold fusion of premium flower and concentrate, offer a unique experience that ignites the senses and propels you to new heights. Embrace the power and purity of ALTRD's resins and thundersticks for a transcendent cannabis experience.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: const Size(180, 50),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    onPressed: () {},
                    child: const Text(
                      "Go to Dispensary",
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(
                  height: 40,
                ),
                FooterWidget(),
              ],
            ),
          ),
        ));
  }
}
