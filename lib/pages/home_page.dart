import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Column(
        children: [
          SearchBar(
              hintText: "Vyhledej!",
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tune,
                      color: Colors.grey,
                    )),
              ]),
        ],
      ),
    );
  }
}
