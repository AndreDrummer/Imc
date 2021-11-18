import 'package:imc/presentation/android/widget/history_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/bloc/history_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LastCalcs extends StatelessWidget {
  const LastCalcs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imcHistoryProvider = BlocProvider.of<IMCHistoryCubit>(context);
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
            SizedBox(
              height: 128.0.h,
              child: ListView(
                children: imcHistoryProvider
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
