import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:imc/core/shared/local_storage.dart';

class IMCHistoryCubit extends Cubit<List<ImcModel>> {
  IMCHistoryCubit() : super([]);

  List<ImcModel> imcHistory = [];

  Future<void> loadIMCHistoryFromStorage() async {
    imcHistory = await LocalStorage.loadIMCFromStorage();
    emit(imcHistory);
  }

  Future<void> deleteIMCStorage() async {
    await LocalStorage.deleteIMCStorage();
    imcHistory = [];
    emit(imcHistory);
  }

  List<ImcModel> subListImcHistory([int length = 2]) {
    if (imcHistory.length < length) {
      return imcHistory;
    } else {
      return imcHistory.reversed.toList().sublist(0, length);
    }
  }
}
