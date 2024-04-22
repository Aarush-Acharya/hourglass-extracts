import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:hourglass/pages/indivisual_category_page.dart';
import 'package:hourglass/widgets/drawer_altrd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovering/hovering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:video_player/video_player.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/blocks_grid.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/footer_widget.dart';
part 'home_page.g.dart';

final hoveredIndexProvider =
    StateProvider<int?>((ref) => null); // Initially, no item is hovered

@riverpod
class MerchTypeState extends _$MerchTypeState {
  @override
  bool build() => true;

  void changeState(bool newState) {
    state = newState;
  }
}

@riverpod
class CardScaleState extends _$CardScaleState {
  @override
  List<double> build() => [1, 1, 1, 1, 1];

  void changeScale(int index) {
    state = state
        .asMap()
        .map<int, double>((currentIndex, value) {
          if (currentIndex == index) {
            return MapEntry(currentIndex, value == 1.3 ? 1 : 1.3);
          } else {
            return MapEntry(currentIndex, value);
          }
        })
        .values
        .toList();
  }
}

@riverpod
class IsVideoInitialized extends _$IsVideoInitialized {
  @override
  bool build() => false;

  void changeState() {
    state = true;
  }
}

class MyAnimationProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'ticker');
  }
}

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  final MyAnimationProvider animationProvider = MyAnimationProvider();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // bool checkState
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

  Set<Marker> stores = {
    Marker(
        markerId: MarkerId("first"), position: LatLng(35.503120, -97.565740)),
    Marker(
        markerId: MarkerId("second"), position: LatLng(35.552740, -97.626120)),
    Marker(
        markerId: MarkerId("third"), position: LatLng(35.636810, -97.565740)),
  };

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(35.503120, -97.565740),
    zoom: 10,
  );

  onMapCreate(GoogleMapController controller) {
    _controller.complete(controller);
    controller.setMapStyle('''[
    {
        "featureType": "all",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "saturation": 36
            },
            {
                "color": "#dedede"
            },
            {
                "lightness": 40
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "visibility": "off"
            },
            {
                "color": "#000000"
            },
            {
                "lightness": 16
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 20
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 17
            },
            {
                "weight": 1.2
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 20
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 21
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#000000"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "weight": "10.00"
            },
            {
                "invert_lightness": true
            },
            {
                "gamma": "7.24"
            },
            {
                "lightness": "60"
            },
            {
                "saturation": "66"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "color": "#ffffff"
            },
            {
                "invert_lightness": true
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "poi.attraction",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.business",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.government",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.medical",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.park",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.place_of_worship",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.school",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#d2cece"
            },
            {
                "invert_lightness": true
            },
            {
                "weight": "10.00"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#ffffff"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "labels.text",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#ff0000"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "gamma": "10.00"
            },
            {
                "invert_lightness": true
            },
            {
                "weight": "10.00"
            },
            {
                "color": "#ffffff"
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "weight": "5.10"
            },
            {
                "gamma": "0.00"
            },
            {
                "hue": "#ff0000"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#393939"
            },
            {
                "lightness": 17
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 29
            },
            {
                "weight": 0.2
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#1c1c1c"
            },
            {
                "lightness": 18
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#343434"
            },
            {
                "lightness": 16
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 19
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 17
            }
        ]
    }
]''');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool shouldShowSideBar = MediaQuery.sizeOf(context).width < 724;

    List scales = ref.watch(cardScaleStateProvider);
    int hoveredIndex = -1;
    var controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: animationProvider);
    var animation = new CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut);
    bool isDesktop = MediaQuery.sizeOf(context).width < 786;

    VideoPlayerController videoPlayerController =
        VideoPlayerController.asset('assets/altrd-vid.mp4');

    videoPlayerController.initialize().then((_) {
      // Initialization completed, now start playing
      videoPlayerController.play();
    }).then((_) {
      // Play has started, now set looping
      videoPlayerController.setLooping(true);
    }).then((_) {
      // Looping has been set, now print and notify
      print("heyy");
      // Assuming ref is a reference to something, you can notify here
      ref.watch(isVideoInitializedProvider.notifier).changeState();
    });
    bool isNewReleases = ref.watch(merchTypeStateProvider);
    bool videoInitialised = ref.watch(isVideoInitializedProvider);
    double firstFoldHeight = MediaQuery.of(context).size.height * 0.75;
    ScrollController scrollController = ScrollController();
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
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: firstFoldHeight + 105,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: firstFoldHeight + 80,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: GFAnimation(
                              turnsAnimation: animation,
                              controller: controller,
                              type: GFAnimationType.scaleTransition,
                              child: Image.asset(
                                'assets/people_adventure.jpeg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 70.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        minimumSize: const Size(180, 50),
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100))),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/products');
                                    },
                                    child: const Text(
                                      "Explore Products",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                const SizedBox(
                                    width: 20), // Add spacing between buttons
                                TextButton(
                                    style: TextButton.styleFrom(
                                        minimumSize: const Size(180, 50),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(100))),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "/dispensaries");
                                    },
                                    child: const Text(
                                      "Get Directions",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: RippleAnimation(
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         scrollController.animateTo(
                    //             scrollController.offset + 730,
                    //             duration: const Duration(seconds: 1),
                    //             curve: Curves.easeInOut);
                    //       },
                    //       child: const CircleAvatar(
                    //         backgroundColor: Color.fromARGB(173, 65, 64, 64),
                    //         radius: 20,
                    //         child: Center(
                    //           child: Icon(
                    //             Icons.keyboard_arrow_down_rounded,
                    //             color: Colors.white,
                    //             size: 30,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     color: const Color.fromARGB(178, 30, 231, 100),
                    //     delay: const Duration(milliseconds: 500),
                    //     repeat: true,
                    //     minRadius: 30,
                    //     ripplesCount: 0,
                    //     duration: const Duration(seconds: 2),
                    //   ),
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Explore Our Products",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              !isDesktop
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
              const SizedBox(
                height: 90,
              ),
              const Text(
                "Our Stores",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // Full width of the screen
                height: 0.4294478528 *
                    MediaQuery.of(context).size.height, // Adjusted height
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage('assets/mep2.jpeg'),
                //     fit: BoxFit.cover, // Cover the container with the image
                //   ),
                // ),
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: onMapCreate,
                  markers: stores,
                ),
              ),
              // const SizedBox(
              //   height: 50,
              // ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      side: BorderSide(color: Colors.amber)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/dispensaries');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 0 : 20, vertical: 10),
                    child: const Text(
                      "Find the nearest Hourglass Retailer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              // const SizedBox(
              //   height: 100,
              // ),
              !isDesktop
                  ? Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Full width of the screen
                      height: 0.4294478528 *
                          MediaQuery.of(context).size.height, // Adjusted height
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/hourglass.jpeg'),
                          fit: BoxFit
                              .cover, // Cover the container with the image
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/stiizy.jpeg',
                          fit: BoxFit.fill,
                          width: 1440,
                          height: 200,
                        ),
                      ],
                    ),
              // const SizedBox(
              //   height: 100,
              // ),
              // const Divider(
              //   color: Colors.black,
              // ),
              const SizedBox(
                height: 80,
              ),
              const Text(
                "Merch",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(
                height: 60,
              ),
              !isDesktop
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(40)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/indivisualMerchPage', arguments: [
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
                                  borderRadius: BorderRadius.circular(50),
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
                                  style: TextStyle(color: Colors.white),
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
                              borderRadius: BorderRadius.circular(40)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/indivisualMerchPage', arguments: [
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
                                  borderRadius: BorderRadius.circular(50),
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
                                  style: TextStyle(color: Colors.white),
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
                              borderRadius: BorderRadius.circular(40)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/indivisualMerchPage', arguments: [
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
                                  borderRadius: BorderRadius.circular(50),
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
                                  style: TextStyle(color: Colors.white),
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
                              borderRadius: BorderRadius.circular(40)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/indivisualMerchPage', arguments: [
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
                                  borderRadius: BorderRadius.circular(50),
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
                                  style: TextStyle(color: Colors.white),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(40)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/indivisualMerchPage', arguments: [
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
                                  borderRadius: BorderRadius.circular(50),
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
                                  style: TextStyle(color: Colors.white),
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
                              borderRadius: BorderRadius.circular(40)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/indivisualMerchPage', arguments: [
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
                                  borderRadius: BorderRadius.circular(50),
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
                                  style: TextStyle(color: Colors.white),
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
                              borderRadius: BorderRadius.circular(40)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/indivisualMerchPage', arguments: [
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
                                  borderRadius: BorderRadius.circular(50),
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
                                  style: TextStyle(color: Colors.white),
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
                              borderRadius: BorderRadius.circular(40)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/indivisualMerchPage', arguments: [
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
                                  borderRadius: BorderRadius.circular(50),
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
                                  style: TextStyle(color: Colors.white),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/merch');
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.amber),
                  backgroundColor:
                      Colors.black, // Set the background color to black
                  padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical:
                          20), // Increase the button's size through padding
                  textStyle: TextStyle(fontSize: 20), // Increase the font size
                ),
                child: const Text(
                  "Show More",
                  style: TextStyle(
                      color: Colors
                          .white), // Ensure the text color is white for contrast
                ),
              ),
              isDesktop
                  ? SizedBox()
                  : SizedBox(
                      height: 40,
                    ),
              Container(
                height: isDesktop ? 400 : firstFoldHeight + 180,
                width: 1440,
                child: !videoInitialised
                    ? CircularProgressIndicator()
                    : VideoPlayer(
                        videoPlayerController), // Include the video player widget here
              ),
              isDesktop
                  ? SizedBox()
                  : SizedBox(
                      height: 40,
                    ),
              const Text(
                "Blogs",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(
                height: 50,
              ),
              Wrap(
                spacing: 20,
                runSpacing: 50,
                alignment: WrapAlignment.center,
                children: List.generate(
                  6,
                  (index) => Column(
                    children: [
                      Container(
                        color: Colors.black54,
                        width: 400, // Adjust the height as needed
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                8), // Add some horizontal margin between containers
                        child: Center(
                          child: Image.asset('assets/${index + 1}.jpeg',
                              fit: BoxFit.fill), // Your image asset
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sample Blog Title",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 100,
              ),
              const Center(
                child: Text(
                  'Our partners',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors
                          .white), // Ensure the text color is white for visibility
                ),
              ),
              Center(
                child: SizedBox(
                    height: 250,
                    width: 400,
                    child: Image.asset("assets/mango-cannabis-logo.jpeg")),
              ),
              SizedBox(
                height: 50,
              ),
              FooterWidget(),
            ],
          ),
        ));
  }
}
