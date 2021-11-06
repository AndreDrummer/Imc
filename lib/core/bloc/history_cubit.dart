import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/models/imc_model.dart';

class IMCHistoryCubit extends Cubit<List<ImcModel>> {
  IMCHistoryCubit() : super([]);

  List<ImcModel> imcHistory = [];

  Future<void> loadIMCHistoryFromStorage() async {}
}
