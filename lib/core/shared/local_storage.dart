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
    await getOrOpenBox();
    _imcBox.put(imc.id, imc);
  }

  static Future<List<ImcModel>> loadIMCFromStorage() async {
    await getOrOpenBox();
    return List<ImcModel>.from(_imcBox.values.map((e) => e));
  }

  static Future<void> deleteIMCStorage() async {
    await getOrOpenBox();
    return _imcBox.deleteFromDisk();
  }

  static Future<void> getOrOpenBox() async {
    if (await Hive.boxExists(_imcDataHistoryBoxName) &&
        Hive.isBoxOpen(_imcDataHistoryBoxName)) {
      _imcBox = Hive.box(_imcDataHistoryBoxName);
    } else {
      _imcBox = await Hive.openBox<ImcModel>(_imcDataHistoryBoxName);
    }
  }
}
