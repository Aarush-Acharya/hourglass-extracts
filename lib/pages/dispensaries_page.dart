import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:hourglass/widgets/drawer_altrd.dart';
import 'package:hourglass/widgets/store_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';
import 'dart:math' as math;
part 'dispensaries_page.g.dart';

class CheckBoxStates {
  CheckBoxStates({required this.state1, required this.state2});
  bool state1;
  bool state2;
}

@riverpod
class Value extends _$Value {
  @override
  CheckBoxStates build() => CheckBoxStates(state1: false, state2: false);

  void changeState(int index) {
    if (index == 0) {
      state = CheckBoxStates(state1: !state.state1, state2: state.state2);
    } else {
      state = CheckBoxStates(state1: state.state1, state2: !state.state2);
    }
  }
}

@riverpod
class PolylineState extends _$PolylineState {
  @override
  Set<Polyline> build() => <Polyline>{};

  void addPolyline(Polyline newPolyline) {
    state = {...state, newPolyline};
  }
}

@riverpod
class IsTappedState extends _$IsTappedState {
  @override
  bool build() => false;

  void changeState() {
    state = !state;
  }
}

class IsExpandedValues {
  IsExpandedValues(
      {required this.isExpanded1,
      required this.isExpanded2,
      required this.isExpanded3,
      required this.isExpanded4});
  bool isExpanded1;
  bool isExpanded2;
  bool isExpanded3;
  bool isExpanded4;
}

@riverpod
class MapController extends _$MapController {
  @override
  GoogleMapController? build() => null;

  void addvalue(GoogleMapController controller) {
    state = controller;
  }
}

@riverpod
class IsExpandedValueStates extends _$IsExpandedValueStates {
  @override
  IsExpandedValues build() => IsExpandedValues(
      isExpanded1: false,
      isExpanded2: false,
      isExpanded3: false,
      isExpanded4: false);

  void changeState(int index) {
    if (index == 0) {
      state = IsExpandedValues(
          isExpanded1: !state.isExpanded1,
          isExpanded2: false,
          isExpanded3: false,
          isExpanded4: false);
    } else if (index == 1) {
      state = IsExpandedValues(
          isExpanded1: false,
          isExpanded2: !state.isExpanded2,
          isExpanded3: false,
          isExpanded4: false);
    } else if (index == 2) {
      state = IsExpandedValues(
          isExpanded1: false,
          isExpanded2: false,
          isExpanded3: !state.isExpanded3,
          isExpanded4: false);
    } else {
      state = IsExpandedValues(
        isExpanded1: false,
        isExpanded2: false,
        isExpanded3: false,
        isExpanded4: !state.isExpanded4,
      );
    }
  }
}

class MyAnimationProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'ticker');
  }
}

class DispensariesScreen extends ConsumerWidget {
  DispensariesScreen({super.key});

  Future<List<dynamic>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/artists_data.json');
    var data = await json.decode(response);
    List<dynamic> artists = data['artists'];

