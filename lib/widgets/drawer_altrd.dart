import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: const Text('Products'),
            selected: state == 0 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/products');
              ref.read(stateProvider.notifier).changeState(0);
            },
          ),
          ListTile(
            title: const Text('Merch'),
            selected: state == 1 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/merch');
              ref.read(stateProvider.notifier).changeState(1);
            },
          ),
          ListTile(
            title: const Text('Dispensaries'),
            selected: state == 2 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/dispensaries');
              ref.read(stateProvider.notifier).changeState(2);
            },
          ),
          ListTile(
            title: const Text('About'),
            selected: state == 3 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/about');
              ref.read(stateProvider.notifier).changeState(3);
            },
          ),
        ],
      ),
    );
  }
}
