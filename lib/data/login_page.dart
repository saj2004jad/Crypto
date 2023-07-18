import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_/data/crypto.dart';
import 'package:flutter_crypto_/second_page.dart';
import '../constants/const_color.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow,
        centerTitle: true,
        title: Text(
          'کیریپتو بازار',
          style: TextStyle(
            fontFamily: 'Far_DastNevis',
            fontSize: 30,
            color: black,
          ),
        ),
      ),
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Center(
                child: Image(
                  image: AssetImage('images/cryptoo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 180,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: dark,
                foregroundColor: yellow,
                minimumSize: Size(300, 45),
                shadowColor: yellow,
                elevation: 5,
              ),
              onPressed: (() {
                getData();
              }),
              child: Text(
                'ورود به برنامه',
                style: TextStyle(
                  fontFamily: 'Far_DastNevis',
                  fontSize: 20,
                  color: yellow,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: yellow,
                side: BorderSide(color: dark),
                backgroundColor: dark,
                minimumSize: Size(300, 45),
                shadowColor: yellow,
                elevation: 5,
              ),
              onPressed: () {},
              child: Text(
                'ثبت نام',
                style: TextStyle(
                  fontFamily: 'Far_DastNevis',
                  fontSize: 20,
                  color: yellow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => coin_page(
          cryptoList: cryptoList,
        ),
      ),
    );
  }
}
