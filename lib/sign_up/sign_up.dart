import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference user  =  fireStore.collection("users");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                            "User Sign-Up",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 20,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        TextField(
                          controller: name,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                          decoration: InputDecoration(
                            hintText: "Enter Name",
                            hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w400, fontSize: 15),
                            isDense: true,
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
                              if(name.text != '' && email.text != '' && password.text != ''){
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .add({'name': name.text, 'email': email.text, 'password': password.text}).catchError((e){
                                  print(e.toString());
                                }).then((value) {
                                  print('success$value');
                                });
                              }else{

                              }
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
    );
  }
}
