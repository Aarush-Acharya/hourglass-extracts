import 'package:fineartsociety/widgets/custom_app_bar.dart';
import 'package:fineartsociety/widgets/footer_widget.dart';
import 'package:flutter/material.dart';

class CategoryProducts extends StatelessWidget {
  List productsData = ["EDIBLES", [], "hi", "hi"];
  CategoryProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
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
                return Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: index % 2 == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  'assets/abt-1.png',
                                  fit: BoxFit.cover,
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
                                          "KIND, BUT NOT WEAK",
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
                                        SizedBox(
                                          height: 40,
                                        ),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                side: BorderSide(
                                                    color: Colors.white)),
                                            onPressed: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                          "KIND, BUT NOT WEAK",
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
                                        SizedBox(
                                          height: 40,
                                        ),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                side: BorderSide(
                                                    color: Colors.white)),
                                            onPressed: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                  borderRadius: BorderRadius.circular(40)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  'assets/abt-1.png',
                                  fit: BoxFit.cover,
                                  width: 700,
                                  height: 500,
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            FooterWidget()
          ],
        ),
      ),
    );
  }
}
