import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'calculation_history';

  Future<void> saveCalculation(String calculation, String result) async {
    try {
      await _firestore.collection(_collection).add({
        'calculation': calculation,
        'result': result,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save calculation');
    }
  }

  Stream<QuerySnapshot> getCalculationHistory() {
    return _firestore
        .collection(_collection)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> deleteCalculation(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete calculation');
    }
  }

  Future<void> clearHistory() async {
    try {
      final snapshots = await _firestore.collection(_collection).get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to clear history');
    }
  }
}
