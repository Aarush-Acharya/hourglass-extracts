import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:fineartsociety/pages/indivisual_category_page.dart';
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
    List<String> productNames = [
      "Edibles",
      "Moonrocks",
      "Resins",
      "Thundersticks",
      "Moonrocks"
    ];

    bool isNewReleases = ref.watch(merchTypeStateProvider);
    List scales = ref.watch(cardScaleStateProvider);
    int hoveredIndex = -1;
    var controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: animationProvider);
    var animation = new CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut);
    bool isDesktop = MediaQuery.sizeOf(context).width < 786;
    bool videoInitialised = ref.watch(isVideoInitializedProvider);
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
      ref.read(isVideoInitializedProvider.notifier).changeState();
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double firstFoldHeight = MediaQuery.of(context).size.height * 0.75;
          ScrollController scrollController = ScrollController();
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: firstFoldHeight + 105,
                  child: Stack(
                    children: [
                      Container(
                        height: firstFoldHeight + 80,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment
                                  .centerRight, // Align the image to the right
                              child: ImageFiltered(
                                imageFilter:
                                    ImageFilter.blur(sigmaX: 0, sigmaY: 0),
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
                            ),
                            Align(
                              alignment: Alignment
                                  .centerLeft, // Align the text to the left
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 50), // Adjust padding as needed
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align text to start

                                  children: [
                                    const Text(
                                      "ALTR YOUR LIFESTYLE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 55,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w900),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 500,
                                      child: Text(
                                        "Discover your perfect high with over 100 curated strains, personalized recommendations, and precise weight by the gram - elevating your experience to new heights. Altrd, EST 2021",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500),
                                        softWrap: true,
                                        textAlign: TextAlign
                                            .left, // Align text to left
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    SizedBox(
                                        width: 380,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start, // Align buttons to start
                                          children: [
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    minimumSize:
                                                        const Size(180, 50),
                                                    backgroundColor:
                                                        Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100))),
                                                onPressed: () {},
                                                child: const Text(
                                                  "Shop Menu",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            const SizedBox(
                                                width:
                                                    20), // Add spacing between buttons
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    minimumSize:
                                                        const Size(180, 50),
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100))),
                                                onPressed: () {},
                                                child: const Text(
                                                  "Get Directions",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
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
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                !isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Ensures equal spacing
                        children: List.generate(productNames.length, (index) {
                          return Expanded(
                            child: Column(
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
                                    } else if (index == 3) {
                                    } else {}
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
                            ),
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
                const SizedBox(
                  height: 90,
                ),
                const Text(
                  "Our Stores",
                  style: TextStyle(color: Colors.black, fontSize: 30),
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
                  height: 20,
                ),
                const Text(
                  "Find the nearest ALTRD store now",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                  ),
                  softWrap: true,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Divider(
                  color: Color.fromARGB(112, 255, 255, 255),
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
                            MediaQuery.of(context)
                                .size
                                .height, // Adjusted height
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/stiizy-crop.jpeg'),
                            fit: BoxFit
                                .cover, // Cover the container with the image
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              0), // Padding to create space between the edge of the image and the text container
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(
                                  0.5), // Semi-transparent black background for the text container
                              borderRadius: BorderRadius.circular(
                                  0), // Optional: Adds rounded corners to the text container
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  50), // Padding inside the text container for spacing around the text
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the column vertically
                                children: [
                                  const Text(
                                    "WHAT IS ALTRD?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 55,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700),
                                    softWrap: true,
                                  ),
                                  const SizedBox(height: 40),
                                  SizedBox(
                                    width: 0.41 *
                                        MediaQuery.of(context)
                                            .size
                                            .width, // Width of the text content
                                    child: const Text(
                                      "Change or cause to change in character or composition, typically in a comparatively small but significant way.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                            fit: BoxFit.cover,
                            width:
                                0.4861111111 * MediaQuery.sizeOf(context).width,
                            height: 0.4294478528 *
                                MediaQuery.sizeOf(context).height,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "WHAT IS ALTRD?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                  softWrap: true,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width:
                                      0.41 * MediaQuery.sizeOf(context).width,
                                  child: const Text(
                                    "Started in a garage, ALTRD embodies the spirit of picking yourself up and following opportunity. STIIIZY's proprietary pod system has garnered a cult-like following since its launch and has emerged as a leading lifestyle brand in cannabis.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
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
                  style: TextStyle(color: Colors.black, fontSize: 30),
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
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )),
                    const SizedBox(
                      width: 100,
                    ),
                    TextButton(
                        onPressed: () {
                          ref
                              .read(merchTypeStateProvider.notifier)
                              .changeState(false);
                        },
                        child: const Text("Accessories",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20))),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                isNewReleases
                    ? !isDesktop
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 4",
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
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 4",
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
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 5",
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
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 6",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 4",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          )
                    : !isDesktop
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 7",
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
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 7",
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
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 8",
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
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 9",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 7",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 8",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 9",
                                      style: TextStyle(color: Colors.black),
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.black, // Set the background color to black
                    padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical:
                            20), // Increase the button's size through padding
                    textStyle:
                        TextStyle(fontSize: 20), // Increase the font size
                  ),
                  child: const Text(
                    "All new releases",
                    style: TextStyle(
                        color: Colors
                            .white), // Ensure the text color is white for contrast
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
                Container(
                  height: firstFoldHeight + 180,
                  width: 1440,
                  child: !videoInitialised
                      ? CircularProgressIndicator()
                      : VideoPlayer(
                          videoPlayerController), // Include the video player widget here
                ),
                const SizedBox(
                  height: 50,
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       videoController.play();
                //       videoController.setLooping(true);
                //     },
                //     child: Text("play")),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Blogs",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    // First row of blogs
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Distribute space evenly
                      children: [
                        // Wrap each blog container in a Column to add headings
                        Column(
                          children: [
                            Container(
                              color: Colors.black54,
                              height: 290, // Adjust the height as needed
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      8), // Add some horizontal margin between containers
                              child: Center(
                                child: Image.asset('assets/1.jpeg',
                                    fit: BoxFit.fill), // Your image asset
                              ),
                            ),
                            Text(
                              "Sample Blog Title",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black54,
                                height: 290,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                  child: Image.asset('assets/6.jpeg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Text(
                                "Sample Blog Title",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black54,
                                height: 290,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                  child: Image.asset('assets/2.jpeg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Text(
                                "Sample Blog Title",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20, // Space between the two rows
                    ),
                    // Second row of blogs, structured similarly
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black54,
                                height: 290,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                  child: Image.asset('assets/3.jpeg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Text(
                                "Sample Blog Title",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black54,
                                height: 290,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                  child: Image.asset('assets/4.jpeg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Text(
                                "Sample Blog Title",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black54,
                                height: 290,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                  child: Image.asset(
                                    'assets/5.jpeg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                "Sample Blog Title",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
                            .black), // Ensure the text color is white for visibility
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
                // const SizedBox(height: 50),
                // Text(
                //     'Altrd is a Canadian-based cannabis company that has been in business for over 10 years. We are a')
                FooterWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
