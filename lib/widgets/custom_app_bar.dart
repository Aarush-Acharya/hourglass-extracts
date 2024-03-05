import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "custom_app_bar.g.dart";

@riverpod
class CurrentHoveringStates extends _$CurrentHoveringStates {
  @override
  List<bool> build() => [false, false, false, false, false, false];

  void changeState(int index) {
    state = state
        .asMap()
        .map<int, bool>((currentIndex, value) {
          if (currentIndex == index) {
            return MapEntry(currentIndex, !value);
          } else {
            return MapEntry(currentIndex, value);
          }
        })
        .values
        .toList();
  }
}

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  bool shouldShow;
  CustomAppBar({super.key, required this.shouldShow});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List _isHovering = ref.watch(currentHoveringStatesProvider);
    var screenSize = MediaQuery.of(context).size;

    Map<String, String> appbarHeaders = {
      'Products': 'products',
      'Merch': 'merch',
      'Dispensaries': 'dispensaries',
      'About Us': 'about',
    };

    return shouldShow
        ? AppBar(
          surfaceTintColor: Colors.transparent,

            title: Material(
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Ink(
                        height: 170,
                        width: 70,
                        child: SvgPicture.asset(
                          "assets/Altrd Cannabis Asset.svg",
                          fit: BoxFit.contain,
                          // Adjust SVG color for better visibility against white background
                          color: Colors.black,
                        )))),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            centerTitle: false)
        : PreferredSize(
            preferredSize: Size(screenSize.width, 1000),
            child: Container(
              color: Colors.white, // Set the background color to white
              padding: EdgeInsets.only(left: 30, top: 5, bottom: 5, right: 40),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Ink(
                              height: 170,
                              width: 70,
                              child: SvgPicture.asset(
                                "assets/Altrd Cannabis Asset.svg",
                                fit: BoxFit.fill,
                                // Adjust SVG color for better visibility against white background
                                color: Colors.black,
                              ))),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: appbarHeaders.keys
                            .toList()
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          String header = entry.value;
                          return Row(
                            children: [
                              SizedBox(width: screenSize.width / 20),
                              InkWell(
                                onHover: (value) {
                                  ref
                                      .read(currentHoveringStatesProvider
                                          .notifier)
                                      .changeState(index);
                                },
                                onTap: () {
                                  print("Here");
                                  Navigator.pushNamed(
                                      context, '/${appbarHeaders[header]!}');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        header,
                                        style: TextStyle(
                                            color: _isHovering[index]
                                                ? Color.fromARGB(255, 36, 98, 7)
                                                : Colors
                                                    .black, // Changed text color
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 5),
                                      Visibility(
                                        maintainAnimation: true,
                                        maintainState: true,
                                        maintainSize: true,
                                        visible: _isHovering[index],
                                        child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 250),
                                            height: 2,
                                            width: _isHovering[index] ? 40 : 0,
                                            color: Colors
                                                .black), // Adjusted for visibility
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: screenSize.width / 40),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.search,
                          color:
                              Colors.black, // Adjust icon color for visibility
                        )),
                    SizedBox(
                      width: screenSize.width / 50,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                        child: Icon(Icons.shopping_bag, color: Colors.black))
                  ],
                ),
              ),
            ),
          );
  }
}
