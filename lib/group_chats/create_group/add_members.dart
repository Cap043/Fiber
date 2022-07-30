import 'package:chat_app/group_chats/create_group/create_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddMembersInGroup extends StatefulWidget {
  const AddMembersInGroup({Key? key}) : super(key: key);

  @override
  State<AddMembersInGroup> createState() => _AddMembersInGroupState();
}

class _AddMembersInGroupState extends State<AddMembersInGroup> {
  final TextEditingController _search = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> membersList = [];
  bool isLoading = false;
  Map<String, dynamic>? userMap;

  @override
  void initState() {
    super.initState();
    getCurrentUserDetails();
  }

  void getCurrentUserDetails() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((map) {
      setState(() {
        membersList.add({
          "name": map['name'],
          "email": map['email'],
          "uid": map['uid'],
          "isAdmin": true,
        });
      });
    });
  }

  void onSearch() async {
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

  void onResultTap() {
    bool isAlreadyExist = false;

    for (int i = 0; i < membersList.length; i++) {
      if (membersList[i]['uid'] == userMap!['uid']) {
        isAlreadyExist = true;
      }
    }

    if (!isAlreadyExist) {
      setState(() {
        membersList.add({
          "name": userMap!['name'],
          "email": userMap!['email'],
          "uid": userMap!['uid'],
          "isAdmin": false,
        });

        userMap = null;
      });
    }
  }

  void onRemoveMembers(int index) {
    if (membersList[index]['uid'] != _auth.currentUser!.uid) {
      setState(() {
        membersList.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //SCAFFOLD STARTS HERE:::::::::::::::::::::::::::::::::::::::::HERE@@@@@@@@@@@@@@@@@           @@@@@@@@@@@@@@@@@@@@@@        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 4, 46),
        title: Text(
          "Add Members",
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("Assets/667a32c55b2a77fd5dc582f066b646f0.jpg"),
          fit: BoxFit.cover,
        )),
        //decoration: BoxDecoration(
        //       image: DecorationImage(
        //     image: AssetImage(
        //         "Assets/94f2a6bc8eab5465ffef40e7f4cb9afc--the-internet-walls.jpg"),
        //     fit: BoxFit.cover,
        //   )),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: membersList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.black54,
                      child: ListTile(
                        onTap: () => onRemoveMembers(index),
                        leading: Icon(Icons.account_circle),
                        title: Text(
                          membersList[index]['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(membersList[index]['email'],
                            style: TextStyle(color: Colors.white)),
                        trailing: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
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
                      color: Color.fromARGB(185, 20, 7, 138),
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
                              color: Color.fromARGB(255, 255, 255, 255),
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
              isLoading
                  ? Container(
                      height: size.height / 12,
                      width: size.height / 12,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: onSearch,
                      child: Text("Search"),
                    ),
              userMap != null
                  ? Container(
                      color: Colors.white54,
                      child: ListTile(
                        onTap: onResultTap,
                        leading: Icon(Icons.account_box),
                        title: Text(userMap!['name']),
                        subtitle: Text(userMap!['email']),
                        trailing: Icon(Icons.add),
                      ),
                    )
                  : SizedBox(
                      height: 475,
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: membersList.length >= 2
          ? FloatingActionButton(
              child: Icon(Icons.forward),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CreateGroup(
                    membersList: membersList,
                  ),
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
