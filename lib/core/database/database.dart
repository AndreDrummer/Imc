import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:imc/core/auth/auth_controller.dart';
import 'package:imc/core/models/imc_model.dart';

class DataCloud {
  DataCloud._();
  static final DataCloud dataCloud = DataCloud._();

  User? firebaseUser = AuthController.authController.firebaseUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _env = 'debug';

  Future saveInTheCloud(ImcModel imc) async {
    if (firebaseUser != null) {
      _firestore.doc('$_env/users/${firebaseUser!.uid}/premium').set(
        {'premium': false},
        SetOptions(merge: true),
      );

      _firestore.doc('$_env/users/${firebaseUser!.uid}/history').set(
        {'key': 'history'},
        SetOptions(merge: true),
      );

      CollectionReference userReference = _firestore
          .collection('$_env/users/${firebaseUser!.uid}/history/calculos');

      try {
        await userReference.add(imc.toJson());
      } on Exception catch (err) {
        throw Exception('Ocorreu um erro ao adicionar dados em nuvem: $err');
      }
    }
  }

  Future deleteIMCStorage() async {
    if (firebaseUser != null) {
      CollectionReference userReference = _firestore
          .collection('$_env/users/${firebaseUser!.uid}/history/calculos');

      try {
        QuerySnapshot docs = await userReference.get();
        for (var element in docs.docs) {
          element.reference.delete();
        }
      } on Exception catch (err) {
        throw Exception('Ocorreu um erro ao deletar dados em nuvem: $err');
      }
    }
  }
}
