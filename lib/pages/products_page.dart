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
      "Pre-Rolls": "single_prerolls_blue",
      "Concentrates": "preeroll_pack_blue"
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
                                            "2G Disposable Concentrate Vape",
                                            "assets/disposables.png"
                                          ],
                                        ]);
                                  } else if (index == 2) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Pre-Rolls",
                                          [
                                            "Infused Pre-Roll Indica",
                                            "1G Hourglass Pre Roll Infused with High Quality Concentrates and Rolled in Keef",
                                            "assets/single_prerolls_blue.png"
                                          ],
                                          [
                                            "Infused Pre-Roll Sativa",
                                            "1G Hourglass Pre Roll Infused with High Quality Concentrates and Rolled in Keef",
                                            "assets/single_prerolls_red.png"
                                          ],
                                          [
                                            "Infused Pre-Roll Hybrid",
                                            "1G Hourglass Pre Roll Infused with High Quality Concentrates and Rolled in Keef",
                                            "assets/single_prerolls_yellow.png"
                                          ],
                                          [
                                            "Infused Pre-Roll Pack Indica",
                                            "28 1G Indica Pre-Roll Pack",
                                            "assets/preeroll_pack_blue.png"
                                          ],
                                          [
                                            "Infused Pre-Roll Pack Hybrid",
                                            "28 1G Hybrid Pre-Roll Pack",
                                            "assets/preeroll_pack_yellow.png"
                                          ]
                                        ]);
                                  } else {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Concentrates",
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
                                            "2G Disposable Concentrate Vape",
                                            "assets/disposables.png"
                                          ],
                                        ]);
                                  } else if (index == 2) {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Pre-Rolls",
                                          [
                                            "Infused Pre-Roll Indica",
                                            "1G Hourglass Pre Roll Infused with High Quality Concentrates and Rolled in Keef",
                                            "assets/single_prerolls_blue.png"
                                          ],
                                          [
                                            "Infused Pre-Roll Sativa",
                                            "1G Hourglass Pre Roll Infused with High Quality Concentrates and Rolled in Keef",
                                            "assets/single_prerolls_red.png"
                                          ],
                                          [
                                            "Infused Pre-Roll Hybrid",
                                            "1G Hourglass Pre Roll Infused with High Quality Concentrates and Rolled in Keef",
                                            "assets/single_prerolls_yellow.png"
                                          ],
                                          [
                                            "Infused Pre-Roll Pack Indica",
                                            "28 1G Indica Pre-Roll Pack",
                                            "assets/preeroll_pack_blue.png"
                                          ],
                                          [
                                            "Infused Pre-Roll Pack Hybrid",
                                            "28 1G Hybrid Pre-Roll Pack",
                                            "assets/preeroll_pack_yellow.png"
                                          ]
                                        ]);
                                  } else {
                                    Navigator.pushNamed(
                                        context, '/categoryProducts',
                                        arguments: [
                                          "Concentrates",
                                          [
                                            "Infused Pre-Roll Pack Indica",
                                            "28 1G Indica Pre-Roll Pack",
                                            "assets/preeroll_pack_blue.png"
                                          ],
                                          [
                                            "Infused Pre-Roll Pack Hybrid",
                                            "28 1G Hybrid Pre-Roll Pack",
                                            "assets/preeroll_pack_yellow.png"
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
                SizedBox(
                  height: 50,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: const Size(180, 50),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    onPressed: () {
                      Navigator.pushNamed(context, '/dispensaries');
                    },
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
