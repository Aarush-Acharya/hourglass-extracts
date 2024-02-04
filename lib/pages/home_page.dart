import 'dart:convert';
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
part 'home_page.g.dart';

@riverpod
class MerchTypeState extends _$MerchTypeState {
  @override
  bool build() => true;

  void changeState(bool newState) {
    state = newState;
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
    bool isNewReleases = ref.watch(merchTypeStateProvider);
    var controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: animationProvider);
    var animation = new CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut);
    bool isDesktop = MediaQuery.sizeOf(context).width < 786;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double firstFoldHeight = MediaQuery.of(context).size.height * 0.75;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: firstFoldHeight + 180,
                  color: Colors.black,
                  child: GFAnimation(
                    turnsAnimation: animation,
                    controller: controller,
                    type: GFAnimationType.scaleTransition,
                    child: Image.network(
                      'https://placekitten.com/800/500',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Products",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 40,
                ),
                !isDesktop
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
                                  style: TextStyle(color: Colors.white),
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
                                  style: TextStyle(color: Colors.white),
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
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            height: 300,
                            width: 250,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(40)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
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
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            height: 300,
                            width: 250,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(40)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
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
                const SizedBox(
                  height: 60,
                ),
                const Divider(
                  color: Color.fromARGB(179, 255, 255, 255),
                ),
                const SizedBox(
                  height: 30,
                ),
                !isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 0.4294478528 *
                                MediaQuery.sizeOf(context).height,
                            width:
                                0.4861111111 * MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "WHAT IS STIIIZY?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                  softWrap: true,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width:
                                      0.41 * MediaQuery.sizeOf(context).width,
                                  child: Text(
                                    "STIIIZY offers a line of premium cannabis products that has set a new industry standard for portability and convenience. STIIIZY's proprietary pod system has garnered a cult-like following since its launch and has emerged as a leading lifestyle brand in cannabis.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 0.4294478528 *
                                MediaQuery.sizeOf(context).height,
                            width:
                                0.4861111111 * MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "WHAT IS STIIIZY?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                  softWrap: true,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width:
                                      0.41 * MediaQuery.sizeOf(context).width,
                                  child: Text(
                                    "STIIIZY offers a line of premium cannabis products that has set a new industry standard for portability and convenience. STIIIZY's proprietary pod system has garnered a cult-like following since its launch and has emerged as a leading lifestyle brand in cannabis.",
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
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  color: Color.fromARGB(179, 255, 255, 255),
                ),
                const SizedBox(
                  height: 50,
                ),
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
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
                const SizedBox(
                  height: 60,
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
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
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
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
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
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
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
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
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
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
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
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
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
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
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
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
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
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
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
                                      style: TextStyle(color: Colors.white),
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
                    child: const Text(
                      "All New Accessories",
                    )),
                const SizedBox(
                  height: 120,
                ),
                Container(
                  height: firstFoldHeight + 180,
                  color: Colors.black,
                  child: GFAnimation(
                    turnsAnimation: animation,
                    controller: controller,
                    type: GFAnimationType.scaleTransition,
                    child: Image.asset(
                      'assets/mygif.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Blogs",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                FutureBuilder(
                    future: readJson(),
                    builder: (context, snapshot) {
                      return BuildBlockGrid(
                        girdData: snapshot.data!,
                        isRectangular: false,
                        isEvent: false,
                      );
                    }),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'Trusted By',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
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
                          autoPlay: true,
                          viewportFraction:
                              constraints.maxWidth <= 600 ? 0.2 : 0.2,
                          enableInfiniteScroll: false,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                FooterWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
