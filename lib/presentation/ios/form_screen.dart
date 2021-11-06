import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/bloc/imc_cubit.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:imc/presentation/android/widget/imc_field.dart';
import 'package:imc/presentation/android/widget/imc_primary_button.dart';
import 'package:imc/presentation/android/widget/pop_dialog.dart';

class IosFormScreen extends StatelessWidget {
  const IosFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return BlocBuilder<ImcCubit, ImcModel>(
      builder: (context, imcState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(AppStrings.imcInfo),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      IMCField(
                        controller: context.read<ImcCubit>().heightCtrl,
                        labelText: AppStrings.enterYourHeight,
                        hintText: AppStrings.heightHint,
                      ),
                      IMCField(
                        controller: context.read<ImcCubit>().weightCtrl,
                        labelText: AppStrings.enterYourWeight,
                        hintText: AppStrings.weightHint,
                      ),
                    ],
                  ),
                ),
              ),
              IMCPrimaryButton(
                onPressed: () async => await _calculateIMC(context, _formKey),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _calculateIMC(
      BuildContext context, GlobalKey<FormState> _formKey) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ImcCubit>().calculateIMC();
      await showDialog(
        context: context,
        builder: (context) => SuccessDialog(
          onOkButtonHitted: () => context.read<ImcCubit>().reset(),
        ),
      );
    }
  }
}
