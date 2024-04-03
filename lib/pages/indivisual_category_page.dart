import 'package:hourglass/widgets/custom_app_bar.dart';
import 'package:hourglass/widgets/footer_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer_altrd.dart';

class CategoryProducts extends StatelessWidget {
  CategoryProducts({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic productsData = ModalRoute.of(context)!.settings.arguments!;
    bool isDesktop = MediaQuery.of(context).size.width > 1168;
    bool shouldShowSideBar = MediaQuery.sizeOf(context).width < 724;
    return Scaffold(
      endDrawer: AltrdDrawer(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        shouldShow: shouldShowSideBar,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                productsData[0],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 60,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(productsData.length - 1, (index) {
                  return isDesktop
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 100),
                          child: index % 2 == 0
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          productsData[index + 1][2],
                                          fit: BoxFit.contain,
                                          width: 700,
                                          height: 500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 120,
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 30),
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  productsData[index + 1][0],
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
                                                    productsData[index + 1][1],
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        side: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                    onPressed: () {},
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        "Get Directions",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          letterSpacing: 5,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 30),
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  productsData[index + 1][0],
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
                                                    productsData[index + 1][1],
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        side: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                    onPressed: () {},
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        "Get Directions",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          letterSpacing: 5,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 120,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          productsData[index + 1][2],
                                          fit: BoxFit.contain,
                                          width: 700,
                                          height: 500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: 120),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    productsData[index + 1][2],
                                    fit: BoxFit.contain,
                                    width: 700,
                                    height: 500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              Text(
                                productsData[index + 1][0],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 35),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SizedBox(
                                width: 400,
                                child: Text(
                                  productsData[index + 1][1],
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      side: BorderSide(color: Colors.white)),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Get Directions",
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 5,
                                      ),
                                    ),
                                  ))
                            ],
                          ));
                }),
              ),
              const SizedBox(
                height: 30,
              ),
              FooterWidget()
            ],
          ),
        ),
      ),
    );
  }
}
