import 'package:imc/core/bloc/history_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:flutter/material.dart';
import 'package:imc/presentation/android/widget/history_item.dart';
import 'package:imc/presentation/android/widget/imc_primary_button.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IMCHistoryCubit, List<ImcModel>>(
      builder: (context, imcHistoryState) {
        return FutureBuilder<void>(
          future: context.read<IMCHistoryCubit>().loadIMCHistoryFromStorage(),
          builder: (context, _) {
            var list = context.read<IMCHistoryCubit>().imcHistory;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, _) => Divider(),
                      itemCount: list.length,
                      itemBuilder: (context, index) => HistoryItem(
                        imc: list[index],
                      ),
                    ),
                  ),
                  IMCPrimaryButton(
                    onPressed: () {
                      context.read<IMCHistoryCubit>().deleteIMCStorage();
                    },
                    color: Colors.red,
                    text: AppStrings.deleteHistory,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
