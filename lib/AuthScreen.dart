import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_book_club/MainScreen.dart';

class AuthScreen extends StatefulWidget {
  final String data;

  AuthScreen({required this.data});

  @override
  _AuthScreenState createState() => _AuthScreenState();

  // static void navigateTo(BuildContext context, String data) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => AuthScreen(data: data),
  //     ),
  //   );
  // }
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> saveUser(User user, context) async{
    try{
      final userCollection = FirebaseFirestore.instance.collection("Users");
      final doc = await userCollection.doc(user.uid).get();

      if (!doc.exists) {
        await userCollection.doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'clubNames': [],
        });
      }

    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }
    

  Future<void> signUp(context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

    await saveUser(userCredential.user!, context);

    //Navigator.pushNamed(context, 'MainScreen');
    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MainScreen(
                        currentUser: userCredential.user!.uid,
    )));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  Future<void> signIn(context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

     await saveUser(userCredential.user!, context);

      //Navigator.pushNamed(context, 'MainScreen');
      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MainScreen(
                        currentUser: userCredential.user!.uid,
    )));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in/Sign up',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'DMSerifDisplay',
        ),
        ),
        backgroundColor: const Color.fromARGB(255, 237, 209, 254),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),      
            TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 237, 209, 254),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                child: Text('Sign Up'),
                     onPressed:(){
                          signUp(context);
                        } 
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 237, 209, 254),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                child: Text('Sign In'),
                        onPressed:(){
                          signIn(context);
                        } 
                        
                      ),
                ),
            ),
  
              ],
            ),
        ),
      );
  }
}

