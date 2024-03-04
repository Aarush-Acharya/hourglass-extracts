import 'dart:async';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:fineartsociety/widgets/card_grid.dart';
import 'package:fineartsociety/widgets/custom_app_bar.dart';
import 'package:fineartsociety/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PageController pageViewController = PageController();
    ScrollController scrollController = ScrollController();

    Timer.periodic(const Duration(seconds: 10), (timer) {
      int currentPage = pageViewController.page!.toInt();
      pageViewController.animateToPage(currentPage == 3 ? 0 : currentPage + 1,
          duration: const Duration(seconds: 1), curve: Curves.decelerate);
    });

    List<String> urls = [
      "https://placekitten.com/1440/500",
      "https://placekitten.com/1440/600",
      "https://placekitten.com/1440/700"
    ];
    IndexController _controller = IndexController();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(shouldShow: false,),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = MediaQuery.of(context).size.width > 1168;
          return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, top: 60, bottom: 60),
                    child: isDesktop
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        'assets/stiizy.jpeg',
                                        fit: BoxFit.cover,
                                        width: 700,
                                        height: 500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 120,
                                  ),
                                  const Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 30),
                                        child: SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Vision Statement",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 35),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              SizedBox(
                                                width: 400,
                                                child: Text(
                                                  "At ALTRD, we're dedicated to crafting premium cannabis products and experiences that fuel the adventurous spirit within us all. Through innovation, creativity, and a commitment to quality, we strive to inspire individuals to embrace life's journeys, explore new horizons, and celebrate every moment with boldness and authenticity.",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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
                                              "Mission Statement",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 40),
                                              softWrap: true,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          SizedBox(
                                            width: 400,
                                            child: Text(
                                              "ALTRD thrives on adventure, pushing boundaries, and living life to the fullest. Our culture is built on a foundation of passion, exploration, and a shared love for the extraordinary. We embrace the thrill of the unknown and encourage our community to seek out new experiences, forge meaningful connections, and create unforgettable memories. With a focus on style and sophistication, we embody the essence of modern cannabis culture, where every moment is an opportunity to elevate your lifestyle and embrace the extraordinary.",
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        'assets/abt-1.png',
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      'assets/abt-2.png',
                                      fit: BoxFit.cover,
                                      width: 700,
                                      height: 500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 120,
                                  ),
                                  const Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 30),
                                        child: SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Brand Culture",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 35),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              SizedBox(
                                                width: 400,
                                                child: Text(
                                                  "Cannabis culture is a vibrant and diverse community that welcomes individuals from all walks of life - whether you're a skater, an elderly person, a college student, a veteran, or a family member. We take pride in creating an inclusive environment that encourages everyone to express themselves freely. Our culture fosters unity and promotes open and honest dialogue, bringing together people from different backgrounds and experiences.",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              const Text(
                                "DARE TO REDEFINE.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 42),
                              ),
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
                                    color: Colors.white, fontSize: 40),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              const Text(
                                "DATE/TIME",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "LOCATION",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "DESCRIPTION",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
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
