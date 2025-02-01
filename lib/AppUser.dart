import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  late String uid;
  late String email;
  late List<String> clubNames;

  AppUser.fromDoc(QueryDocumentSnapshot doc){
    uid = doc.id;
    email = doc["email"] ?? "";
    clubNames = (doc["clubNames"] as List<dynamic>).cast<String>() ?? [];
  }
}