import 'package:flutter/material.dart';
import 'package:imc/core/constants/app_strings.dart';

class IMCPrimaryButton extends StatelessWidget {
  const IMCPrimaryButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(),
        onPressed: () => onPressed,
        child: const Text(AppStrings.calculateIMC),
      ),
    );
  }
}
