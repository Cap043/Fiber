import 'package:chat_app/Authenticate/Methods.dart';
import 'package:chat_app/Screens/ChatRoom.dart';
import 'package:chat_app/group_chats/group_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Authenticate/LoginScree.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> membersList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //MAIN SCAFFOLD STARTS HERE:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::HERE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 5, 4, 46),
        child: ListView(
          children: [
            DrawerHeader(
                child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(5)),
                    accountName: Center(
                        child: Text(
                      "FIBER",
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    )),
                    accountEmail:
                        Text("          The High Speed Messaging App"))),
            ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(),
                ),
              ),
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              horizontalTitleGap: 0,
              title: Text(
                "Home",
                textScaleFactor: 1.1,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GroupChatHomeScreen(),
                ),
              ),
              leading: Icon(
                CupertinoIcons.group,
                color: Colors.white,
              ),
              horizontalTitleGap: 0,
              title: Text(
                "Group Chat",
                textScaleFactor: 1.1,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LoginScreen())),
              leading: Icon(
                CupertinoIcons.return_icon,
                color: Colors.white,
              ),
              horizontalTitleGap: 0,
              title: Text(
                "Log Out",
                textScaleFactor: 1.1,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 340,
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.info_circle,
                color: Colors.white,
              ),
              title: Text(
                "Made By Sworjjomoy Pathak",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 4, 46),
        title: Text(
          "FIBER",
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("Assets/wp3998752.jpg"),
          fit: BoxFit.cover,
        )),
        child: isLoading
            ? Center(
                child: Container(
                  height: size.height / 20,
                  width: size.height / 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    height: size.height / 14,
                    width: size.width,
                    alignment: Alignment.center,
                    child: Container(
                      height: size.height / 14,
                      width: size.width / 1.15,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black45,
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.amberAccent),
                          controller: _search,
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.zero,
                                child: Icon(
                                  CupertinoIcons.search,
                                  color: Colors.white,
                                )),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  ElevatedButton(
                    onPressed: onSearch,
                    child: Text("Search"),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  userMap != null
                      ? ListTile(
                          onTap: () {
                            String roomId = chatRoomId(
                                _auth.currentUser!.displayName!,
                                userMap!['name']);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChatRoom(
                                  chatRoomId: roomId,
                                  userMap: userMap!,
                                ),
                              ),
                            );
                          },
                          leading: Icon(Icons.account_box,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          title: Text(
                            userMap!['name'],
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            userMap!['email'],
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Icon(Icons.chat,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        )
                      : Container(),
                  InkWell(
                    splashColor: Colors.amber,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => GroupChatHomeScreen())),
                    child: Container(
                        height: size.height / 14,
                        width: size.width / 1.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 0, 7, 44),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Create Group",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ],
              ),
      ),
    );
  }
}
