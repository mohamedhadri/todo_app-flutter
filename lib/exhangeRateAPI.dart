import 'package:flutter/cupertino.dart';
//import 'package:http/http.dart' as http;
//import 'package:http/http.dart';

class ExchangeRateAPI {
  Future<String> getExchangeRate() async {
    String result = "Done";

    await Future.delayed(Duration(seconds: 5));

    return result;
  }
}
