import 'package:flutter/material.dart';
import 'package:imc/core/models/imc_model.dart';

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
      subtitle: Text('IMC Calculado: ${imc.imcValue}'),
      trailing: Column(
        children: [
          Text('06/11/2021'),
          Text('20:47'),
        ],
      ),
    );
  }
}