    List<dynamic> featuredArtists = artists.where((item) {
      return item['featured'] == true;
    }).toList();
    print(featuredArtists);
    return featuredArtists;
  }

  List<dynamic> storeData = [
    [
      {
        "name": "Mango Cannabis, May Ave",
        "description":
            "Immerse yourself in the energy of New York at Hourglass, a coffee destination in the city that never sleeps.",
        "address": "3301 N May Ave, Oklahoma City, OK 73112, United States",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Mango Cannabis, NW EXPY",
        "description":
            "Discover the flavors of San Francisco at Hourglass, where artisanal coffee meets breathtaking views.",
        "address":
            "6201 Northwest Expy, Oklahoma City, OK 73132, United States",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Mango Cannabis, Edmond",
        "description":
            "Chicago's coffee gem – Hourglass Chicago, where quality meets comfort in every cup served.",
        "address":
            "16309 N Santa Fe Ave STE B, Edmond, OK 73013, United States",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
    ],
  ];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  ScrollController scrollController = ScrollController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(35.503120, -97.565740),
    zoom: 10,
  );

  int count = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MyAnimationProvider animationProvider = MyAnimationProvider();
    CheckBoxStates state = ref.watch(valueProvider);

    Set<Marker> stores = {
      Marker(
        onTap: () {
          ref.watch(isTappedStateProvider.notifier).changeState();
        },
        consumeTapEvents: true,
        markerId: MarkerId("first"),
        position: LatLng(35.503120, -97.565740),
        infoWindow: InfoWindow(
            onTap: () {
              print("hi");
            },
            title: "Mango Cannabis, May Ave",
            snippet: "35.503120, -97.565740"),
      ),
      Marker(
          onTap: () {
            ref.watch(isTappedStateProvider.notifier).changeState();
          },
          markerId: MarkerId("second"),
          position: LatLng(35.552740, -97.626120),
          infoWindow: InfoWindow(
              title: "Mango Cannabis, NW EXPY",
              snippet: "35.552740, -97.626120")),
      Marker(
          onTap: () {
            ref.watch(isTappedStateProvider.notifier).changeState();
          },
          markerId: MarkerId("third"),
          position: LatLng(35.636810, -97.565740),
          infoWindow: InfoWindow(
              title: "Mango Cannabis, Edmond",
              snippet: "35.636810, -97.565740")),
    };

    bool isTapped = ref.watch(isTappedStateProvider);
    IsExpandedValues isExpandedValueStates =
        ref.watch(isExpandedValueStatesProvider);
    Set<Polyline> polylines = ref.watch(polylineStateProvider);

    Map<String, dynamic> firstFoldList = {
      "Oklahoma": [isExpandedValueStates.isExpanded1, 0],
    };
    onMapCreate(GoogleMapController controller) {
      ref.watch(mapControllerProvider.notifier).addvalue(controller);
      _controller.complete(controller);

      controller.setMapStyle('''[
    {
        "featureType": "all",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "saturation": 36
            },
            {
                "color": "#dedede"
            },
            {
                "lightness": 40
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "visibility": "off"
            },
            {
                "color": "#000000"
            },
            {
                "lightness": 16
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 20
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 17
            },
            {
                "weight": 1.2
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 20
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 21
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#000000"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "weight": "10.00"
            },
            {
                "invert_lightness": true
            },
            {
                "gamma": "7.24"
            },
            {
                "lightness": "60"
            },
            {
                "saturation": "66"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "color": "#ffffff"
            },
            {
                "invert_lightness": true
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "poi.attraction",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.business",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.government",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.medical",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.park",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.place_of_worship",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.school",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#d2cece"
            },
            {
                "invert_lightness": true
            },
            {
                "weight": "10.00"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#ffffff"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "labels.text",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#ff0000"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "gamma": "10.00"
            },
            {
                "invert_lightness": true
            },
            {
                "weight": "10.00"
            },
            {
                "color": "#ffffff"
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.sports_complex",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "weight": "5.10"
            },
            {
                "gamma": "0.00"
            },
            {
                "hue": "#ff0000"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#393939"
            },
            {
                "lightness": 17
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 29
            },
            {
                "weight": 0.2
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#1c1c1c"
            },
            {
                "lightness": 18
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#343434"
            },
            {
                "lightness": 16
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 19
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 17
            }
        ]
    }
]''');
    }

    double firstFoldHeight = MediaQuery.of(context).size.height * 0.6;
    var controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: animationProvider);
    var animation = CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut);
    GoogleMapController? mapController = ref.watch(mapControllerProvider);
    List<LatLng> polylineCoordinates = [];

    void decodePoly(String toDebug) {
      polylineCoordinates.clear();
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> decodedPolylinePoints =
          polylinePoints.decodePolyline(toDebug);

      if (decodedPolylinePoints.isNotEmpty) {
        decodedPolylinePoints.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
    }

    bool shouldShowSideBar = MediaQuery.sizeOf(context).width < 724;
    bool isDesktop = MediaQuery.of(context).size.width > 1168;
    return Scaffold(
      endDrawer: AltrdDrawer(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        shouldShow: shouldShowSideBar,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 40,
                    ),
                    color: Colors.black,
                    child: isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "Find A Location",
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      ),
                                      SizedBox(
                                        height: 0.05 *
                                            MediaQuery.sizeOf(context).height,
                                      ),
                                      SizedBox(
                                        width: 0.3 *
                                            MediaQuery.sizeOf(context).width,
                                        child: const Text(
                                          "Search using address city and state or ZIP",
                                          softWrap: true,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0.03 *
                                            MediaQuery.sizeOf(context).height,
                                      ),
                                      SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.sizeOf(context)
                                                          .width >
                                                      1000
                                                  ? 500
                                                  : 0.8 *
                                                      MediaQuery.sizeOf(context)
                                                          .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  suffixIcon: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.search,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      )
                                                    ],
                                                  ),
                                                  label: const Text(
                                                      'Find Location'),
                                                  hintText: 'Enter your search',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.red,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Transform.rotate(
                                                angle: 45 * math.pi / 180,
                                                child: const Icon(
                                                  Icons.navigation_rounded,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0.04 *
                                            MediaQuery.sizeOf(context).height,
                                      ),
                                      const Text(
                                        "Get notified of new locations",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 300,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Colors.black,
                                            filled: true,
                                            hintText: 'Your Name',
                                            hintStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 192, 192, 192)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const SizedBox(
                                        width: 300,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Colors.black,
                                            filled: true,
                                            hintText: 'Your Phone',
                                            hintStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 192, 192, 192)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const SizedBox(
                                        width: 300,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Colors.black,
                                            filled: true,
                                            hintText: 'Your Email',
                                            hintStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 192, 192, 192)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape:
                                                const RoundedRectangleBorder()),
                                        onPressed: () {},
                                        child: const SizedBox(
                                          width: 120,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              "NOTIFY ME!",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape:
                                                const RoundedRectangleBorder()),
                                        onPressed: () {},
                                        child: const SizedBox(
                                          width: 220,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              "SHOW ALL LOCATIONS",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: SizedBox(
                                    height: 720,
                                    width: 800,
                                    child: Stack(
                                      children: [
                                        GoogleMap(
                                            myLocationEnabled: true,
                                            polylines: polylines,
                                            trafficEnabled: true,
                                            markers: stores,
                                            indoorViewEnabled: true,
                                            mapToolbarEnabled: true,
                                            zoomControlsEnabled: false,
                                            fortyFiveDegreeImageryEnabled: true,
                                            mapType: MapType.normal,
                                            initialCameraPosition: _kGooglePlex,
                                            onMapCreated: onMapCreate),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20.0, right: 20),
                                            child: IconButton(
                                              hoverColor: Color.fromARGB(
                                                  158, 123, 122, 122),
                                              icon: Icon(
                                                Icons.directions,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                              onPressed: () async {
                                                bool isFirst =
                                                    await mapController!
                                                        .isMarkerInfoWindowShown(
                                                            MarkerId("first"));
                                                bool isSecond =
                                                    await mapController!
                                                        .isMarkerInfoWindowShown(
                                                            MarkerId("second"));
                                                bool isThird =
                                                    await mapController!
                                                        .isMarkerInfoWindowShown(
                                                            MarkerId("third"));
                                                Location location =
                                                    new Location();
                                                var _permissionGranted =
                                                    await location
                                                        .requestPermission();

                                                print(_permissionGranted.name);

                                                LocationData userPosition =
                                                    await location
                                                        .getLocation();
                                                print(userPosition.latitude);
                                                print(userPosition.longitude);
                                                if (isFirst) {
                                                  var request = http.Request(
                                                      'GET',
                                                      Uri.parse(
                                                          'http://0.0.0.0:8080/https://maps.googleapis.com/maps/api/directions/json?origin=35.552740,-97.626120&destination=${userPosition.latitude},${userPosition.longitude}&key=AIzaSyBJ5WtDvw2lyjzfljtKdNHwxdzgoQ-KTiQ'));

                                                  http.StreamedResponse
                                                      response =
                                                      await request.send();

                                                  Map values = jsonDecode(
                                                      await response.stream
                                                          .bytesToString());

                                                  print(values["status"] ==
                                                      "ZERO_RESULTS");
                                                  if (values["status"] ==
                                                      "ZERO_RESULTS") {
                                                    print("Hi");
                                                    IconSnackBar.show(
                                                        duration: Duration(
                                                            seconds: 3),
                                                        context: context,
                                                        snackBarType:
                                                            SnackBarType.alert,
                                                        label:
                                                            'There is no route on land from your Location to the Dispensary');
                                                    return;
                                                  }
                                                  decodePoly(values["routes"][0]
                                                          ["overview_polyline"]
                                                      ["points"]);
                                                  ref
                                                      .watch(
                                                          polylineStateProvider
                                                              .notifier)
                                                      .addPolyline(Polyline(
                                                          polylineId:
                                                              PolylineId(
                                                                  "first"),
                                                          width: 4,
                                                          points:
                                                              polylineCoordinates,
                                                          color: Colors.white));
                                                } else if (isSecond) {
                                                  var request = http.Request(
                                                      'GET',
                                                      Uri.parse(
                                                          'http://0.0.0.0:8080/https://maps.googleapis.com/maps/api/directions/json?origin=35.552740,-97.626120&destination=${userPosition.latitude},${userPosition.longitude}&key=AIzaSyBJ5WtDvw2lyjzfljtKdNHwxdzgoQ-KTiQ'));

                                                  http.StreamedResponse
                                                      response =
                                                      await request.send();

                                                  Map values = jsonDecode(
                                                      await response.stream
                                                          .bytesToString());
                                                  if (values["routes"] ==
                                                      null) {
                                                    IconSnackBar.show(
                                                        duration: Duration(
                                                            seconds: 3),
                                                        context: context,
                                                        snackBarType:
                                                            SnackBarType.alert,
                                                        label:
                                                            'There is no route on land from your Location to the Dispensary');
                                                    return;
                                                  }
                                                  decodePoly(values["routes"][0]
                                                          ["overview_polyline"]
                                                      ["points"]);
                                                  ref
                                                      .watch(
                                                          polylineStateProvider
                                                              .notifier)
                                                      .addPolyline(Polyline(
                                                          polylineId:
                                                              PolylineId(
                                                                  "first"),
                                                          width: 4,
                                                          points:
                                                              polylineCoordinates,
                                                          color: Colors.white));
                                                } else if (isThird) {
                                                  var request = http.Request(
                                                      'GET',
                                                      Uri.parse(
                                                          'https://cors-anywhere-tj1q.onrender.com/https://maps.googleapis.com/maps/api/directions/json?origin=35.552740,-97.626120&destination=${userPosition.latitude},${userPosition.longitude}&key=AIzaSyBJ5WtDvw2lyjzfljtKdNHwxdzgoQ-KTiQ'));

                                                  http.StreamedResponse
                                                      response =
                                                      await request.send();

                                                  Map values = jsonDecode(
                                                      await response.stream
                                                          .bytesToString());
                                                  if (values["routes"] ==
                                                      null) {
                                                    IconSnackBar.show(
                                                        duration: Duration(
                                                            seconds: 3),
                                                        context: context,
                                                        snackBarType:
                                                            SnackBarType.alert,
                                                        label:
                                                            'There is no route on land from your Location to the Dispensary');
                                                    return;
                                                  }
                                                  decodePoly(values["routes"][0]
                                                          ["overview_polyline"]
                                                      ["points"]);
                                                  ref
                                                      .watch(
                                                          polylineStateProvider
                                                              .notifier)
                                                      .addPolyline(Polyline(
                                                          polylineId:
                                                              PolylineId(
                                                                  "first"),
                                                          width: 4,
                                                          points:
                                                              polylineCoordinates,
                                                          color: Colors.white));
                                                } else {
                                                  IconSnackBar.show(
                                                      duration:
                                                          Duration(seconds: 3),
                                                      context: context,
                                                      snackBarType:
                                                          SnackBarType.alert,
                                                      label:
                                                          'Please select a dispensary to get directions');
                                                }
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ])
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Find A Location",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                                SizedBox(
                                  height:
                                      0.05 * MediaQuery.sizeOf(context).height,
                                ),
                                SizedBox(
                                  width: 0.7 * MediaQuery.sizeOf(context).width,
                                  child: const Text(
                                    "Search using address city and state or ZIP",
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      0.03 * MediaQuery.sizeOf(context).height,
                                ),
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width >
                                                    1000
                                                ? 500
                                                : 0.8 *
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            suffixIcon: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                )
                                              ],
                                            ),
                                            label: const Text('Find Location'),
                                            hintText: 'Enter your search',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Transform.rotate(
                                          angle: 45 * math.pi / 180,
                                          child: const Icon(
                                            Icons.navigation_rounded,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: SizedBox(
                                    height: 720,
                                    width: 800,
                                    child: Stack(
                                      children: [
                                        GoogleMap(
                                            polylines: polylines,
                                            markers: stores,
                                            indoorViewEnabled: true,
                                            zoomControlsEnabled: false,
                                            fortyFiveDegreeImageryEnabled: true,
                                            mapType: MapType.normal,
                                            initialCameraPosition: _kGooglePlex,
                                            onMapCreated: onMapCreate),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20.0, right: 20),
                                            child: IconButton(
                                              hoverColor: Color.fromARGB(
                                                  158, 123, 122, 122),
                                              icon: Icon(
                                                Icons.directions,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                              onPressed: () async {
                                                bool isFirst =
                                                    await mapController!
                                                        .isMarkerInfoWindowShown(
                                                            MarkerId("first"));
                                                bool isSecond =
                                                    await mapController!
                                                        .isMarkerInfoWindowShown(
                                                            MarkerId("second"));
                                                bool isThird =
                                                    await mapController!
                                                        .isMarkerInfoWindowShown(
                                                            MarkerId("third"));
                                                Location location =
                                                    new Location();
                                                var _permissionGranted =
                                                    await location
                                                        .requestPermission();

                                                print(_permissionGranted.name);

                                                LocationData userPosition =
                                                    await location
                                                        .getLocation();
                                                print(userPosition.latitude);
                                                print(userPosition.longitude);
                                                if (isFirst) {
                                                  var request = http.Request(
                                                      'GET',
                                                      Uri.parse(
                                                          'http://0.0.0.0:8080/https://maps.googleapis.com/maps/api/directions/json?origin=35.552740,-97.626120&destination=${userPosition.latitude},${userPosition.longitude}&key=AIzaSyBJ5WtDvw2lyjzfljtKdNHwxdzgoQ-KTiQ'));

                                                  http.StreamedResponse
                                                      response =
                                                      await request.send();

                                                  Map values = jsonDecode(
                                                      await response.stream
                                                          .bytesToString());

                                                  print(values["status"] ==
                                                      "ZERO_RESULTS");
                                                  if (values["status"] ==
                                                      "ZERO_RESULTS") {
                                                    print("Hi");
                                                    IconSnackBar.show(
                                                        duration: Duration(
                                                            seconds: 3),
                                                        context: context,
                                                        snackBarType:
                                                            SnackBarType.alert,
                                                        label:
                                                            'There is no route on land from your Location to the Dispensary');
                                                    return;
                                                  }
                                                  decodePoly(values["routes"][0]
                                                          ["overview_polyline"]
                                                      ["points"]);
                                                  ref
                                                      .watch(
                                                          polylineStateProvider
                                                              .notifier)
                                                      .addPolyline(Polyline(
                                                          polylineId:
                                                              PolylineId(
                                                                  "first"),
                                                          width: 4,
                                                          points:
                                                              polylineCoordinates,
                                                          color: Colors.white));
                                                } else if (isSecond) {
                                                  var request = http.Request(
                                                      'GET',
                                                      Uri.parse(
                                                          'http://0.0.0.0:8080/https://maps.googleapis.com/maps/api/directions/json?origin=35.552740,-97.626120&destination=${userPosition.latitude},${userPosition.longitude}&key=AIzaSyBJ5WtDvw2lyjzfljtKdNHwxdzgoQ-KTiQ'));

                                                  http.StreamedResponse
                                                      response =
                                                      await request.send();

                                                  Map values = jsonDecode(
                                                      await response.stream
                                                          .bytesToString());
                                                  if (values["routes"] ==
                                                      null) {
                                                    IconSnackBar.show(
                                                        duration: Duration(
                                                            seconds: 3),
                                                        context: context,
                                                        snackBarType:
                                                            SnackBarType.alert,
                                                        label:
                                                            'There is no route on land from your Location to the Dispensary');
                                                    return;
                                                  }
                                                  decodePoly(values["routes"][0]
                                                          ["overview_polyline"]
                                                      ["points"]);
                                                  ref
                                                      .watch(
                                                          polylineStateProvider
                                                              .notifier)
                                                      .addPolyline(Polyline(
                                                          polylineId:
                                                              PolylineId(
                                                                  "first"),
                                                          width: 4,
                                                          points:
                                                              polylineCoordinates,
                                                          color: Colors.white));
                                                } else if (isThird) {
                                                  var request = http.Request(
                                                      'GET',
                                                      Uri.parse(
                                                          'https://cors-anywhere-tj1q.onrender.com/https://maps.googleapis.com/maps/api/directions/json?origin=35.552740,-97.626120&destination=${userPosition.latitude},${userPosition.longitude}&key=AIzaSyBJ5WtDvw2lyjzfljtKdNHwxdzgoQ-KTiQ'));

                                                  http.StreamedResponse
                                                      response =
                                                      await request.send();

                                                  Map values = jsonDecode(
                                                      await response.stream
                                                          .bytesToString());
                                                  if (values["routes"] ==
                                                      null) {
                                                    IconSnackBar.show(
                                                        duration: Duration(
                                                            seconds: 3),
                                                        context: context,
                                                        snackBarType:
                                                            SnackBarType.alert,
                                                        label:
                                                            'There is no route on land from your Location to the Dispensary');
                                                    return;
                                                  }
                                                  decodePoly(values["routes"][0]
                                                          ["overview_polyline"]
                                                      ["points"]);
                                                  ref
                                                      .watch(
                                                          polylineStateProvider
                                                              .notifier)
                                                      .addPolyline(Polyline(
                                                          polylineId:
                                                              PolylineId(
                                                                  "first"),
                                                          width: 4,
                                                          points:
                                                              polylineCoordinates,
                                                          color: Colors.white));
                                                } else {
                                                  IconSnackBar.show(
                                                      duration:
                                                          Duration(seconds: 3),
                                                      context: context,
                                                      snackBarType:
                                                          SnackBarType.alert,
                                                      label:
                                                          'Please select a dispensary to get directions');
                                                }
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      0.04 * MediaQuery.sizeOf(context).height,
                                ),
                                const Text(
                                  "Get notified of new locations",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 300,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Colors.black,
                                      filled: true,
                                      hintText: 'Your Name',
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 192, 192, 192)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  width: 300,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Colors.black,
                                      filled: true,
                                      hintText: 'Your Phone',
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 192, 192, 192)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  width: 300,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Colors.black,
                                      filled: true,
                                      hintText: 'Your Email',
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 192, 192, 192)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder()),
                                  onPressed: () {},
                                  child: const SizedBox(
                                    width: 120,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "NOTIFY ME!",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder()),
                                  onPressed: () {},
                                  child: const SizedBox(
                                    width: 220,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "SHOW ALL LOCATIONS",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ]),
                  ),
                ),
                ExpansionPanelList(
                  expandIconColor: Colors.black,
                  expansionCallback: (int index, bool isExpanded) {
                    ref
                        .read(isExpandedValueStatesProvider.notifier)
                        .changeState(index);
                  },
                  children: firstFoldList.entries.map<ExpansionPanel>((data) {
                    return ExpansionPanel(
                        isExpanded: data.value[0],
                        canTapOnHeader: true,
                        backgroundColor: Colors.black,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          // Your header widget or logic here
                          return SizedBox(
                            height: 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  data.key,
                                  style: const TextStyle(
                                      fontSize: 28, color: Colors.white),
                                )
                              ],
                            ),
                          );
                        },
                        body: StoreGrid(
                          girdData: storeData[data.value[1]],
                          scrollController: scrollController,
                          stores: [
                            LatLng(35.503120, -97.565740),
                            LatLng(35.552740, -97.626120),
                            LatLng(35.636810, -97.565740)
                          ],
                        ));
                  }).toList(),
                ),
                FooterWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
