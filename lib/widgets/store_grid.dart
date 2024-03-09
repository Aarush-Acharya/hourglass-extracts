import 'package:flutter/material.dart';
import 'package:fineartsociety/pages/dispensaries_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreGrid extends ConsumerWidget {
  final List<dynamic> girdData;
  final ScrollController scrollController;
  final List<LatLng> stores;

  const StoreGrid(
      {super.key,
      required this.girdData,
      required this.scrollController,
      required this.stores});

  @override
  Widget build(BuildContext contex, WidgetRef ref) {
    GoogleMapController? mapController = ref.watch(mapControllerProvider);
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
              return Container(
                  width: 400,
                  height: 552,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 200,
                          child: Image.asset(
                            'assets/p${index + 1}.png',
                            fit: BoxFit.cover,
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
                        width: 300,
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
                              onPressed: () {
                                scrollController.animateTo(50,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                                mapController!.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: stores[index], zoom: 14)));
                              },
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
