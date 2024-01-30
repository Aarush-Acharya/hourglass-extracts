import 'dart:async';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fineartsociety/widgets/custom_app_bar.dart';
import 'package:fineartsociety/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PageController pageViewController = PageController();
    double firstFoldHeight = MediaQuery.of(context).size.height * 0.75;
    ScrollController scrollController = ScrollController();

    Timer.periodic(Duration(seconds: 10), (timer) {
      int currentPage = pageViewController.page!.toInt();
      pageViewController.animateToPage(currentPage == 3 ? 0 : currentPage + 1,
          duration: Duration(seconds: 1), curve: Curves.decelerate);
    });

    List<String> urls = [
      "https://placekitten.com/1440/500",
      "https://placekitten.com/1440/600",
      "https://placekitten.com/1440/700"
    ];
    IndexController _controller = IndexController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = MediaQuery.of(context).size.width > 1168;
          return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  const Text(
                    "Vision and Mission",
                    style: TextStyle(color: Colors.black, fontSize: 35),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 1000,
                    child: const Text(
                      "We are driven by entrepreneurial spirit; guided by an authentic understanding of cannabis and cannabis culture; and committed to social justice. From license acquisition to class leading operations, STIIIZY is singularly focused on creating value for our customers, our investors and our communities..",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16),
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
                                    height: 500,
                                    width: 700,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                "http://placekitten.com/g/900/700")),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                  const SizedBox(
                                    width: 120,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        child: SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "INCLUSIVITY",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 35),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              SizedBox(
                                                width: 400,
                                                child: const Text(
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
                                            child: const Text(
                                              "Our culture is constantly evolving and adapting, driven by new innovations and changing attitudes. We're on a journey to overcome the stigma and legal barriers that have historically plagued cannabis use, much like the fight against Prohibition in the early 20th century. We envision a future where cannabis is fully embraced as a positive force for individual and collective well-being.",
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 500,
                                      width: 700,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  "http://placekitten.com/g/900/500")),
                                          borderRadius:
                                              BorderRadius.circular(30)),
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
                                  Container(
                                    height: 500,
                                    width: 700,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                "http://placekitten.com/g/900/600")),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                  const SizedBox(
                                    width: 120,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        child: SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "HEALING",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 35),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              SizedBox(
                                                width: 400,
                                                child: const Text(
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
                                    color: Colors.black, fontSize: 40),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              const Text(
                                "DATE/TIME",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "LOCATION",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "DESCRIPTION",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 23),
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
