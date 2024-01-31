import 'package:flutter/material.dart';

class CardGrid extends StatelessWidget {
  final List<dynamic> girdData;

  const CardGrid({super.key, required this.girdData});

  @override
  Widget build(BuildContext context) {
    List<String> valuesList = [
      "INFLUENCE",
      "INSPIRE",
      "INNOVATE",
      "WIN",
      "GROW"
    ];
    List<String> valueDescriptionText = [
      "MOTIVATE DESIRED ACTIONS IN OTHERS BY MODELING THE WAY",
      "EMPOWER THOSE AROUND YOU THOUGH POSITIVE TEAMWORK, ACCOUNTABILITY AND TRUST",
      "DRIVE CREATIVITY AND RESOURCEFULLNESS THROUGH COURAGEOUS PROBLEM SOLVING",
      "RELENTLESSLY DRIVE TO EXCEED EXPECTATIONS AND DELIVER RESULTS WITH MAXIMUM URGENCY",
      "PRACTICE GROWTH MINDSET; REMAIN HUMBLE AND CURIOUS TO DEVELOP PROFESSIONALLY AND PERSONALLY"
    ];
    return Container(
      width: 800,
      child: Column(
        children: [
          Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: List.generate(girdData.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: 152,
                    height: 170,
                    color: Color.fromARGB(132, 69, 69, 69),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Text(
                            valuesList[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              'https://placekitten.com/700/500',
                              fit: BoxFit.cover,
                              width: 152,
                              height: 125,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 152,
                    height: 75,
                    color: Color.fromARGB(132, 69, 69, 69),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Center(
                        child: Text(
                          valueDescriptionText[index],
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //     height: 200,
                  //     child: Image.network(
                  //       "https://picsum.photos/600/100",
                  //       fit: BoxFit.fill,
                  //     )),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   girdData[index]["name"],
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.w600),
                  // ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  // Text(
                  //   girdData[index]["description"],
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  // SizedBox(
                  //   child: Text(
                  //     address,
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   girdData[index]["timings"],
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     TextButton(
                  //         style: TextButton.styleFrom(
                  //             minimumSize: Size(200, 55),
                  //             backgroundColor:
                  //                 Color.fromARGB(255, 121, 190, 60),
                  //             shape: RoundedRectangleBorder()),
                  //         onPressed: () {},
                  //         child: Text(
                  //           "Deals",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             letterSpacing: 5,
                  //           ),
                  //         )),
                  //     TextButton(
                  //         style: TextButton.styleFrom(
                  //             minimumSize: Size(200, 55),
                  //             backgroundColor: Color.fromARGB(199, 99, 99, 99),
                  //             shape: RoundedRectangleBorder()),
                  //         onPressed: () {},
                  //         child: Text(
                  //           "View Store",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             letterSpacing: 5,
                  //           ),
                  //         )),
                  //   ],
                  // )
                ],
              );
            }),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
