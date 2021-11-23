import 'package:imc/presentation/android/admob/app_ads.dart';
import 'package:imc/presentation/android/widget/imc_primary_button.dart';
import 'package:imc/presentation/android/widget/last_calcs.dart';
import 'package:imc/presentation/android/widget/pop_dialog.dart';
import 'package:imc/presentation/android/widget/imc_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:imc/core/bloc/imc_cubit.dart';
import 'package:flutter/material.dart';

class AndroidFormScreen extends StatefulWidget {
  const AndroidFormScreen({Key? key}) : super(key: key);

  @override
  State<AndroidFormScreen> createState() => _AndroidFormScreenState();
}

class _AndroidFormScreenState extends State<AndroidFormScreen> {
  AdsManager adsManager = AdsManager();

  @override
  void initState() {
    super.initState();
    adsManager.createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return BlocBuilder<ImcCubit, ImcModel>(
      builder: (context, _) {
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
                      StreamBuilder<ImcModel>(
                        stream: context.read<ImcCubit>().stream,
                        builder: (context, snapshot) {
                          String? fieldvalue =
                              snapshot.hasData && snapshot.data!.height > 0.0
                                  ? snapshot.data?.height.toString()
                                  : null;

                          return IMCField(
                            onChanged: (value) =>
                                context.read<ImcCubit>().setHeight(value),
                            currentValue: fieldvalue,
                            textInputFormatter: AlturaInputFormatter(),
                            labelText: AppStrings.enterYourHeight,
                            hintText: AppStrings.heightHint,
                          );
                        },
                      ),
                      StreamBuilder<ImcModel>(
                        stream: context.read<ImcCubit>().stream,
                        builder: (context, snapshot) {
                          String? fieldvalue =
                              snapshot.hasData && snapshot.data!.height > 0.0
                                  ? snapshot.data?.height.toString()
                                  : null;

                          return IMCField(
                            onChanged: (value) =>
                                context.read<ImcCubit>().setWeight(value),
                            currentValue: fieldvalue,
                            textInputFormatter: PesoInputFormatter(),
                            labelText: AppStrings.enterYourWeight,
                            hintText: AppStrings.weightHint,
                          );
                        },
                      ),
                      const Divider(),
                      const LastCalcs(),
                      const Divider(),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              IMCPrimaryButton(
                onPressed: () async => await _calculateIMC(context, _formKey),
                color: Theme.of(context).primaryColor,
                text: AppStrings.calculateIMC,
              ),
              Container(
                child: adsManager.adBannerWidget(),
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
      await context.read<ImcCubit>().calculateIMC().then((_) async {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => SuccessDialog(
            onOkButtonHitted: () => context.read<ImcCubit>().reset(),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    adsManager.dispose();
    super.dispose();
  }
}
