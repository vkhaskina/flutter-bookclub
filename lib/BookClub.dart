import 'package:cloud_firestore/cloud_firestore.dart';

class BookClub {
  late String author;
  late String image;
  late int readingTime;
  late String name;
  late String description;
  late int membersCount;
  late String docId;
  

  BookClub.fromDoc(QueryDocumentSnapshot doc){
    name = doc["name"];
    author = doc["author"];
    image = doc["image"];
    readingTime = doc["readingTime"];
    membersCount= doc["membersCount"];
    description = doc["description"];
    docId = doc.id;
  }
}