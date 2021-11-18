import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/bloc/imc_cubit.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    required this.onOkButtonHitted,
    Key? key,
  }) : super(key: key);

  final Function() onOkButtonHitted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImcCubit, ImcModel>(
      builder: (context, imcState) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(AppStrings.imcTextResult),
              Padding(
                padding: EdgeInsets.all(12.0.h),
                child: Text(
                  imcState.imcValue.toString(),
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Text(AppStrings.imcTextResult2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${imcState.description}.',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imcState.stars,
                    (index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                onOkButtonHitted();
                Navigator.pop(context);
              },
              child: const Text(
                AppStrings.ok,
              ),
            )
          ],
        );
      },
    );
  }
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    required this.errorMessage,
    Key? key,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(errorMessage),
          Text(errorMessage),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.ok),
        )
      ],
    );
  }
}

class QuestionDialog extends StatelessWidget {
  const QuestionDialog({
    required this.onOkButtonHitted,
    required this.message,
    Key? key,
  }) : super(key: key);

  final String message;
  final Function() onOkButtonHitted;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.deleteHistory),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            onOkButtonHitted();
            Navigator.pop(context);
          },
          child: const Text(AppStrings.yes),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(AppStrings.no),
        )
      ],
    );
  }
}
