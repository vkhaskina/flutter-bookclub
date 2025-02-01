import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_club/BookClub.dart';
import 'package:flutter_book_club/ChatScreen.dart';

class BookClubScreen extends StatefulWidget {
  final BookClub currentItem;
  final String? currentUser;

  BookClubScreen({required this.currentItem, this.currentUser});

  @override
  _BookClubScreenState createState() => _BookClubScreenState();
}

class _BookClubScreenState extends State<BookClubScreen> {
  bool isJoined = false;
  int membersCount = 1;

  @override
  void initState() {
    super.initState();
    loadClubData(); 
    checkMembership();
  }

  Future<void> loadClubData() async {
    DocumentSnapshot clubSnapshot = await FirebaseFirestore.instance
        .collection('Book club')
        .doc(widget.currentItem.docId)
        .get();

    if (clubSnapshot.exists) {
      setState(() {
        membersCount = clubSnapshot['membersCount'] ?? 0;
      });
    }
  }

  Future<void> checkMembership() async {
    if (widget.currentUser == null) return;

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.currentUser)
        .get();

    if (userSnapshot.exists) {
      List<dynamic> clubNames = userSnapshot['clubNames'] ?? [];
      if (clubNames.contains(widget.currentItem.docId)) {
        setState(() {
          isJoined = true;
        });
      }
    }
  }

  void updateMembers() {
    FirebaseFirestore.instance
        .collection('Book club')
        .doc(widget.currentItem.docId)
        .update({"membersCount": FieldValue.increment(1)}).then((_) {
      setState(() {
        membersCount++;
      });
    });
  }

  void updateClubs() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.currentUser)
        .update({"clubNames": FieldValue.arrayUnion([widget.currentItem.docId])});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.currentItem.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'DMSerifDisplay',
            fontSize: 25,
          ),
          ),
          backgroundColor: const Color.fromARGB(255, 237, 209, 254),
        ),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: 150,
                child: Image.network(
                  widget.currentItem.image,
                  fit: BoxFit.fill,
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 70),
              height: 30,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 237, 209, 254),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.add,
                        size: 30,
                      ),
                      Text(
                        isJoined ? "Open discussion" : "Join",
                        style: TextStyle(
                          fontFamily: 'DMSerifDisplay',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          //color: const Color.fromARGB(204, 0, 0, 0),
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    if (!isJoined && widget.currentUser != null) {
                      updateClubs();
                      updateMembers();
                      setState(() {
                        isJoined = true;
                      });
                    }else if(isJoined && widget.currentUser != null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                              clubId: widget.currentItem.docId,
                              currentUser: widget.currentUser!),
                        ),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('This functionality is unavailable for anonymous users :('),
                      ));
                    }
                  }),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(
                    '${widget.currentItem.name}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'DMSerifDisplay',),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(
                    'Members: $membersCount',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'DMSerifDisplay',
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(
                    textAlign: TextAlign.justify,
                    '${widget.currentItem.description}',
                    style: TextStyle(fontSize: 20,
                    fontFamily: 'DMSerifDisplay',
                    ),
                  ),
                ),
                
              ],
            )
          ],
        ));
  }
}