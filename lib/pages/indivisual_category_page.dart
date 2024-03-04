import 'package:fineartsociety/widgets/custom_app_bar.dart';
import 'package:fineartsociety/widgets/footer_widget.dart';
import 'package:flutter/material.dart';

class CategoryProducts extends StatelessWidget {
  CategoryProducts({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic productsData = ModalRoute.of(context)!.settings.arguments!;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(shouldShow: false,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              productsData[0],
              style: TextStyle(
                  color: Colors.black,
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
                                  productsData[index + 1][2],
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
                                          productsData[index + 1][0],
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
                                            productsData[index + 1][1],
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                side: BorderSide(
                                                    color: Colors.black)),
                                            onPressed: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "Get Directions",
                                                style: TextStyle(
                                                  color: Colors.black,
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
                                              color: Colors.black,
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
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                side: BorderSide(
                                                    color: Colors.black)),
                                            onPressed: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "Get Directions",
                                                style: TextStyle(
                                                  color: Colors.black,
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
                                  productsData[index + 1][2],
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
