import 'package:flutter/material.dart';

// se declara el widget
class NativeAdDialog extends StatelessWidget {
  // parámetros del widget
  final String title;
  final String body;
  final String? imageUrl;
  final VoidCallback onClose; // qué hacer cuando se pulsa el botón

  // constructor
  const NativeAdDialog({
    super.key, // ?
    required this.title,
    required this.body,
    required this.imageUrl,
    required this.onClose,
  });

  // construye lo que se ve
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // si hay imagen se muestra
          if (imageUrl != null) Image.network(imageUrl!),
          const SizedBox(height: 12), // espacio vertical
          Text(body),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onClose, // al pulsar, ejecutamos el callback
          child: const Text('Volver'),
        ),
      ],
    );
  }
}

