import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login/sign_up/sign_up.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference user  =  fireStore.collection("users");
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return SignUpScreen();
            }));
          },
          child: Container(
            width: size.width,
            height: size.height*0.06,
            color: Colors.blue,
            child: Center(
              child: Text(
                "Sign-Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                    "assets/chatBack.jpg",
                  width: size.width*0.4,
                  height: size.height*0.4,
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Center(
                            child: Text(
                              "User Sign-In",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          TextField(
                            controller: email,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                            decoration: InputDecoration(
                              hintText: "Enter Email",
                              hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w400, fontSize: 15),
                              isDense: true,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "Password",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          TextField(
                            controller: password,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w400, fontSize: 15),
                              isDense: true,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Center(
                            child: MaterialButton(
                              color: Colors.grey[200],
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              onPressed: () async {
                                user.get().then((value) {
                                  value.docs.forEach((e) {
                                    if(e['email'] == email.text){
                                      print('success');
                                    }
                                  });
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
