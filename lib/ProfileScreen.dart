import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_club/BookClub.dart';
import 'package:flutter_book_club/BookClubScreen.dart';

class ProfileScreen extends StatelessWidget {
  final String currentUser;

  ProfileScreen({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile",
      style: TextStyle(
            fontFamily: 'DMSerifDisplay',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
      ),
      backgroundColor: const Color.fromARGB(255, 237, 209, 254),
      ),
      body:  Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text("Your clubs",
            style: TextStyle(
              fontFamily: 'DMSerifDisplay',
              fontSize: 20,
              
            ),
            ),
          ),
          FutureBuilder(
          future: getOwnClubs(currentUser),
          builder: (context, snapshot) {
          /// if Error
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          /// On completion
          if (snapshot.connectionState == ConnectionState.done) {
            List<BookClub> list = snapshot.data as List<BookClub>;
            return 
              Expanded(child: buildGridView(list, currentUser));
          }

          /// On Loading
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 3,
          ));
        },)
      ],
      ),
    ),
    );
  }
}

getOwnClubs(String currentUser) async{
  List<BookClub> clubs =[];
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
    .collection('Users')
      .doc(currentUser)
      .get();
  if (userSnapshot.exists) {
    List<dynamic> clubNames = userSnapshot['clubNames'] ?? [];

   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Book club")
        .get();

    for (var element in querySnapshot.docs) {
      if (clubNames.contains(element.id)) {
        clubs.add(BookClub.fromDoc(element));
      }
    }
  }
    return clubs;
}

Widget buildGridView(List<BookClub> list, String? currentUser) {
  return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Column(children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => BookClubScreen(
                        currentItem: list[index],
                        currentUser: currentUser,
                      )));
                  },
                 child: ListTile(
                  leading: Image.network('${list[index].image}'), 
                  title: Text('${list[index].name}',
                  style: TextStyle(
                    fontFamily: 'DMSerifDisplay',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  subtitle: Text("Author: ${list[index].author}\nReading time: ${list[index].readingTime} hour(s)",
                  style: TextStyle(
                    fontFamily: 'DMSerifDisplay',
                    fontSize: 15,
                  ),
                  ),
                ),  
                ),
              Divider()
              ],
              );
            },
          );
}