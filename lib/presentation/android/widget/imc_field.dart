import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc/core/constants/app_strings.dart';

class IMCField extends StatelessWidget {
  const IMCField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value == null || value.isEmpty) return AppStrings.requiredField;
        },
        controller: controller,
        onChanged: (value) {},
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
