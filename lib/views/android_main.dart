import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/bloc/imc_cubit.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:imc/views/android/widget/pop_dialog.dart';

import 'android/widget/imc_field.dart';

class AndroidMain extends StatelessWidget {
  const AndroidMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appName),
        ),
        body: BlocBuilder<ImcCubit, ImcModel>(
          builder: (context, imcState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                      'O índice de massa corporal é uma medida internacional usada para calcular se uma pessoa está no peso ideal.'),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          IMCField(
                            controller: context.read<ImcCubit>().heightCtrl,
                            labelText: 'Insira sua altura',
                            hintText: '1,80',
                          ),
                          IMCField(
                            controller: context.read<ImcCubit>().weightCtrl,
                            labelText: 'Insira seu peso',
                            hintText: '76,5',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ImcCubit>().calculateIMC();
                          await showDialog(
                            context: context,
                            builder: (context) =>
                                BlocSelector<ImcCubit, ImcModel, double?>(
                                    selector: (state) {
                              state.imcValue;
                            }, builder: (context, snapshot) {
                              return SuccessDialog(
                                imcValue: imcState.imcValue.toString(),
                              );
                            }),
                          );
                        }
                      },
                      child: const Text('Calcular IMC'),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
