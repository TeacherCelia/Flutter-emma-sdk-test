import 'package:flutter/material.dart';
import 'package:emma_flutter_sdk/emma_flutter_sdk.dart';

/// Clase para simular un carrito de la compra
/// 
/// Solo se lanza el startOrder si no hay una orden en curso
/// Se va sumando la cantidad de productos y el precio
/// Finalmente, se trackea o se cancela la orden
class Cart {
  int _productCount = 0;
  double _totalPrice = 0.0;
  bool _orderStarted = false;
  final VoidCallback onCartUpdated;

  Cart({required this.onCartUpdated});

  // getter para acceder al nº de productos desde homescreen
  int get productCount => _productCount;

  Future<void> addProduct(BuildContext context) async {
    if (!_orderStarted) {
      final order = EmmaOrder("EMMA", 0, "1");
      await EmmaFlutterSdk.shared.startOrder(order);
      _orderStarted = true;
    }

    final product = EmmaProduct('SDK', 'SDK', 1, 10.0);
    await EmmaFlutterSdk.shared.addProduct(product);

    _productCount++;
    _totalPrice += 10.0;

    onCartUpdated(); // cambio en el carrito
    _showCartSnackBar(context);
  }

  Future<void> trackOrder(BuildContext context) async {
    if (_productCount > 0) {
      final int purchasedCount = _productCount;
      final double purchasedTotal = _totalPrice;

      await EmmaFlutterSdk.shared.trackOrder();
      _resetCart();
      onCartUpdated(); // cambio en el carrito

      _showMessage(
        context,
        "Purchase done! You bought $purchasedCount products for $purchasedTotal €. Cart is now empty.");
    }
  }

  void cancelOrder(BuildContext context) {
    _resetCart();
    onCartUpdated(); // cambio en el carrito
    _showMessage(context, "Cart is now empty");
  }

  void _resetCart() {
    _productCount = 0;
    _totalPrice = 0.0;
    _orderStarted = false;
  }

  void _showCartSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'EMMA added to cart: $_productCount products, $_totalPrice €',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.green[600],
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
          ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
