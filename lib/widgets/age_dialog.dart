import 'package:flutter/material.dart';

class AgeDialog extends StatefulWidget {
  const AgeDialog({super.key});

  @override
  State<AgeDialog> createState() => _AgeDialogState();
}

class _AgeDialogState extends State<AgeDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void _onConfirm() {
    final input = _controller.text.trim();
    final age = int.tryParse(input);

    if (age == null || age <= 0) {
      setState(() {
        _errorText = 'Try a valid age number';
      });
      return;
    }

    Navigator.of(context).pop(age); // devolver la edad
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Type your age'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Ex: 25',
          errorText: _errorText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _onConfirm,
          child: const Text('Save'),
        ),
      ],
    );
  }
}