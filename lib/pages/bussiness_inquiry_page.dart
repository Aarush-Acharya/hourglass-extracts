import 'dart:async';
import 'package:fineartsociety/widgets/custom_app_bar.dart';
import 'package:fineartsociety/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BussinessInquiryPage extends ConsumerWidget {
  const BussinessInquiryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PageController pageViewController = PageController();
    ScrollController scrollController = ScrollController();

    Timer.periodic(const Duration(seconds: 10), (timer) {
      int currentPage = pageViewController.page!.toInt();
      pageViewController.animateToPage(currentPage == 3 ? 0 : currentPage + 1,
          duration: const Duration(seconds: 1), curve: Curves.decelerate);
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar:  CustomAppBar(shouldShow: false,),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // bool isDesktop = MediaQuery.of(context).size.width > 1168;
          return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    "BUSINESS INQUIRY",
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    "Contact Form",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "For business, partnership, or investment inquiries, contact us here.",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "We will get back to you within 24-48 business hours.",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  const SizedBox(
                    width: 700,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 320,
                          child: TextField(
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              label: Text("First Name"),
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                            cursorOpacityAnimates: true,
                          ),
                        ),
                        SizedBox(
                          width: 320,
                          child: TextField(
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              label: Text("Last Name"),
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                            cursorOpacityAnimates: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    width: 700,
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        label: Text("Email"),
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      cursorOpacityAnimates: true,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    width: 700,
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        label: Text("Subject"),
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      cursorOpacityAnimates: true,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    width: 700,
                    child: TextField(
                      maxLines: 3,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        label: Text("Message"),
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      cursorOpacityAnimates: true,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: const Size(700, 55),
                          backgroundColor:
                              const Color.fromARGB(199, 99, 99, 99),
                          shape: const RoundedRectangleBorder()),
                      onPressed: () {},
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 5,
                        ),
                      )),
                  const SizedBox(
                    height: 80,
                  ),
                  FooterWidget()
                ],
              ));
        },
      ),
    );
  }
}
