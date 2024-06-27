import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addInfoDetails(Map<String, dynamic> infoInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("info")
        .doc(id)
        .set(infoInfoMap);
  }

  Future<Stream<QuerySnapshot>> getInfoDetails() async {
    return await FirebaseFirestore.instance.collection("info").snapshots();
  }

  Future UpdateInfoDetails(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("info")
        .doc(id)
        .update(updateInfo);
  }

  Future DeleteInfoDetails(String id) async {
    return await FirebaseFirestore.instance.collection("info").doc(id).delete();
  }

  Future<Stream<QuerySnapshot>> getDetectionHistory() async {
    return await FirebaseFirestore.instance
        .collection("all_history")
        .snapshots();
  }

  Stream<QuerySnapshot> getUserDetectionHistory(String userId) {
  return FirebaseFirestore.instance
      .collection("user_history")
      .doc(userId)
      .collection("history")
      .orderBy('timestamp', descending: true)
      .snapshots();
}

}
