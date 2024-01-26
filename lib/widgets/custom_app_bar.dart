// lib/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Material(
              borderRadius: BorderRadius.circular(90),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Ink(
                        height: 60,
                        child: Image.network(
                          "https://placekitten.com/100/100",
                          fit: BoxFit.cover,
                        ))),
              )),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/products');
                },
                child: const Text(
                  'Products',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/merch');
                },
                child: const Text(
                  'Merch',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dispensaries');
                },
                child: const Text(
                  'Store Locator',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'About Us',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Bussiness Inquiries',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Events',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              SizedBox(
                width: 30,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
              SizedBox(
                width: 60,
              ),
            ],
          ),
        ],
        centerTitle: false);
  }
}
