import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/bloc/imc_cubit.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/models/imc_model.dart';

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
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(AppStrings.imcTextResult),
              Text(imcState.imcValue.toString()),
              const Text(AppStrings.imcTextResult2),
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
              onPressed: () {
                onOkButtonHitted();
                Navigator.pop(context);
              },
              child: const Text(
                AppStrings.OK,
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
          child: const Text(AppStrings.OK),
        )
      ],
    );
  }
}
