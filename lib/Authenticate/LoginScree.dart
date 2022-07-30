import 'package:chat_app/Authenticate/CreateAccount.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Authenticate/Methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isLoading = false;
  var temp = 0;
  bool changeButton = false;
  late String username2 = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 35,
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: Text(
            "FIBER",
            style: TextStyle(
                color: Color.fromARGB(255, 5, 4, 46),
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 5, 4, 46),
        body: isLoading
            ? Center(
                child: Container(
                  height: size.height / 20,
                  width: size.height / 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: size.width / 0.5,
                        child: IconButton(
                            icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
                      ),

                      Container(
                        width: size.width / 1.1,
                        child: Center(
                          child: Text(
                            " Welcome",
                            style: TextStyle(
                              fontSize: 34,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 1.1,
                        child: Center(
                          child: Text(
                            " $username2",
                            style: TextStyle(
                              fontSize: 34,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: size.width / 1.1,
                      //   child: Text(
                      //     "                    Sign In",
                      //     style: TextStyle(
                      //       color: Colors.amber,
                      //       fontSize: 25,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Image.asset("Assets/undraw_male_avatar_323b.png",
                                  height: 200),
                              Container(
                                width: size.width / 1.1,
                                child: Text(
                                  "                    Sign In",
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Container(
                                margin: EdgeInsets.all(12),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w400),
                                        prefixIcon: Padding(
                                          padding: EdgeInsetsDirectional.zero,
                                          child:
                                              Icon(CupertinoIcons.person_solid),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)))),
                                    onChanged: (value) {
                                      username2 = value;
                                      setState(() {});
                                    }),
                              ),
                              Container(
                                width: size.width,
                                alignment: Alignment.center,
                                child: Container(
                                    child: field(size, "Email",
                                        Icons.email_rounded, _email)),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Container(
                                    width: size.width,
                                    alignment: Alignment.center,
                                    child: Container(

                                        // decoration: BoxDecoration(
                                        //     color: Color.fromARGB(240, 253, 253, 253),
                                        //     borderRadius:
                                        //         BorderRadius.all(Radius.circular(10))),
                                        child: field(
                                      size,
                                      "Password",
                                      Icons.lock,
                                      _password,
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),

                      // SizedBox(
                      //   height: 34,
                      // ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 0,
                          ),
                          customButton(),
                          SizedBox(
                            width: 10,
                            height: 0,
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => CreateAccount())),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                height: 55,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Sworjjomoy's Edit Final::::::::::::::::::::::::::::
                      SizedBox(height: 20, width: 5),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget customButton() {
    return Container(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        child: AnimatedButton(
          height: 55,
          width: 150,
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
              setState(() {
                isLoading = true;
              });

              logIn(_email.text, _password.text).then((user) {
                if (user != null) {
                  print("Login Sucessfull");
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                } else {
                  setState(() {});
                  setState(() {
                    isLoading = false;
                  });
                }
              });
            } else {
              print("Please fill form correctly");
            }
          },
        ),
      ),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
