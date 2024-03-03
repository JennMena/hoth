import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:hothapp/helper/helper_function.dart';
import 'package:hothapp/pages/home_page.dart';
import 'package:hothapp/pages/login_page.dart';
import 'package:hothapp/shared/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb)
  {
    await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: Constants.apiKey, 
    appId: Constants.appId, messagingSenderId: Constants.messagingSenderId, projectId: Constants.projectId)
    );
  }
  else
  {
      await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp ({Key? key}) : super(key:key);

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> 
{
  bool _isSignedIn = false;

  @override
  void initState(){
    super.initState();
    getUserLogggedInStatus();
  }

  getUserLogggedInStatus() async {
    await HelperFunctions.getUserLogggedInStatus().then((value) {
      if (value != null) {
        _isSignedIn = value;
      }
    });
  }

  @override
  Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: _isSignedIn ? const HomePage() : const LoginPage(),
  );
  }
}