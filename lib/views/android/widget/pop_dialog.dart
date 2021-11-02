import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({required this.imcValue, Key? key}) : super(key: key);

  final String imcValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Seu indice de massa corpórea (IMC) é de:',
          ),
          Text(imcValue),
          const Text(
            'O que significa que você está no peso ideal.',
          ),
          Row(
              children: List.generate(
            6,
            (index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ))
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        )
      ],
    );
  }
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Seu indice de massa corpórea (IMC) é de:',
          ),
          const Text('21,45'),
          const Text(
            'O que significa que você está no peso ideal.',
          ),
          Row(
              children: List.generate(
            6,
            (index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ))
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        )
      ],
    );
  }
}
