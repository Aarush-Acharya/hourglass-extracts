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
      backgroundColor: Colors.black,
      appBar: CustomAppBar(),
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
                  const Text(
                    "Vision and Mission",
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    width: 1000,
                    child: Text(
                      "We are driven by entrepreneurial spirit; guided by an authentic understanding of cannabis and cannabis culture; and committed to social justice. From license acquisition to class leading operations, STIIIZY is singularly focused on creating value for our customers, our investors and our communities..",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
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
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
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
                                                "INCLUSIVITY",
                                                style: TextStyle(
                                                    color: Colors.white,
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
                                                      color: Colors.white,
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
                                              "THE JOURNEY",
                                              style: TextStyle(
                                                  color: Colors.white,
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
                                              "Our culture is constantly evolving and adapting, driven by new innovations and changing attitudes. We're on a journey to overcome the stigma and legal barriers that have historically plagued cannabis use, much like the fight against Prohibition in the early 20th century. We envision a future where cannabis is fully embraced as a positive force for individual and collective well-being.",
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
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
                                    child: Image.network(
                                      'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
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
                                                "HEALING",
                                                style: TextStyle(
                                                    color: Colors.white,
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
                                                      color: Colors.white,
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
                                height: 70,
                              ),
                              const Text(
                                "CORE VALUES",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 42),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              Container(
                                width: 800,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                  child: const Text(
                                      "OUR VISION IS TO BRING CANNABIS CULTURE TO THE WORLD ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 800,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 90.0),
                                    child: const Text(
                                        "OUR PRESUIT OF EXELLENCE DRIVES US TO REVOLUTIONIZE THE CANNABIS INDUSTRY USING CUTTING EDGE TECHNOLOGY TO DELIVER UNPARALLELED PRODUCTS AND SERVICE TO OUR CUSTOMERS",
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CardGrid(girdData: ["a", "e", "i", "o", "u"])
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
