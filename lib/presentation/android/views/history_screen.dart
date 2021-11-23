import 'package:imc/presentation/android/admob/app_ads.dart';
import 'package:imc/presentation/android/widget/imc_primary_button.dart';
import 'package:imc/presentation/android/widget/history_item.dart';
import 'package:imc/presentation/android/widget/pop_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/bloc/history_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  AdsManager adsManager = AdsManager();

  @override
  void initState() {
    super.initState();
    adsManager.createBannerAdWithDefaultSize();
    adsManager.createBannerAdWithCustomSize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<IMCHistoryCubit>(context).loadIMCHistoryFromStorage();
  }

  @override
  void dispose() {
    adsManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IMCHistoryCubit, List<ImcModel>>(
      builder: (context, imcHistoryState) {
        var list = context.read<IMCHistoryCubit>().getIMCHistory().toList();
        return RefreshIndicator(
          onRefresh: context.read<IMCHistoryCubit>().loadIMCHistoryFromStorage,
          child: imcHistoryState.isEmpty
              ? EmptyHistory(adsManager: adsManager)
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
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => QuestionDialog(
                              onOkButtonHitted: () => context
                                  .read<IMCHistoryCubit>()
                                  .deleteIMCStorage(),
                              message: AppStrings.clearHistory,
                            ),
                          );
                        },
                        color: Colors.red,
                        text: AppStrings.deleteHistory,
                      ),
                      Container(
                        child: adsManager.adBannerWidgetWithDefaultSize(),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({
    required this.adsManager,
    Key? key,
  }) : super(key: key);

  final AdsManager adsManager;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: const Text(AppStrings.emptyHistory),
          ),
        ),
        Expanded(
          child: Container(
            child: adsManager.adBannerWidgetWithCustomSize(),
          ),
        ),
      ],
    );
  }
}
