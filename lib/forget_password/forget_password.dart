import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forget extends StatelessWidget {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void validate(BuildContext context) async {
    if (form.currentState.validate()) {
      sendRest(email.text);
      Fluttertoast.showToast(
          msg: "mail sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future sendRest(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: form,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (text) {
                  if (text.contains("@")) {
                    return null;
                  } else {
                    return "Enter valid email";
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        stops: [0.1, 0.9],
                        end: FractionalOffset.bottomLeft,
                        colors: [Colors.lightBlue, Colors.blue],
                        tileMode: TileMode.repeated)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      validate(context);
                    },
                    splashColor: Colors.blue,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
