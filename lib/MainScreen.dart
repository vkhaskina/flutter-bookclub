import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_club/AppUser.dart';
import 'package:flutter_book_club/BookClub.dart';
import 'package:flutter_book_club/StartScreen.dart';
import 'package:flutter_book_club/BookClubScreen.dart';
import 'package:flutter_book_club/ProfileScreen.dart';

// Future<void> main() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp(
//     options: const FirebaseOptions(
//     apiKey: "AIzaSyDw2B4sUPYAqo_m9P1Nzw2BKSPejSTbfMA",
//     appId: "1:547051366289:android:03908eba18845f3178dc30",
//     messagingSenderId: "1547051366289",
//     projectId: "book-club-97f43",
//     storageBucket: "book-club-97f43.appspot.com",
//     )
//   );
//   runApp(MyApp());
// }

class MainScreen extends StatelessWidget {
  final String? currentUser;

  MainScreen({this.currentUser});
  
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 237, 209, 254),
      title: Row(
        children: <Widget>[
        if (currentUser != null)
        FutureBuilder(
          future: getCurrentUser(currentUser!),
          builder: (context, snapshot){

          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          /// On completion
          if (snapshot.connectionState == ConnectionState.done) {
            AppUser user = snapshot.data as AppUser;
            print(user.email);
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 30),
                  child: IconButton(
                    icon: Icon(Icons.account_circle_outlined),
                    //color: const Color.fromARGB(255, 255, 251, 249),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                currentUser: currentUser!),
                          ),
                        );
                    },
                                ),
                ),
                Column(
                  children: [
                    Text('Hello, Reader!', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DMSerifDisplay',
                      //color: const Color.fromARGB(255, 255, 251, 249),
                    ),
                    ),

                    if (user.clubNames.isNotEmpty)
                      Text('You are in ${user.clubNames.length} clubs', style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontFamily: 'DMSerifDisplay',
                      )
                      ), 
                    if (user.clubNames.isEmpty)
                     Text('You are in 0 clubs', style: TextStyle(
                        fontSize: 15,
                        color: Colors.black38,
                        fontFamily: 'DMSerifDisplay',
                      )
                      ), 
                  ],
                 ),
              ],
            );
          }
          return CircularProgressIndicator(
            strokeWidth: 3,
          );
         },
         )
      else
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 30),
                  child: IconButton(
                    icon: Icon(Icons.account_circle_outlined),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.pushNamed(context, "AuthScreen");
                    },
                                ),
                ),
                Column(
                  children: [
                    Text('Hello, Reader!', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DMSerifDisplay',
                      //color: const Color.fromARGB(255, 255, 251, 249)
                    ),
                    ),
                     Text('You are in 0 clubs', style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontFamily: 'DMSerifDisplay',
                      )
                      ), 
                  ],
                 ),
              ],
            ),
      ],)
    ),
    body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buttonGroup(context),
          description(),
          FutureBuilder(
          future: getClubs(),
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

Widget buttonGroup(BuildContext context){
          return Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 110,
                    child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 237, 209, 254),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),             
                      child: 
                      //Text('Publications', style: TextStyle(
                      Text('Coming soon!', 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'DMSerifDisplay',
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                           onPressed:(){
                                
                          }
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 110,
                    child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 237, 209, 254),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      child: 
                      Text('Coming soon!', 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      //Text('Friends', style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'DMSerifDisplay',
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      onPressed:(){
                                
                          }
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 110,
                    child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 237, 209, 254),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      child: 
                      Text('Coming soon!', 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      //Text('Clubs', style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'DMSerifDisplay',
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                           onPressed:(){
                                
                          }
                    ),
                  )
              ],),
            ),
          );
}

Widget description() {
  return Container(
  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
  child: 
  Text("Public clubs", style: 
  TextStyle(
    fontFamily: 'DMSerifDisplay',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),),
  );
}

getCurrentUser(String currentUser) async{
    AppUser appuser;
    final querySnapshot = await FirebaseFirestore.instance
    .collection("Users")
    .get();
    
    for (var doc in querySnapshot.docs){
      if(doc['uid'] == currentUser){
        appuser = AppUser.fromDoc(doc);
        return appuser;
      }
    }
    return null;
}


Future<List<AppUser>> getUsers() async{
  List<AppUser> appusers =[];
    await FirebaseFirestore.instance
    .collection("Users")
    .get()
    .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.size);
      querySnapshot.docs.forEach((QueryDocumentSnapshot element){
        appusers.add(AppUser.fromDoc(element));
      });
    });
    return appusers;
}

getClubs()  async{
  List<BookClub> clubs =[];
    await FirebaseFirestore.instance
    .collection("Book club")
    .get()
    .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.size);
      querySnapshot.docs.forEach((QueryDocumentSnapshot element){
        clubs.add(BookClub.fromDoc(element));
      });
    });
    return clubs;
}