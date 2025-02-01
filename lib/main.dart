// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_book_club/StartScreen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyDw2B4sUPYAqo_m9P1Nzw2BKSPejSTbfMA",
//       appId: "1:547051366289:android:03908eba18845f3178dc30",
//       messagingSenderId: "1547051366289",
//       projectId: "book-club-97f43",
//       storageBucket: "book-club-97f43.appspot.com",
//     ),
//   );

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Book Club',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//       ),
//       initialRoute: 'StartScreen', // Стартовый экран
//       routes: {
//         'StartScreen': (context) => StartScreen(), // Экран приветствия или загрузки
//         'AuthScreen': (context) => AuthScreen(data: "default"), // Экран авторизации
//         'MainScreen': (context) => MainScreen(), // Главный экран после входа
//       },
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_club/AuthScreen.dart';
import 'package:flutter_book_club/MainScreen.dart';
import 'package:flutter_book_club/StartScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDw2B4sUPYAqo_m9P1Nzw2BKSPejSTbfMA",
      appId: "1:547051366289:android:03908eba18845f3178dc30",
      messagingSenderId: "1547051366289",
      projectId: "book-club-97f43",
      storageBucket: "book-club-97f43.appspot.com",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: 'StartScreen',
      onGenerateRoute: (settings) {
        if (settings.name == 'MainScreen') {
          final String currentUser = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => MainScreen(currentUser: currentUser),
          );
        }
        return null;
      },
      routes: {
        'StartScreen': (context) => Startscreen(),
        'AuthScreen': (context) => AuthScreen(data: ''),
      },
    );
  }
}