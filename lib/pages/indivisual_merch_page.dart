import 'package:fineartsociety/pages/cart_page.dart';
import 'package:fineartsociety/pages/merch_page.dart';
import 'package:fineartsociety/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/drawer_altrd.dart';

class IndividualMerchPage extends ConsumerWidget {
  const IndividualMerchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController scrollController = ScrollController();
    dynamic info = ModalRoute.of(context)!.settings.arguments!;
    int value = ref.watch(countProvider);
    bool isDesktop = MediaQuery.of(context).size.width > 1168;
    bool shouldShowSideBar = MediaQuery.sizeOf(context).width < 724;
    return Scaffold(
      endDrawer: AltrdDrawer(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        shouldShow: shouldShowSideBar,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          info[4],
                          fit: BoxFit.contain,
                          width: 700,
                          height: 500,
                        ),
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: SizedBox(
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    info[0],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 35),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      scrollController.animateTo(2200,
                                          duration: Duration(seconds: 2),
                                          curve: Curves.decelerate);
                                    },
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RatingBar.builder(
                                            unratedColor: Colors.grey,
                                            // tapOnlyMode: true,
                                            itemSize: 30,
                                            ignoreGestures: true,
                                            initialRating: info[1],
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "·",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${info[1]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '${info[2]} ratings',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    '\$ ${info[3]}.00',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Shipping calculated at checkout",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const Text(
                                    "Quantity",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 23),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.amber, width: 0.2)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            ref
                                                .read(countProvider.notifier)
                                                .increment();
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '$value',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            ref
                                                .read(countProvider.notifier)
                                                .decrement(context);
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          minimumSize: const Size(280, 50),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100))),
                                      onPressed: () {},
                                      child: const Text(
                                        "Buy now",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          minimumSize: const Size(280, 50),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100))),
                                      onPressed: () {
                                        ref
                                            .watch(cartStateProvider.notifier)
                                            .addItem([
                                          info[0],
                                          info[3],
                                          value,
                                          info[4]
                                        ]);
                                      },
                                      child: const Text(
                                        "Add to cart",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          info[4],
                          fit: BoxFit.contain,
                          width: 700,
                          height: 500,
                        ),
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: SizedBox(
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    info[0],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 35),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      scrollController.animateTo(2200,
                                          duration: Duration(seconds: 2),
                                          curve: Curves.decelerate);
                                    },
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RatingBar.builder(
                                            unratedColor: Colors.grey,
                                            // tapOnlyMode: true,
                                            itemSize: 30,
                                            ignoreGestures: true,
                                            initialRating: info[1],
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "·",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${info[1]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '${info[2]} ratings',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    '\$ ${info[3]}.00',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Shipping calculated at checkout",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const Text(
                                    "Quantity",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 23),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.amber, width: 0.2)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            ref
                                                .read(countProvider.notifier)
                                                .increment();
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '$value',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            ref
                                                .read(countProvider.notifier)
                                                .decrement(context);
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          minimumSize: const Size(280, 50),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100))),
                                      onPressed: () {},
                                      child: const Text(
                                        "Buy now",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          minimumSize: const Size(280, 50),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100))),
                                      onPressed: () {
                                        ref
                                            .watch(cartStateProvider.notifier)
                                            .addItem([
                                          info[0],
                                          info[3],
                                          value,
                                          info[4]
                                        ]);
                                      },
                                      child: const Text(
                                        "Add to cart",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  SizedBox(
                                    height: 50,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
