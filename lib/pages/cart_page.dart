import 'package:animated_emoji/animated_emoji.dart';
import 'package:animated_emoji/emoji.dart';
import 'package:fineartsociety/widgets/custom_app_bar.dart';
import 'package:fineartsociety/widgets/footer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../widgets/drawer_altrd.dart';
part 'cart_page.g.dart';

@riverpod
class CartState extends _$CartState {
  @override
  List build() => [];

  void addItem(dynamic item) {
    state = [...state, item];
  }

  void changeQuantity(int index, int newQuantity) {
    state = state
        .asMap()
        .map<int, List>((currentIndex, value) {
          if (currentIndex == index) {
            List newList = [...value];
            newList[2] = newQuantity;
            return MapEntry(currentIndex, newList);
          } else {
            return MapEntry(currentIndex, value);
          }
        })
        .values
        .toList();
  }
}

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List cart = ref.watch(cartStateProvider);
    num total = 0;
    for (var item in cart) {
      total = total + item[1] * item[2];
    }
    bool shouldShowSideBar = MediaQuery.sizeOf(context).width < 724;
    bool isDesktop = MediaQuery.of(context).size.width > 1168;
    return Scaffold(
      endDrawer: AltrdDrawer(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        shouldShow: shouldShowSideBar,
      ),
      body: !cart.isEmpty
          ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Column(
                          children: List.generate(cart.length, (index) {
                            return isDesktop
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 100, left: 250),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.asset(
                                                cart[index][3],
                                                fit: BoxFit.fill,
                                                width: 200,
                                                height: 200,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cart[index][0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 30),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 400,
                                                    child: Text(
                                                      '\$ ${cart[index][1]}.00',
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 400,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "x ${cart[index][2]}",
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          onTap: () {
                                                            ref
                                                                .watch(
                                                                    cartStateProvider
                                                                        .notifier)
                                                                .changeQuantity(
                                                                    index,
                                                                    cart[index][
                                                                            2] -
                                                                        1);
                                                          },
                                                          splashColor:
                                                              Color.fromARGB(35,
                                                                  215, 31, 18),
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .minus_circle,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          onTap: () {
                                                            ref
                                                                .watch(
                                                                    cartStateProvider
                                                                        .notifier)
                                                                .changeQuantity(
                                                                    index,
                                                                    cart[index][
                                                                            2] +
                                                                        1);
                                                          },
                                                          splashColor:
                                                              const Color
                                                                  .fromARGB(43,
                                                                  76, 175, 79),
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .add_circled,
                                                            color: Colors.green,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ]),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.asset(
                                              cart[index][3],
                                              fit: BoxFit.fill,
                                              width: 200,
                                              height: 200,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          cart[index][0],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 400,
                                          child: Text(
                                            '\$ ${cart[index][1]}.00',
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 400,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "x ${cart[index][2]}",
                                                softWrap: true,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () {
                                                  ref
                                                      .watch(cartStateProvider
                                                          .notifier)
                                                      .changeQuantity(index,
                                                          cart[index][2] - 1);
                                                },
                                                splashColor: Color.fromARGB(
                                                    35, 215, 31, 18),
                                                child: Icon(
                                                  CupertinoIcons.minus_circle,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () {
                                                  ref
                                                      .watch(cartStateProvider
                                                          .notifier)
                                                      .changeQuantity(index,
                                                          cart[index][2] + 1);
                                                },
                                                splashColor:
                                                    const Color.fromARGB(
                                                        43, 76, 175, 79),
                                                child: Icon(
                                                  CupertinoIcons.add_circled,
                                                  color: Colors.green,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ]);
                          }),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              "\$ ${total}.00",
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              side: BorderSide(color: Colors.black)),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: Text(
                              "Proceed to Pay",
                              style: TextStyle(
                                  color: Colors.black, letterSpacing: 2),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        FooterWidget()
                      ],
                    )),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "The cart is empty, please add items to the cart.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      AnimatedEmoji(
                        AnimatedEmojis.sad,
                        repeat: true,
                        size: 200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
