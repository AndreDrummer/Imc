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
}
