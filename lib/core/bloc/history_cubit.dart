import 'package:imc/core/shared/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/models/imc_model.dart';

class IMCHistoryCubit extends Cubit<List<ImcModel>> {
  IMCHistoryCubit() : super([]);

  List<ImcModel> _imcHistory = [];

  void setIMCHistory(List<ImcModel> imcHistory) {
    _imcHistory = imcHistory;
  }

  List<ImcModel> getIMCHistory() {
    _imcHistory.sort(
      (a, b) =>
          b.dateTime.millisecondsSinceEpoch - a.dateTime.millisecondsSinceEpoch,
    );
    return _imcHistory;
  }

  Future<void> loadIMCHistoryFromStorage() async {
    setIMCHistory(await LocalStorage.loadIMCFromStorage());
    emit(_imcHistory);
  }

  Future<void> deleteIMCStorage() async {
    await LocalStorage.deleteIMCStorage();
    setIMCHistory([]);
    emit(_imcHistory);
  }

  List<ImcModel> subListImcHistory([int length = 2]) {
    if (_imcHistory.length < length) {
      return getIMCHistory();
    } else {
      return getIMCHistory().sublist(0, length).reversed.toList();
    }
  }
}
