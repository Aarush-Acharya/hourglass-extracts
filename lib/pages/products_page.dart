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
    var controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: animationProvider);
    var animation = new CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut);

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
                SizedBox(
                  height: 100,
                ),
                Row(
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
                ),
                const SizedBox(height: 100),
                Text(
                  "#1 BRAND IN CALIFORNIA FOR PREMIUM CHOCOLATE DELIGHTS",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "STIIIZY's range encompasses cutting-edge chocolate experiences to artisanal confectionery delights. Dive into our innovative chocolate creations, featuring the exquisite STIIIZY Chocolate Bar and the indulgent BIIIG Truffle Collection, paired with a convenient treat carrier for uninterrupted enjoyment.",
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
                  "PROD 1:",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "Our Original Cocoa Pods, boasting naturally derived cocoa profiles, set the industry benchmark with their consistent aroma and taste. For a more authentic chocolate touch, our Cocoa-Derived Bliss Pods are extracted from local, single-sourced cacao plants, ensuring a perfect blend of flavor and richness. Immerse yourself in full-spectrum chocolate delight with our Live Cocoa Pods, harvested at their peak and flash-frozen. Take your chocolate experience to new heights with our Liquid Cocoa Diamonds Pods, blending high cocoa potency and true chocolate flavor for a luxurious, melt-in-your-mouth experience. For the chocolate purists, our Solventless Live Cocoa Pods deliver the essence of the cocoa bean in its purest form. Experience on-the-go chocolate convenience with our All-in-One Cocoa Pens and LIIIL disposable cocoa pens, seamlessly combining portability and premium quality for chocolate pleasure anytime, anywhere.",
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
                  "PROD 2:",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "Our Original Cocoa Pods, boasting naturally derived cocoa profiles, set the industry benchmark with their consistent aroma and taste. For a more authentic chocolate touch, our Cocoa-Derived Bliss Pods are extracted from local, single-sourced cacao plants, ensuring a perfect blend of flavor and richness. Immerse yourself in full-spectrum chocolate delight with our Live Cocoa Pods, harvested at their peak and flash-frozen. Take your chocolate experience to new heights with our Liquid Cocoa Diamonds Pods, blending high cocoa potency and true chocolate flavor for a luxurious, melt-in-your-mouth experience. For the chocolate purists, our Solventless Live Cocoa Pods deliver the essence of the cocoa bean in its purest form. Experience on-the-go chocolate convenience with our All-in-One Cocoa Pens and LIIIL disposable cocoa pens, seamlessly combining portability and premium quality for chocolate pleasure anytime, anywhere.",
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
                  "PROD 3:",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 1000,
                  child: Text(
                    "Our Original Cocoa Pods, boasting naturally derived cocoa profiles, set the industry benchmark with their consistent aroma and taste. For a more authentic chocolate touch, our Cocoa-Derived Bliss Pods are extracted from local, single-sourced cacao plants, ensuring a perfect blend of flavor and richness. Immerse yourself in full-spectrum chocolate delight with our Live Cocoa Pods, harvested at their peak and flash-frozen. Take your chocolate experience to new heights with our Liquid Cocoa Diamonds Pods, blending high cocoa potency and true chocolate flavor for a luxurious, melt-in-your-mouth experience. For the chocolate purists, our Solventless Live Cocoa Pods deliver the essence of the cocoa bean in its purest form. Experience on-the-go chocolate convenience with our All-in-One Cocoa Pens and LIIIL disposable cocoa pens, seamlessly combining portability and premium quality for chocolate pleasure anytime, anywhere.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'https://placekitten.com/600/400',
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "PickUp",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'https://placekitten.com/600/400',
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Delivery",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
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
