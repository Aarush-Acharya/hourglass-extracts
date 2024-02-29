import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cart_page.g.dart';

@riverpod
class CartState extends _$CartState {
  @override
  List build() => [];

  void addItem(dynamic item) {
    state = [...state, item];
  }

}