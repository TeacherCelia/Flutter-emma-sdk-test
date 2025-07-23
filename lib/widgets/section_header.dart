import 'package:flutter/material.dart';

/// Widget para mostrar texto y descripción de cada sección
/// 
/// Creado para limpiar de código la home_screen.dart
class SectionHeader extends StatelessWidget {
  final String title;
  final String description;

  const SectionHeader({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
