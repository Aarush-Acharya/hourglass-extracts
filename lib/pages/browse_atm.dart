import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../widgets/custom_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/footer_widget.dart';
import 'dart:math' as math;

class BrowseAtm extends ConsumerWidget {
  BrowseAtm({super.key});

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

  List<String> steps = [
    "Insert your Bank Card",
    "Select Cash or Bitcoin",
    "Input your Desired Amount",
    "Enter your KYC Verification ( Bitcoin Only )",
    "Receive your Cash or Bitcoin!"
  ];
  List<String> firstFoldList = ["Australia", "Canada"];
  List<String> secondFoldList = ["Rico", "United States"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      endDrawer: CustomAppBar(),
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double firstFoldHeight =
              MediaQuery.of(context).size.height * 0.9325153374;
          return SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Hero Image
                Container(
                  height: firstFoldHeight,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Hanger DNS Locations Globally",
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 0.025 * MediaQuery.sizeOf(context).height,
                      ),
                      SizedBox(
                        width: 0.7 * MediaQuery.sizeOf(context).width,
                        child: Text(
                          "4361 Locations",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 0.018 * MediaQuery.sizeOf(context).height,
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width > 1000
                                  ? 500
                                  : 0.8 * MediaQuery.sizeOf(context).width,
                              child: TextField(
                                decoration: InputDecoration(
                                  suffixIcon: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.search),
                                      SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  ),
                                  label: const Text('Find Location'),
                                  hintText: 'Enter your search',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Transform.rotate(
                                angle: 45 * math.pi / 180,
                                child: Icon(Icons.navigation_rounded))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0.02 * MediaQuery.sizeOf(context).height,
                      ),
                      Container(
                        height: 0.38 * MediaQuery.sizeOf(context).height,
                        width: 0.87 * MediaQuery.sizeOf(context).width,
                        child: Image.asset(
                          'assets/atm_2.png',
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      SizedBox(
                        height: 0.07 * MediaQuery.sizeOf(context).height,
                      ),
                      ExpansionPanelList(
                          expansionCallback: (int index, bool isExpanded) {
                            print(
                                'Hey bro you just cracked it by clicking ${index + 1}');
                          },
                          children: firstFoldList.map<ExpansionPanel>((data) {
                            return ExpansionPanel(
                                canTapOnHeader: true,
                                backgroundColor: Colors.white,
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  // Your header widget or logic here
                                  return SizedBox(
                                    height: 100,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          data,
                                          style: TextStyle(fontSize: 28),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                body: Text("Hi"));
                          }).toList())
                    ],
                  ),
                ),
                Container(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  child: Column(
                    children: [
                      ExpansionPanelList(
                          expansionCallback: (int index, bool isExpanded) {
                            print(
                                'Hey bro you just cracked it by clicking ${index + 1}');
                          },
                          children: secondFoldList.map<ExpansionPanel>((data) {
                            return ExpansionPanel(
                                canTapOnHeader: true,
                                backgroundColor: Colors.white,
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  // Your header widget or logic here
                                  return SizedBox(
                                    height: 100,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          data,
                                          style: TextStyle(fontSize: 28),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                body: Text("Hi"));
                          }).toList()),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                // 4, Use the FooterWidget here
                FooterWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
