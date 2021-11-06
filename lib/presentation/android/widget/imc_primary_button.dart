import 'package:flutter/material.dart';

class IMCPrimaryButton extends StatelessWidget {
  const IMCPrimaryButton({
    Key? key,
    required this.onPressed,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Function() onPressed;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: color),
        onPressed: () => onPressed(),
        child: Text(text),
      ),
    );
  }
}
