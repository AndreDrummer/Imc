import 'package:imc/core/bloc/history_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:flutter/material.dart';
import 'package:imc/presentation/android/widget/history_item.dart';
import 'package:imc/presentation/android/widget/imc_primary_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IMCHistoryCubit, List<ImcModel>>(
      builder: (context, imcHistoryState) {
        var list = context.read<IMCHistoryCubit>().imcHistory.reversed.toList();
        return imcHistoryState.isEmpty
            ? EmptyHistory()
            : Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
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
  }
}

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(AppStrings.emptyHistory),
    );
  }
}
