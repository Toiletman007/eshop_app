import 'package:eshop_app/pages/cart_page_sources/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel cartItemModel;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const CartItemTile({
    super.key,
    required this.cartItemModel,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/placeholder.png',
          width: 50,
          height: 50,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            cartItemModel.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            IconButton(icon: const Icon(Icons.add), onPressed: onIncrement),
            Text('${cartItemModel.amount}'),
            IconButton(icon: const Icon(Icons.remove), onPressed: onDecrement),
          ],
        ),
        IconButton(icon: const Icon(Icons.delete), onPressed: onDelete)
      ],
    ));
  }
}
