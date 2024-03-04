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
            title: const Text('Home'),
            selected: state == 0 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/');
              ref.read(stateProvider.notifier).changeState(0);
            },
          ),
          ListTile(
            title: const Text('Find ATM'),
            selected: state == 1 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/findAtm');
              ref.read(stateProvider.notifier).changeState(1);
            },
          ),
          ListTile(
            title: const Text('Customer Support'),
            selected: state == 2 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/customerSupport');
              ref.read(stateProvider.notifier).changeState(2);
            },
          ),
          ListTile(
            title: const Text('Host Atm'),
            selected: state == 3 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/hostAtm');
              ref.read(stateProvider.notifier).changeState(3);
            },
          ),
        ],
      ),
    );
  }
}
