import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_/constants/const_color.dart';
import 'package:flutter_crypto_/second_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'data/crypto.dart';

class load_page extends StatefulWidget {
  const load_page({super.key});


  @override
  State<load_page> createState() => _load_pageState();
}

class _load_pageState extends State<load_page> {
  @override
  void initState() {
    super.initState();
    getData();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Center(
          child: SpinKitSpinningLines(
            color: yellow,
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    print('sahaaaaaaa****1****');
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    // print('sahaaaaaaa******************${cryptoList.runtimeType}');

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
