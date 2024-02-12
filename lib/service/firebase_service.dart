// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firebaseCloud = FirebaseFirestore.instance;

  Future<void> saveCitySearch(String dataCity) async {
    try {
      await _firebaseCloud
          .collection('CidadesPesquisadas')
          .doc('locais')
          .set({'cidade': dataCity});
    } on FirebaseException catch (e) {
      print('Erro ao adicionar dados: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getCitySave() async {
    DocumentSnapshot documentSnapshot = await _firebaseCloud
        .collection('CidadesPesquisadas')
        .doc('locais')
        .get();
    final docMap = documentSnapshot.data() as Map<String, dynamic>;
    return docMap;
  }

  Future<List> getHistory() async {
    DocumentSnapshot documentSnapshot = await _firebaseCloud
        .collection('CidadesPesquisadas')
        .doc('historico')
        .get();
    final docMap = documentSnapshot.data() as Map<String, dynamic>;
    return docMap['locais'];
  }

  Stream<Map<String, dynamic>> getHistoryStream() {
    final DocumentReference docRef =
        _firebaseCloud.collection('CidadesPesquisadas').doc('historico');
    return docRef
        .snapshots()
        .map((snapshot) => snapshot.data() as Map<String, dynamic>);
  }

  Future<void> setHistory(String city) async {
    List _history = await getHistory();
    _history.add(city);
    _firebaseCloud
        .collection('CidadesPesquisadas')
        .doc('historico')
        .set({'locais': _history});
  }

  Future<void> deleteHistory(String city) async {
    List _history = await getHistory();
    _history.remove(city);
    _firebaseCloud
        .collection('CidadesPesquisadas')
        .doc('historico')
        .set({'locais': _history});
  }
}
