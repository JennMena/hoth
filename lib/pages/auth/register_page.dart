
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hothapp/helper/helper_function.dart';
import 'package:hothapp/pages/auth/login_page.dart';
import 'package:hothapp/pages/home_page.dart';
import 'package:hothapp/service/auth_service.dart';
import 'package:hothapp/shared/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //Variables for the books and restaurants:
  bool _checkBoxValueR1 = false;
  bool _checkBoxValueR2 = false;
  bool _checkBoxValueR3 = false;
  bool _checkBoxValueR4 = false;
  bool _checkBoxValueB1 = false;
  bool _checkBoxValueB2 = false;
  bool _checkBoxValueB3 = false;
  bool _checkBoxValueB4 = false;


  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor))
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "BruinBites & Books",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            "Create your account now to meet new people and try different food",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 30),
                        const Text(
                            "The American Heart Association is this group that cares a lot about our hearts and health. They did a survey in 2022, and guess what? 91% of parents said that when they eat meals together with their family, they feel less stressed. And you know what else? 84% of grown-ups want to have more meals with other people. It’s not just about food; it’s about feeling less stressed, being closer to loved ones, and taking a moment to enjoy life. 🍽️❤️",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                        //Image.asset("assets/food1.jpg"),
                        const SizedBox(height: 50),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "Full Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              )),
                          onChanged: (val) {
                            setState(() {
                              fullName = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name cannot be empty";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              )),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },

                          // check tha validation
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              )),
                          validator: (val) {
                            if (val!.length < 6) {
                              return "Password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(height: 15),
const Text(
    "Choose your favorite restaurants:",
    style: TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold)),

const SizedBox(height: 20), 

CheckboxListTile(
  title: Text("Bruin Plate"),
  value: _checkBoxValueR1,
  onChanged: (bool? newValue) {
    setState(() {
      _checkBoxValueR1 = newValue!;
    });
  },
  controlAffinity: ListTileControlAffinity.leading,
),
CheckboxListTile(
  title: Text("De Neve"),
  value: _checkBoxValueR2,
  onChanged: (bool? newValue) {
    setState(() {
      _checkBoxValueR2 = newValue!;
    });
  },
  controlAffinity: ListTileControlAffinity.leading,
),
CheckboxListTile(
  title: Text("Northern Lights"),
  value: _checkBoxValueR3,
  onChanged: (bool? newValue) {
    setState(() {
      _checkBoxValueR3 = newValue!;
    });
  },
  controlAffinity: ListTileControlAffinity.leading,
),
CheckboxListTile(
  title: Text("Kerckhoff Coffee House"),
  value: _checkBoxValueR4,
  onChanged: (bool? newValue) {
    setState(() {
      _checkBoxValueR4 = newValue!;
    });
  },
  controlAffinity: ListTileControlAffinity.leading,
),

const SizedBox(height: 40), 
const Text(
    "Choose what you like to read:",
    style: TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold)),

const SizedBox(height: 20), 
CheckboxListTile(
  title: Text("Science Fiction"),
  value: _checkBoxValueB1,
  onChanged: (bool? newValue) {
    setState(() {
      _checkBoxValueB1 = newValue!;
    });
  },
  controlAffinity: ListTileControlAffinity.leading,
),
CheckboxListTile(
  title: Text("Fantasy"),
  value: _checkBoxValueB2,
  onChanged: (bool? newValue) {
    setState(() {
      _checkBoxValueB2 = newValue!;
    });
  },
  controlAffinity: ListTileControlAffinity.leading,
),
CheckboxListTile(
  title: Text("Personal Develpment"),
  value: _checkBoxValueB3,
  onChanged: (bool? newValue) {
    setState(() {
      _checkBoxValueB3 = newValue!;
    });
  },
  controlAffinity: ListTileControlAffinity.leading,
),
CheckboxListTile(
  title: Text("Thriller"),
  value: _checkBoxValueB4,
  onChanged: (bool? newValue) {
    setState(() {
      _checkBoxValueB4 = newValue!;
    });
  },
  controlAffinity: ListTileControlAffinity.leading,
),

const SizedBox(height: 40), 

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              register();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Login now",
                                style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const LoginPage());
                                  }),
                          ],
                        )),
                      ],
                    )),
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
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
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
