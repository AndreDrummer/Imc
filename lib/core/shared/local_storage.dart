import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:imc/core/models/imc_model.dart';

class LocalStorage {
  static final String _imcDataHistoryBoxName = 'imcDataHistory';
  static late Box<ImcModel> _imcBox;

  static Future<void> initializeLocalStorage() async {
    await Hive
      ..initFlutter()
      ..registerAdapter(ImcModelAdapter());
  }

  static Future persistIMCOnStorage(ImcModel imc) async {
    if (Hive.isBoxOpen(_imcDataHistoryBoxName)) {
      _imcBox = Hive.box(_imcDataHistoryBoxName);
    } else {
      _imcBox = await Hive.openBox<ImcModel>(_imcDataHistoryBoxName);
    }

    _imcBox.put(imc.id, imc);
  }

  static Future<List<ImcModel>> loadIMCFromStorage() async {
    return List<ImcModel>.from(_imcBox.values.map((e) => e));
  }
}
