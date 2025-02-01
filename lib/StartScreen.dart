import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_club/AuthScreen.dart';
import 'package:flutter_book_club/MainScreen.dart';
import 'package:flutter_book_club/main.dart';

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


class Startscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 249),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 255, 251, 249),
      ),
      body: ListView(
        children: <Widget>[
          userDetails(context),
        ],
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 255, 251, 249),
//         appBar: AppBar(
//           title: Text(
//             '',
//             style: TextStyle(fontFamily: 'casual'),
//           ),
//           elevation: 0.0,
//           backgroundColor: const Color.fromARGB(255, 255, 251, 249),
//         ),
//         body: ListView(
//           children: <Widget>[
//             userDetails(context),
//           ],
//         ));
//   }
// }

Widget userDetails(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(20),
    color: const Color.fromARGB(255, 255, 251, 249),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        titleGroup(),
        subtitleGroup(),
        buttonsGroup(context),
      ],
    ),
  );
}


Widget titleGroup(){
  return Center(
    child: Container(
      child: Text(
        "Organize your shape readings easy and fast",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color.fromARGB(204, 0, 0, 0),
          fontSize: 40,
          fontFamily: 'DMSerifDisplay',
          fontWeight: FontWeight.bold,
          //fontStyle: FontStyle.italic,
        ),
      ),
    ),
  );
}

Widget subtitleGroup(){
  return Center(
    //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Text(
          'Create clubs to read your books favourites with your friends!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color.fromARGB(164, 0, 0, 0),
            fontFamily: 'DMSerifDisplay',
            fontSize: 15,
          ))
  );
}

Widget buttonsGroup(BuildContext context){
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 40),
            child: Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 237, 209, 254),
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.mail,
                      color: const Color.fromARGB(255, 255, 251, 249),
                      size: 25,
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                        fontSize: 25,
                        color: const Color.fromARGB(255, 255, 251, 249),
                      ),
                    ),
                    Text(
                      "Email", 
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(204, 0, 0, 0), 
                        fontFamily: 'DMSerifDisplay',
                      ),
                    )
                ],),
                onPressed: () {
                  Navigator.pushNamed(context, "AuthScreen");
                }
                              
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 40),
            child: Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 237, 209, 254),
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.person_2,
                      color: const Color.fromARGB(255, 255, 251, 249),
                      size: 25,
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                        fontSize: 25,
                        color: const Color.fromARGB(255, 255, 251, 249),
                      ),
                    ),
                    Text(
                      "Anonymous", 
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(204, 0, 0, 0), 
                        fontFamily: 'DMSerifDisplay',
                      ),
                    )
                ],),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MainScreen()));
                }
                              
                ),
            ),
          ),
        ],
      )
    ),
  );
}
