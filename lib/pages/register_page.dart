import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hothapp/helper/helper_function.dart';
import 'package:hothapp/pages/login_page.dart';
import 'package:hothapp/services/auth_service.dart';
import 'package:hothapp/shared/widgets/widgets.dart';
import 'package:hothapp/pages/home_page.dart';
//import 'package:hothapp/pages/helper_function.dart';


class RegisterPage extends StatefulWidget{
  const RegisterPage({Key?key}):super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage>{
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();

  String email = "";
  String password = ""; 
  String name = "";

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor),)
      : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text("BruinBites & Books", 
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10,), 
                const Text("Create you account to meet other awesome students", 
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                Image.asset("assets/register.png"),
                //NAME FIELD
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: "Your name",
                    prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColor),
                  ),
                  onChanged: (val){
                    setState(() {
                      name = val;
                    });
                  },
                  //Check if text entered was an email - validation
                  validator: (val) {
                    if(val!.isNotEmpty)
                    {
                      return null;  
                    }
                    else
                    {
                      return "Don't be shy, what's your name?";
                    }
                  },

                ),
                const SizedBox(height: 15,),
                //EMAIL FIELD
                TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "Email address",
                      prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor),
                    ),
                    onChanged: (val){
                      setState(() {
                        email = val;
                        //print(email);
                      });
                    },
                    //Check if text entered was an email - validation
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val!)
                          ? null
                          : "Please enter a valid email";
                    },

                  ),
                const SizedBox(height: 15,),
                //PASWORD FIELD
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.key, color: Theme.of(context).primaryColor)
                  ),
                  //Validation of password
                    validator: (val) {
                      if (val!.length < 8) {
                        return "Password must be at least 8 characters";
                      } else {
                        return null;
                      }
                    },
                  onChanged: (val){
                    setState(() {
                      password = val;
                      //print(passowrd);
                    });

                  },
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
                    child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: (){
                      register();
                    },
                  )
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    children: <TextSpan>[
                      TextSpan(
                        text: "Sign In",
                        style: const TextStyle(color: Colors.black, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = (){
                            nextScreen(context, const LoginPage());
                        }
                      ),

                    ],
                    style: const TextStyle(color: Colors.black, fontSize: 14)
                  )
                ),
                ],
            ),
            ),
        ),
      ),
    );
  }

 register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(name, email, password)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(name);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}