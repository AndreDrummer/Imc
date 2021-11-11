import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class IMCField extends StatelessWidget {
  const IMCField({
    Key? key,
    required this.textInputFormatter,
    required this.currentValue,
    required this.onChanged,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  final TextInputFormatter textInputFormatter;
  final Function(String) onChanged;
  final String? currentValue;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: TextFormField(
        controller: TextEditingController(text: currentValue),
        keyboardType: const TextInputType.numberWithOptions(),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          textInputFormatter,
        ],
        validator: (value) {
          if (value == null || value.isEmpty) return AppStrings.requiredField;
        },
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
