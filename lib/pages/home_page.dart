import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
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
class CardDimensionState extends _$CardDimensionState {
  @override
  List build() => [false, false, false];

  void changeState(int index) {
    state = state
        .asMap()
        .map<int, bool>((currentIndex, value) {
          if (currentIndex == index) {
            return MapEntry(currentIndex, !value);
          } else {
            return MapEntry(currentIndex, value);
          }
        })
        .values
        .toList();
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
  VideoPlayerController videoController =
      VideoPlayerController.asset('assets/altrd-vid.mp4')
        ..initialize()
        ..play()
        ..setLooping(true);

  // bool checkState
  Future<List<dynamic>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/artists_data.json');
    var data = await json.decode(response);
    List<dynamic> artists = data['artists'];
    // final List<String> productNames = [
    //   "Edibles", "Moonrocks", "Resins", "Thundersticks",
    //   "Moonrocks" // Example product names
    // ];
    List<dynamic> featuredArtists = artists.where((item) {
      return item['featured'] == true;
    }).toList();
    print(featuredArtists);
    return featuredArtists;
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
    List dimensions = ref.watch(cardDimensionStateProvider);
    int hoveredIndex = -1;
    var controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: animationProvider);
    var animation = new CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut);
    bool isDesktop = MediaQuery.sizeOf(context).width < 786;

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
                  "Explore our products",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                // const SizedBox(
                //   height: 60,
                // ),
                !isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Ensures equal spacing
                        children: List.generate(productNames.length, (index) {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MouseRegion(
                                  onEnter: (_) => ref
                                      .read(hoveredIndexProvider.notifier)
                                      .state = index,
                                  onExit: (_) => ref
                                      .read(hoveredIndexProvider.notifier)
                                      .state = null,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    transform: Matrix4.identity()
                                      ..scale(
                                          hoveredIndex == index ? 1.1 : 1.0),
                                    child: Image.asset(
                                      'assets/prod ${index + 1}.png',
                                      fit: BoxFit.contain,
                                      width: MediaQuery.of(context).size.width /
                                          4.5, // Adjusted for larger images
                                      height:
                                          MediaQuery.of(context).size.width /
                                              4.5 /
                                              2, // Maintain aspect ratio
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
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
                    : // Your code for isDesktop = true

                    Column(
                        children: [
                          Container(
                            height: 450,
                            width: 290,
                            decoration: BoxDecoration(
                                color: Color(0xffe4e3ce),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Image.asset(
                                  'assets/prod 1.png',
                                  fit: BoxFit.contain,
                                  height: 450,
                                  width: 290,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Edibles",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Container(
                              height: 400,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Color(0xffe4e3ce),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Image.asset(
                                    'assets/prod 2.png',
                                    fit: BoxFit.contain,
                                    width: 250,
                                    height: 200,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child: const Text(
                                      "Moonrocks",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // TextButton(
                                  //     style: TextButton.styleFrom(
                                  //         minimumSize: Size(170, 45),
                                  //         shape: RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(100)),
                                  //         backgroundColor: Color(0xff22362b)),
                                  //     onPressed: () {},
                                  //     child: Text(
                                  //       "Shop Now",
                                  //       style: TextStyle(color: Colors.white),
                                  //     ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 400,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Image.asset(
                                  'assets/prod 3.png',
                                  fit: BoxFit.contain,
                                  width: 250,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Resins",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 400,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 6, 6, 6),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Image.asset(
                                  'assets/prod 4.png',
                                  fit: BoxFit.contain,
                                  width: 250,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Thundersticks",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 60,
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/mep2.jpeg'),
                      fit: BoxFit.cover, // Cover the container with the image
                    ),
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
                  height: 20,
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
                    primary: Colors.black, // Set the background color to black
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
                  child: videoController.value.isInitialized
                      ? Text("Not initialised")
                      : VideoPlayer(videoController), // Include the video player widget here
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
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black54,
                                height: 300, // Adjust the height as needed
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        8), // Add some horizontal margin between containers
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/Altrd Cannabis Asset.svg'), // Your image asset
                                ),
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing",
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
                                height: 300,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/Altrd Cannabis Asset.svg'),
                                ),
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing",
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
                                height: 300,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/Altrd Cannabis Asset.svg'),
                                ),
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing",
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
                                height: 300,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/Altrd Cannabis Asset.svg'),
                                ),
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing",
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
                                height: 300,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/Altrd Cannabis Asset.svg'),
                                ),
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing",
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
                                height: 300,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/Altrd Cannabis Asset.svg'),
                                ),
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing",
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
                  height: 40,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 5),
                    // Removed Expanded widget from here
                    GridView.builder(
                      shrinkWrap:
                          true, // Allow the GridView to determine its own height
                      physics:
                          const NeverScrollableScrollPhysics(), // Essential for use in a SingleChildScrollView
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            12, // Adjust the number of logos per row as needed
                        childAspectRatio:
                            1, // Maintain the aspect ratio of the logos
                        crossAxisSpacing: 0, // Remove spacing between columns
                        mainAxisSpacing: 0, // Remove spacing between rows
                      ),
                      itemCount: 48, // Total number of logos
                      itemBuilder: (context, index) {
                        String imagePath = 'assets/press${(index % 3) + 1}.png';
                        return Image.asset(
                          imagePath,
                          fit: BoxFit.cover, // Cover the grid cell completely
                        );
                      },
                    ),
                  ],
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

class VideoPlayerWidget extends StatefulWidget {
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/altrd-vid.mp4')
      ..initialize().then((_) {
        setState(() {}); // Trigger a rebuild once the video is initialized
        print("Video initialized");
      }).catchError((error) {
        print("Error initializing video player: $error");
      });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is removed from the widget tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if the video controller has initialized
    if (_controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio:
            _controller.value.aspectRatio, // Use the aspect ratio of the video
        child: VideoPlayer(_controller), // Display the video player
      );
    } else {
      // If not initialized, show a loading spinner
      return Center(child: CircularProgressIndicator());
    }
  }
}
