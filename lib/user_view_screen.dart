import 'package:firebase_login/sign_in/sing_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewScreen extends StatefulWidget {
  @override
  _UserViewScreenState createState() => _UserViewScreenState();
}

class _UserViewScreenState extends State<UserViewScreen> {

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String name;
  String email;
  bool isLoading = false;
  getData()async{
    prefs.then((value)async{
      name = value.getString("NAME");
      email = value.getString("EMAIL");
      isLoading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getData();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: (){
                showGeneralDialog(
                  barrierColor: Colors.black.withOpacity(0.8),
                  context: context,
                  transitionBuilder:(context, a1, a2, widget){
                    return SimpleDialog(
                      title: Text(
                        "Log out?",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: (){
                                prefs.then((value) {
                                  value.clear();

                                });
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return SignInScreen();
                                }));
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            MaterialButton(
                              color: Colors.grey[200],
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text(
                                "No",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    );
                  },
                  barrierDismissible: false,
                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, animation1, animation2) {
                    return Container();
                  },
                );
              },
                child:  Text(
                  "Log out",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                ),
            )
          ],
        ),
        body:
        isLoading?
        Center(child: CircularProgressIndicator())
            :
        Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Image.asset(
                "assets/chatBack.jpg",
                width: size.width*0.4,
                height: size.height*0.4,
              ),
              SizedBox(
                width: size.width*0.8,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Name : ",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),
                            ),Text(
                              "$name",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Email : ",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),
                            ), Text(
                              "$email",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
