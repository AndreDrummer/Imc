import 'package:imc/core/bloc/history_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IMCHistoryCubit, List<ImcModel>>(
      builder: (context, imcHistoryState) {
        return FutureBuilder<void>(
          future: context.read<IMCHistoryCubit>().loadIMCHistoryFromStorage(),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: context
                    .read<IMCHistoryCubit>()
                    .imcHistory
                    .map((imcItem) => HistoryItem(imc: imcItem))
                    .toList(),
              ),
            );
          },
        );
      },
    );
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    required this.imc,
    Key? key,
  }) : super(key: key);

  final ImcModel imc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(imc.description),
      subtitle: Text(imc.imcValue.toString()),
    );
  }
}
