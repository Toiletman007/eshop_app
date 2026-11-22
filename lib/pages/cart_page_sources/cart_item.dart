import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String name;
  final double price;
  int amount;

  CartItem({
    super.key,
    required this.name,
    required this.price,
    required this.amount,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/placeholder.png', // Replace with your image path
          width: 50,
          height: 50,
        ),
        Text(widget.name),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  widget.amount = widget.amount + 1;
                });
              },
            ),
            Text('${widget.amount}'),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (widget.amount - 1 >= 0) {
                    widget.amount = widget.amount - 1;
                  } else {
                    // Handle popup for making sure the user wants to remove
                  }
                });
              },
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Handle delete action
          },
        ),
      ],
    ));
  }
}
