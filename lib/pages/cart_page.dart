import 'package:flutter/material.dart';
import 'package:eshop_app/pages/cart_page_sources/cart_item_tile.dart';
import 'package:eshop_app/pages/cart_page_sources/cart_item_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<CartItemModel> _items = [
    const CartItemModel(id: '1', name: 'Item 1', price: 10.0, amount: 1),
    const CartItemModel(id: '2', name: 'Item 2', price: 20.0, amount: 2),
    const CartItemModel(id: '3', name: 'Item 3', price: 30.0, amount: 3),
  ];

  Future<bool> _confirmRemoveDialog(String itemName) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove item'),
        content: Text('Remove $itemName from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _decrementItem(int index) async {
    final current = _items[index];
    if (current.amount > 1) {
      setState(() {
        _items[index] = current.copyWith(amount: current.amount - 1);
      });
    } else {
      final shouldRemove = await _confirmRemoveDialog(current.name);
      if (!mounted) return;
      if (shouldRemove) {
        _deleteItem(current.id);
      }
    }
  }

  void _deleteItem(String id) {
    setState(() {
      _items.removeWhere((item) => item.id == id);
    });
  }

  void _incrementItem(int index) {
    setState(() {
      final current = _items[index];
      _items[index] = current.copyWith(amount: current.amount + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'cart',
          style: TextStyle(fontSize: 24),
        ),
        if (_items.isEmpty)
          const Center(child: Text('Your cart is empty'))
        else
          Column(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              return CartItemTile(
                key: ValueKey(item.id),
                cartItemModel: item,
                onIncrement: () => _incrementItem(index),
                onDecrement: () => _decrementItem(index),
                onDelete: () => _deleteItem(item.id),
              );
            }),
          )
      ],
    );
  }
}
