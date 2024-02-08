// lib/widgets/custom_app_bar.dart
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
  const CustomAppBar({super.key});

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
      'About Us': 'exhibitions',
      'Business Inquiries': 'news',
      'Events': 'contact'
    };

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 30, top: 5, bottom: 5, right: 40),
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
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset(
                          "assets/Altrd Cannabis Asset.svg",
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ))),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      appbarHeaders.keys.toList().asMap().entries.map((entry) {
                    int index = entry.key;
                    String header = entry.value;
                    return Row(
                      children: [
                        SizedBox(width: screenSize.width / 40),
                        InkWell(
                          onHover: (value) {
                            print(value);
                            ref
                                .read(currentHoveringStatesProvider.notifier)
                                .changeState(index);
                          },
                          onTap: () {
                            print("I am envoked");
                            // ref
                            //     .read(currentHoveringStatesProvider.notifier)
                            //     .changeState(0);
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
                                          ? Color.fromARGB(255, 3, 255, 142)
                                          : Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                // For showing an underline on hover
                                Visibility(
                                  maintainAnimation: true,
                                  maintainState: true,
                                  maintainSize: true,
                                  visible: _isHovering[index],
                                  child: AnimatedContainer(
                                      duration: Duration(milliseconds: 250),
                                      height: 2,
                                      width: _isHovering[index] ? 50 : 0,
                                      color: Colors.white),
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
                    color: Colors.white,
                  )),
              SizedBox(
                width: screenSize.width / 50,
              ),
              InkWell(
                  onTap: () {},
                  child: Icon(Icons.shopping_bag, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
