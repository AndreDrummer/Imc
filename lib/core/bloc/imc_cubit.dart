import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/shared/local_storage.dart';
import 'package:imc/core/shared/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class ImcCubit extends Cubit<ImcModel> {
  ImcCubit() : super(ImcModel.initial());

  late String _weight;
  late String _height;

  bool allFieldsAreValids() {
    print('here $_weight $_height');
    return _height.trim().isNotEmpty && _weight.trim().isNotEmpty;
  }

  void setWeight(String value) {
    _weight = value.replaceAll(',', '.');
  }

  void setHeight(String value) {
    _height = value.replaceAll(',', '.');
  }

  void calculateIMC() {
    try {
      if (allFieldsAreValids()) {
        double imcCalc = nickTrefethenIMC();

        final generatedIMC = ImcModel(
          imcValue: double.parse(imcCalc.toStringAsFixed(2)),
          height: double.tryParse(_height) ?? 0.0,
          weight: double.tryParse(_weight) ?? 0.0,
          description: getIMCDesription(imcCalc),
          dateTime: DateTime.now(),
          id: Uuid().v4(),
        );

        LocalStorage.persistIMCOnStorage(generatedIMC);
        emit(generatedIMC);
      } else {
        throw AppExceptions(AppStrings.fillAllFields);
      }
    } on AppExceptions catch (exception) {
      debugPrint(exception.toString());
    }
  }

  double nickTrefethenIMC() {
    final height = double.tryParse(_height) ?? 0.0;
    final weight = double.tryParse(_weight) ?? 0.0;
    return 1.3 * weight / pow(height, 2.5);
  }

  double defaultIMC() {
    final height = double.tryParse(_height) ?? 0.0;
    final weight = double.tryParse(_weight) ?? 0.0;
    return weight / (height * height);
  }

  void reset() {
    _height = '';
    _weight = '';
    emit(ImcModel.initial());
  }

  String getIMCDesription(double imc) {
    if (imc < 18.6) {
      return AppStrings.underWeight;
    } else if (imc >= 18.6 && imc <= 24.9) {
      return AppStrings.weightIdeal;
    } else if (imc >= 24.9 && imc <= 29.9) {
      return AppStrings.sliglyOverWeight;
    } else if (imc >= 24.9 && imc <= 34.9) {
      return AppStrings.obesityLevelOne;
    } else if (imc >= 34.9 && imc <= 39.9) {
      return AppStrings.obesityLevelTwo;
    } else if (imc >= 40) {
      return AppStrings.obesityLevelThree;
    }
    return '';
  }
}
