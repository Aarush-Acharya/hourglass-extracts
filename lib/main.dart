import 'dart:ui';
import 'package:fineartsociety/pages/about_page.dart';
import 'package:fineartsociety/pages/all_artist_page.dart';
import 'package:fineartsociety/pages/bussiness_inquiry_page.dart';
import 'package:fineartsociety/pages/cart_page.dart';
import 'package:fineartsociety/pages/contact_page.dart';
import 'package:fineartsociety/pages/dispensaries_page.dart';
import 'package:fineartsociety/pages/events_page.dart';
import 'package:fineartsociety/pages/exhibitions_page.dart';
import 'package:fineartsociety/pages/indivisual_category_page.dart';
import 'package:fineartsociety/pages/indivisual_merch_page.dart';
import 'package:fineartsociety/pages/indivisual_page.dart';
import 'package:fineartsociety/pages/news_page.dart';
import 'package:fineartsociety/pages/merch_page.dart';
import 'package:fineartsociety/pages/products_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/home_page.dart';
import 'pages/artist_page.dart';

void main() {

  // Load our .env file that contains our Stripe Secret key
  dotenv.load(fileName: "lib/.env");


  runApp(const ProviderScope(child: MyApp()));
}



class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
      title: 'Altrd',
      theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Brown'),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/bussinessInquiry': (context) => BussinessInquiryPage(),
        '/artist': (context) => const ArtistPage(),
        '/news': (context) => const NewsPage(),
        '/allArtist': (context) => const AllArtistsPage(),
        '/events': (context) => const EventsPage(),
        '/contact': (context) => const ContactPage(),
        '/about': (context) => AboutPage(),
        '/dispensaries': (context) => DispensariesScreen(),
        '/exhibitions': (context) => const ExhibitionPage(),
        '/indivisualItem': (context) => const IndivisualPage(),
        '/products': (context) => ProductPage(),
        '/merch': (context) => const MerchPage(),
        '/indivisualMerchPage': (context) => IndividualMerchPage(),
        '/categoryProducts': (context) => CategoryProducts(),
        '/cart': (context) => CartPage()
      },
    );
  }
}
