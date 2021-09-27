import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/sign_in/sing_in.dart';
import 'package:firebase_login/user_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool USE_FIRESTORE_EMULATOR = false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  navigation()async{
    final prefs = await SharedPreferences.getInstance();
    Future.delayed(Duration(milliseconds: 1000),(){
      if(prefs.getString("NAME") != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
          return UserViewScreen();
        }));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
          return SignInScreen();
        }));
      }

    });
  }

  @override
  void initState() {
    super.initState();
    navigation();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.9,
      height: size.height,
      color: Colors.white,
      child: Center(
        child: Image.asset("assets/chatBack.jpg"),
      ),
    );
  }
}

