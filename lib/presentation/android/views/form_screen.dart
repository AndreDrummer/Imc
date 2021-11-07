import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/bloc/history_cubit.dart';
import 'package:imc/core/bloc/imc_cubit.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:imc/presentation/android/widget/history_item.dart';
import 'package:imc/presentation/android/widget/imc_field.dart';
import 'package:imc/presentation/android/widget/imc_primary_button.dart';
import 'package:imc/presentation/android/widget/pop_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AndroidFormScreen extends StatelessWidget {
  const AndroidFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return BlocBuilder<ImcCubit, ImcModel>(
      builder: (context, imcState) {
        return Padding(
          padding: EdgeInsets.all(16.0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0.h),
                        child: LastCalcs(),
                      ),
                      Divider(),
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
        builder: (context) => SuccessDialog(
          onOkButtonHitted: () => context.read<ImcCubit>().reset(),
        ),
      );
    }
  }
}

class LastCalcs extends StatelessWidget {
  const LastCalcs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imcHistoryProvider = context.read<IMCHistoryCubit>();
    var isNotEmpty = imcHistoryProvider.subListImcHistory().isNotEmpty;

    return FutureBuilder(
      future: imcHistoryProvider.loadIMCHistoryFromStorage(),
      builder: (context, snpshot) {
        return Column(
          children: [
            Visibility(
              visible: isNotEmpty,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12.0.h,
                ),
                child: const Text(
                  AppStrings.lastCalcs,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              height: 128.0.h,
              child: ListView(
                children: context
                    .read<IMCHistoryCubit>()
                    .subListImcHistory()
                    .reversed
                    .map((imcItem) => HistoryItem(imc: imcItem))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
