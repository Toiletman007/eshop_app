import 'package:flutter/material.dart';
import 'package:eshop_app/pages/cart_page_sources/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'cart',
          style: TextStyle(fontSize: 24),
        ),
        Column(
          children: [for (final item in _items) const ListTile()],
        )
      ],
    );
  }
}
