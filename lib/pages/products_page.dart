import 'dart:convert';
import 'package:fineartsociety/pages/home_page.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double firstFoldHeight = MediaQuery.of(context).size.height * 0.75;
          bool isDesktop = MediaQuery.sizeOf(context).width < 786;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('Products',
                    style: TextStyle(
                      fontSize: 30,
                    )),
               !isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Ensures equal spacing
                        children: List.generate(productNames.length, (index) {
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
                                          "Edibles",
                                          [
                                            "STIIIZY BATTERY",
                                            "The STIIIZY Battery Starter Kit is your essential power pack, featuring a standard battery, a USB charging cable, and easy charging via any USB port.",
                                            "assets/prod 5.png"
                                          ],
                                          [
                                            "STIIIZY BIIIG BATTERY",
                                            "Experience longer-lasting sessions with the STIIIZY BIIIG Battery, designed for durability and smooth operation. USB charging accessories included.",
                                            "assets/prod 5.png"
                                          ],
                                          [
                                            "STIIIZY PORTABLE POWER CASE",
                                            "Keep your devices powered on-the-go with the sleek STIIIZY Portable Power Case, complete with a USB charging cable and Micro USB Power Adapter.",
                                            "assets/prod 5.png"
                                          ]
                                        ]);
                                  } else if (index == 1) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "MoonRocks",
                                          [
                                            "STIIIZY BATTERY",
                                            "The STIIIZY Battery Starter Kit is your essential power pack, featuring a standard battery, a USB charging cable, and easy charging via any USB port.",
                                            "assets/prod 5.png"
                                          ],
                                          [
                                            "STIIIZY BIIIG BATTERY",
                                            "Experience longer-lasting sessions with the STIIIZY BIIIG Battery, designed for durability and smooth operation. USB charging accessories included.",
                                            "assets/prod 5.png"
                                          ],
                                          [
                                            "STIIIZY PORTABLE POWER CASE",
                                            "Keep your devices powered on-the-go with the sleek STIIIZY Portable Power Case, complete with a USB charging cable and Micro USB Power Adapter.",
                                            "assets/prod 5.png"
                                          ]
                                        ]);
                                  } else if (index == 2) {
                                        Navigator.pushNamed(
                                          context, '/categoryProducts',
                                          arguments: [
                                            "Edibles",
                                            [
                                              "STIIIZY BATTERY",
                                              "The STIIIZY Battery Starter Kit is your essential power pack, featuring a standard battery, a USB charging cable, and easy charging via any USB port.",
                                              "assets/prod 5.png"
                                            ],
                                            [
                                              "STIIIZY BIIIG BATTERY",
                                              "Experience longer-lasting sessions with the STIIIZY BIIIG Battery, designed for durability and smooth operation. USB charging accessories included.",
                                              "assets/prod 5.png"
                                            ],
                                            [
                                              "STIIIZY PORTABLE POWER CASE",
                                              "Keep your devices powered on-the-go with the sleek STIIIZY Portable Power Case, complete with a USB charging cable and Micro USB Power Adapter.",
                                              "assets/prod 5.png"
                                            ]
                                          ]);
                                  } else if (index == 3) {
                                        Navigator.pushNamed(
                                          context, '/categoryProducts',
                                          arguments: [
                                            "Edibles",
                                            [
                                              "STIIIZY BATTERY",
                                              "The STIIIZY Battery Starter Kit is your essential power pack, featuring a standard battery, a USB charging cable, and easy charging via any USB port.",
                                              "assets/prod 5.png"
                                            ],
                                            [
                                              "STIIIZY BIIIG BATTERY",
                                              "Experience longer-lasting sessions with the STIIIZY BIIIG Battery, designed for durability and smooth operation. USB charging accessories included.",
                                              "assets/prod 5.png"
                                            ],
                                            [
                                              "STIIIZY PORTABLE POWER CASE",
                                              "Keep your devices powered on-the-go with the sleek STIIIZY Portable Power Case, complete with a USB charging cable and Micro USB Power Adapter.",
                                              "assets/prod 5.png"
                                            ]
                                          ]);
                                  } else {
                                        Navigator.pushNamed(
                                          context, '/categoryProducts',
                                          arguments: [
                                            "Edibles",
                                            [
                                              "STIIIZY BATTERY",
                                              "The STIIIZY Battery Starter Kit is your essential power pack, featuring a standard battery, a USB charging cable, and easy charging via any USB port.",
                                              "assets/prod 5.png"
                                            ],
                                            [
                                              "STIIIZY BIIIG BATTERY",
                                              "Experience longer-lasting sessions with the STIIIZY BIIIG Battery, designed for durability and smooth operation. USB charging accessories included.",
                                              "assets/prod 5.png"
                                            ],
                                            [
                                              "STIIIZY PORTABLE POWER CASE",
                                              "Keep your devices powered on-the-go with the sleek STIIIZY Portable Power Case, complete with a USB charging cable and Micro USB Power Adapter.",
                                              "assets/prod 5.png"
                                            ]
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
                                    color: Colors.white,
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
                                          'assets/prod ${index + 1}.png',
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                productNames[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          );
                        }),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Ensures equal spacing
                        children: List.generate(productNames.length, (index) {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  hoverColor: null,
                                  onTap: () {},
                                  onHover: (value) {
                                    ref
                                        .watch(cardScaleStateProvider.notifier)
                                        .changeScale(index);
                                  },
                                  child: ClipRRect(
                                    child: AnimatedContainer(
                                      height: 300,
                                      width: 230,
                                      color: Colors.white,
                                      transformAlignment: Alignment.center,
                                      duration: const Duration(
                                          milliseconds:
                                              700), // Adjust the duration as needed
                                      curve: Curves
                                          .easeInOut, // Adjust the curve as needed
                                      transform: Matrix4.identity()
                                        ..scale(scales[index]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Image.asset(
                                            'assets/prod ${index + 1}.png',
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  productNames[index],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                const SizedBox(height: 100),
                Text(
                  "#1 BRAND IN CALIFORNIA FOR INNOVATIVE CANNABIS PRODUCTS",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "ALTRD specializes in a diverse array of cannabis delights, ranging from gourmet edibles to potent moonrocks, pure resins, and our signature thundersticks. Explore the pinnacle of flavor and effect with our meticulously crafted edibles, indulge in the celestial experience of our premium moonrocks, or dive deep into the essence of cannabis with our rich, aromatic resins. Our thundersticks offer an unparalleled experience, combining innovation and tradition for a truly electrifying session.",
                    style: TextStyle(
                      color: Colors.black,
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
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "ALTRD's edibles redefine the boundaries of taste and potency, offering a gourmet journey through an array of flavors. Each edible is crafted with the finest ingredients and the purest extracts, ensuring a consistent and enjoyable experience. From the subtle elegance of our infused chocolates to the bold burst of our gummy delights, our edibles are designed for discerning palates and refined effects.",
                    style: TextStyle(
                      color: Colors.black,
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
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "Experience the zenith of potency with ALTRD's moonrocks, a harmonious blend of top-shelf flower, golden hash oil, and kief. Each moonrock is a masterpiece of flavor and intensity, designed to elevate your experience to cosmic proportions. Whether enjoyed alone or shared among friends, our moonrocks promise an unforgettable journey.",
                    style: TextStyle(
                      color: Colors.black,
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
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "Dive into the pure essence of cannabis with ALTRD's resins, capturing the full spectrum of cannabinoids and terpenes for an authentic and potent experience. Our thundersticks, a bold fusion of premium flower and concentrate, offer a unique experience that ignites the senses and propels you to new heights. Embrace the power and purity of ALTRD's resins and thundersticks for a transcendent cannabis experience.",
                    style: TextStyle(
                      color: Colors.black,
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
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    onPressed: () {},
                    child: const Text(
                      "Go to Dispensary",
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: 40,
                ),
                FooterWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
