import 'package:flutter/material.dart';

class StoreGrid extends StatelessWidget {
  final List<dynamic> girdData;

  const StoreGrid({super.key, required this.girdData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Set the background color here
      child: Column(
        children: [
          Wrap(
            spacing: 60.0,
            runSpacing: 40.0,
            alignment: WrapAlignment.center,
            children: List.generate(girdData.length, (index) {
              String address = girdData[index]["address"];
              address = address.replaceAll(", ", ", \n");
              return Container(
                  width: 400,
                  height: 552,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 200,
                          child: Image.network(
                            "https://picsum.photos/600/100",
                            fit: BoxFit.fill,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        girdData[index]["name"],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        girdData[index]["description"],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        child: Text(
                          address,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        girdData[index]["timings"],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  minimumSize: Size(200, 55),
                                  backgroundColor:
                                      Color.fromARGB(255, 121, 190, 60),
                                  shape: RoundedRectangleBorder()),
                              onPressed: () {},
                              child: Text(
                                "Deals",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 5,
                                ),
                              )),
                          TextButton(
                              style: TextButton.styleFrom(
                                  minimumSize: Size(200, 55),
                                  backgroundColor:
                                      Color.fromARGB(199, 99, 99, 99),
                                  shape: RoundedRectangleBorder()),
                              onPressed: () {},
                              child: Text(
                                "View Store",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 5,
                                ),
                              )),
                        ],
                      )
                    ],
                  ));
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
