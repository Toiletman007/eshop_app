class CartItemModel {
  final String id;
  final String name;
  final double price;
  final int amount;

  const CartItemModel(
      {required this.id,
      required this.name,
      required this.price,
      this.amount = 1});

  double get totalPrice {
    return price * amount;
  }

  CartItemModel copyWith(
      {String? id, String? name, double? price, int? amount}) {
    return CartItemModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        amount: amount ?? this.amount);
  }
}
