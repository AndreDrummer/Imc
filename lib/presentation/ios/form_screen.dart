import 'package:imc/presentation/android/widget/imc_primary_button.dart';
import 'package:imc/presentation/android/widget/pop_dialog.dart';
import 'package:imc/presentation/android/widget/imc_field.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/bloc/imc_cubit.dart';
import 'package:flutter/material.dart';

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
                      StreamBuilder<ImcModel>(
                        stream: context.read<ImcCubit>().stream,
                        builder: (context, snapshot) {
                          String? fieldvalue = snapshot.data!.height >= 0.0
                              ? snapshot.data?.height.toString()
                              : null;

                          return IMCField(
                            onChanged: (value) =>
                                context.read<ImcCubit>().setHeight(value),
                            textInputFormatter: AlturaInputFormatter(),
                            labelText: AppStrings.enterYourHeight,
                            hintText: AppStrings.heightHint,
                            currentValue: fieldvalue,
                          );
                        },
                      ),
                      StreamBuilder<ImcModel>(
                        stream: context.read<ImcCubit>().stream,
                        builder: (context, snapshot) {
                          String? fieldvalue = snapshot.data!.height >= 0.0
                              ? snapshot.data?.height.toString()
                              : null;

                          return IMCField(
                            onChanged: (value) =>
                                context.read<ImcCubit>().setWeight(value),
                            textInputFormatter: PesoInputFormatter(),
                            labelText: AppStrings.enterYourWeight,
                            hintText: AppStrings.weightHint,
                            currentValue: fieldvalue,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              IMCPrimaryButton(
                text: AppStrings.calculateIMC,
                color: Theme.of(context).primaryColor,
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
        builder: (_) => SuccessDialog(
          onOkButtonHitted: () => context.read<ImcCubit>().reset(),
        ),
      );
    }
  }
}
