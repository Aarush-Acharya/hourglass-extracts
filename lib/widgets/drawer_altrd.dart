import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'drawer_altrd.g.dart';

@riverpod
class State extends _$State {
  @override
  int build() => 0;

  void changeState(int index) {
    state = index;
  }
}

class AltrdDrawer extends ConsumerWidget {
  const AltrdDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int state = ref.watch(stateProvider);
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 50,
          ),
          AnimatedEmoji(
            AnimatedEmojis.cowboy,
            repeat: true,
            size: 110,
          ),
          SizedBox(
            height: 50,
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.forest_outlined,
                    color: state == 1
                        ? Color.fromARGB(255, 246, 204, 18)
                        : Colors.white),
                SizedBox(
                  width: 20,
                ),
                const Text(
                  'Products',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            selected: state == 1 ? true : false,
            selectedColor: Color.fromARGB(255, 246, 204, 18),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/products');
              ref.read(stateProvider.notifier).changeState(1);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Row(
              children: [
                FaIcon(FontAwesomeIcons.shirt,
                    size: 20,
                    color: state == 2
                        ? Color.fromARGB(255, 246, 204, 18)
                        : Colors.white),
                SizedBox(
                  width: 20,
                ),
                const Text(
                  'Merch',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            selected: state == 2 ? true : false,
            selectedColor: Color.fromARGB(255, 246, 204, 18),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/merch');
              ref.read(stateProvider.notifier).changeState(2);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.location_city_outlined,
                    color: state == 3
                        ? Color.fromARGB(255, 246, 204, 18)
                        : Colors.white),
                SizedBox(
                  width: 20,
                ),
                const Text('Dispensaries',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            selected: state == 3 ? true : false,
            selectedColor: Color.fromARGB(255, 246, 204, 18),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/dispensaries');
              ref.read(stateProvider.notifier).changeState(3);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    color: state == 4
                        ? Color.fromARGB(255, 246, 204, 18)
                        : Colors.white),
                SizedBox(
                  width: 20,
                ),
                const Text('About', style: TextStyle(color: Colors.white)),
              ],
            ),
            selected: state == 4 ? true : false,
            selectedColor: Color.fromARGB(255, 246, 204, 18),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/about');
              ref.read(stateProvider.notifier).changeState(4);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.shopping_cart,
                    color: state == 5
                        ? Color.fromARGB(255, 246, 204, 18)
                        : Colors.white),
                SizedBox(
                  width: 20,
                ),
                const Text('Cart', style: TextStyle(color: Colors.white)),
              ],
            ),
            selected: state == 5 ? true : false,
            selectedColor: Color.fromARGB(255, 246, 204, 18),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/cart');
              ref.read(stateProvider.notifier).changeState(5);
            },
          ),
        ],
      ),
    );
  }
}
