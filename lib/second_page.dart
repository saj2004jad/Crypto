import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_/data/crypto.dart';
import 'constants/const_color.dart';

class coin_page extends StatefulWidget {
  List<Crypto>? cryptoList;

  coin_page({super.key, this.cryptoList});
  @override
  State<coin_page> createState() => _coin_pageState(cryptoList);
}

class _coin_pageState extends State<coin_page> {
  List<Crypto>? cryptoList;
  bool isSearch = false;
  _coin_pageState(this.cryptoList);
  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: yellow,
        title: Text(
          'کیریپتو بازار',
          style: TextStyle(fontSize: 30, color: black,fontFamily: 'Far_DastNevis'),
        ),
      ),
      backgroundColor: black,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                onChanged: (value) {
                  _filterlist(value);
                },
                decoration: InputDecoration(
                  hintText: 'رمز ارز مورد نظر را سرج کنید',
                  hintStyle:
                      TextStyle(fontFamily: 'Far_DastNevis', color: dark),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  filled: true,
                  fillColor: yellow,
                ),
              ),
            ),
          ),
          Visibility(
            visible: isSearch,
            child: Text(
              'در حال پردازش...',
              style: TextStyle(
                color: yellow,
                fontFamily: 'Far_DastNevis',
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: yellow,
              backgroundColor: dark,
              child: ListView.builder(
                itemCount: 
                cryptoList!.length,
                itemBuilder: (context, index) {
                  return 
                   _getlistcrypto(
                    cryptoList![index],
                  );
                },
              ),
              onRefresh: () async {
                List<Crypto> fereshdata = await _getData();
                setState(() {
                  cryptoList = fereshdata;
                });
              },
            ),
          ),
        ],
      )),
    );
  }

  Widget _getlistcrypto(Crypto crypto) {
    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(color: yellow, fontSize: 20),
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(color: Colors.grey),
      ),
      leading: SizedBox(
        width: 30,
        child: Center(
          child: Text(
            crypto.rank.toString(),
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  crypto.priceUsd.toStringAsFixed(2),
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  crypto.changePercent24hr.toStringAsFixed(2),
                  style: TextStyle(
                    color: _chengcolor(
                      crypto.changePercent24hr,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
              child: Center(
                child: _personchange(
                  crypto.changePercent24hr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _personchange(double change) {
    return change <= 0
        ? Icon(
            Icons.trending_down,
            color: Colors.red,
            size: 24,
          )
        : Icon(
            Icons.trending_up,
            color: Colors.green,
            size: 24,
          );
  }

  Color _chengcolor(double change) {
    return change <= 0 ? red : green;
  }

  Future<List<Crypto>> _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    return cryptoList;
  }

  Future<void> _filterlist(String enterkey) async {
    List<Crypto> cryptoresult = [];
    if (enterkey.isEmpty) {
      setState(() {
        isSearch = true;
      });
      var result = await _getData();
      setState(() {
        cryptoList = result;
        isSearch = false;
      });
      return;
    }
    cryptoresult = cryptoList!.where((element) {
      return element.name.toLowerCase().contains(enterkey.toLowerCase());
    }).toList();
    setState(() {
      cryptoList = cryptoresult;
    });
  }
}
