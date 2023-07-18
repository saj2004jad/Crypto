import 'package:flutter/material.dart';
import 'package:flutter_crypto_/data/crypto.dart';
import 'package:flutter_crypto_/data/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_crypto_/load_page.dart';

void main() {
  runApp(FirstPage());
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
  
}

class _FirstPageState extends State<FirstPage> {
   List<Crypto>? cryptolist;

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: ThemeData(fontFamily: 'AR'),
    
      debugShowCheckedModeBanner: false,
      home:LoginPage(),
    );
  }
  }