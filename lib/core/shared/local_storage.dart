import 'package:hive_flutter/hive_flutter.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'dart:io';

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
    var list = List<ImcModel>.from(_imcBox.values.map((e) => e));
    return list;
  }

  static Future<void> deleteIMCStorage() async {
    await getOrOpenBox();
    return _imcBox.deleteFromDisk();
  }

  static Future<void> getOrOpenBox() async {
    if (Hive.isBoxOpen(_imcDataHistoryBoxName)) {
      _imcBox = Hive.box(_imcDataHistoryBoxName);
    } else {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      _imcBox = await Hive.openBox<ImcModel>(_imcDataHistoryBoxName,
          path: appDocPath);
    }
  }
}
