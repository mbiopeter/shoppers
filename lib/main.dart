import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shoppers/Admin/add_product.dart';
import 'package:shoppers/Admin/admin_login.dart';
import 'package:shoppers/pages/bottomnav.dart';
import 'package:shoppers/pages/category_products.dart';
import 'package:shoppers/pages/home.dart';
import 'package:shoppers/pages/login.dart';
import 'package:shoppers/pages/onboarding.dart';
import 'package:shoppers/pages/product_detail.dart';
import 'package:shoppers/pages/signup.dart';
import 'package:shoppers/services/constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishablekey;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signup(),
    );
  }
}
