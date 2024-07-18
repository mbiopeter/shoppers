import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shoppers/pages/login.dart';
import 'package:shoppers/pages/onboarding.dart';
import 'package:shoppers/services/database.dart';
import 'package:shoppers/services/shared_pref.dart';
import 'package:shoppers/widget/support_widget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? name, email, password;

  TextEditingController nameController = new TextEditingController();
  TextEditingController mailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  registration() async {
    if (password != null && name != null && email != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
              'Registration Successful',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
        String Id = randomAlphaNumeric(10);
        //ADD DETAILS LOCALY
        await SharedPreferenceHelper().saveUserEmail(mailController.text);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserName(nameController.text);
        await SharedPreferenceHelper().saveUserImage(
            "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2");
        //ADD USER DETAILS TO FIREBASE FIRESTORE DATABASE
        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "Email": mailController.text,
          "id": Id,
          "image":
              "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        };
        await DatabaseMethods().addUserDdetails(userInfoMap, Id);

        Navigator.push(
            context, MaterialPageRoute(builder: (constext) => Onboarding()));
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                'Password provided is too weak',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                'Account already exists',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        margin: EdgeInsets.only(
          top: 40,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'images/logo.png',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text('Register',
                                  style: AppWidget.semiboldTextfieldStyle())),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                                'Please enter your details below to continue',
                                style: AppWidget.lightTextfieldStyle()),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text('Name',
                              style: AppWidget.semiboldTextfieldStyle()),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFf4f5f9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Name';
                                }
                                return null;
                              },
                              controller: nameController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Jane Doe',
                                prefixIcon: Icon(Icons.person_outline),
                                hintStyle: AppWidget.lightTextfieldStyle(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Email',
                              style: AppWidget.semiboldTextfieldStyle()),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFf4f5f9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Email';
                                }
                                return null;
                              },
                              controller: mailController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'user@gmail.com',
                                prefixIcon: Icon(Icons.email_outlined),
                                hintStyle: AppWidget.lightTextfieldStyle(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Password',
                              style: AppWidget.semiboldTextfieldStyle()),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFf4f5f9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Password';
                                }
                                return null;
                              },
                              obscureText: true,
                              controller: passwordController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.password_outlined),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  name = nameController.text;
                                  email = mailController.text;
                                  password = passwordController.text;
                                });
                              }

                              registration();
                            },
                            child: Container(
                              padding: EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have have an account?  ",
                                  style: AppWidget.lightTextfieldStyle()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (conatext) => Login()));
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ],
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
