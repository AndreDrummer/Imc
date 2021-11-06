import 'dart:math';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:imc/core/shared/exceptions.dart';

class ImcCubit extends Cubit<ImcModel> {
  ImcCubit() : super(ImcModel.initial());

  var weightCtrl = MaskedTextController(mask: '00.00');
  var heightCtrl = MaskedTextController(mask: '0.00');

  bool allFieldsAreValids() {
    return heightCtrl.text.trim().isNotEmpty &&
        weightCtrl.text.trim().isNotEmpty;
  }

  void calculateIMC() {
    try {
      if (allFieldsAreValids()) {
        debugPrint('Do your work! ${heightCtrl.text} ${weightCtrl.text}');

        final generatedIMC = ImcModel(
          height: double.tryParse(heightCtrl.text) ?? 0.0,
          weight: double.tryParse(weightCtrl.text) ?? 0.0,
          imcValue: nickTrefethenIMC(),
          description: '',
        );

        emit(generatedIMC);
      } else {
        throw AppExceptions('Preencha todos os campos!');
      }
    } on AppExceptions catch (exception) {
      debugPrint(exception.toString());
    }
  }

  double nickTrefethenIMC() {
    final height = double.tryParse(heightCtrl.text) ?? 0.0;
    final weight = double.tryParse(weightCtrl.text) ?? 0.0;
    return 1.3 * weight / pow(height, 2.5);
  }

  double defaultIMC() {
    final height = double.tryParse(heightCtrl.text) ?? 0.0;
    final weight = double.tryParse(weightCtrl.text) ?? 0.0;
    return weight / (height * height);
  }

  void reset() {
    heightCtrl.clear();
    weightCtrl.clear();
    emit(ImcModel.initial());
  }
}
