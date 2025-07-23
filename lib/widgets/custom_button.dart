import 'package:flutter/material.dart';

/// Widget de un botón personalizado con los colores de EMMA
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF19FF98), // fondo verde
        foregroundColor: Colors.black, // texto en negro
        textStyle: const TextStyle(fontSize: 18), // tamaño de fuente
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(text),
    );
  }
}
