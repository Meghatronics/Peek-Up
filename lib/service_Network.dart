import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peekUp/httpException.dart';

const String endpointFetchOne = "https://peekup.herokuapp.com/v1/one";
const String endpointFetchFive = "https://peekup.herokuapp.com/v1/five";

class NetworkHandler {
  static Future<String> getAPeekUpLine() async {
    try{http.Response apiResponse = await http.get(endpointFetchOne);
    if (apiResponse.statusCode == 200) {
      return jsonDecode(apiResponse.body)["pickup"];
    } else {
      throw HttpException('server error');
    }}catch (e){
      throw HttpException('check network provider');
    }
  }

  static Future<List<String>> getFivePeekUpLines() async {
  List<String> pickUpLines = [];
  try{  http.Response apiResponse = await http.get(endpointFetchFive);
    if (apiResponse.statusCode == 200) {
      List rawLines = jsonDecode(apiResponse.body);
      rawLines.forEach((rawLine) {
        pickUpLines.add(rawLine["pickup"]);
      });
      return pickUpLines;
    } else {
      throw HttpException('server error');
    }
    }catch(e){
      HttpException('check network provider');
    }
    return pickUpLines;
  }
}
