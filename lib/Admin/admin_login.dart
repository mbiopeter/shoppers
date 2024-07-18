import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppers/Admin/admin_home.dart';
import 'package:shoppers/widget/support_widget.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController userPasswordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        margin: EdgeInsets.only(
          top: 40,
        ),
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
                          child: Text(
                            'Admin Login',
                            style: AppWidget.semiboldTextfieldStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Username',
                          style: AppWidget.semiboldTextfieldStyle(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFf4f5f9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: usernameController,
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
                            obscureText: true,
                            controller: userPasswordController,
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
                            loginAdmin();
                          },
                          child: Container(
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['username'] != usernameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                'Invalid username!',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else if ((result.data()['password'] !=
            userPasswordController.text.trim())) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                'Invalid user password!',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminHome()));
        }
      });
    });
  }
}
