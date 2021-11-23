import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class IMCPrimaryButton extends StatelessWidget {
  const IMCPrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color,
  }) : super(key: key);

  final Function() onPressed;
  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color ?? Theme.of(context).primaryColor,
          // textStyle: const TextStyle(
          //   color: Colors.white,
          //   backgroundColor: Colors.red,
          // ),
          onPrimary: Colors.white,
        ),
        onPressed: () => onPressed(),
        child: Text(text),
      ),
    );
  }
}
