import 'dart:convert';

import 'package:http/http.dart' as http;

const String endpointFetchOne = "https://peekup.herokuapp.com/v1/one";
const String endpointFetchFive = "https://peekup.herokuapp.com/v1/five";

class NetworkHandler {
  static Future<String> getAPeekUpLine() async {
    http.Response apiResponse = await http.get(endpointFetchOne);
    if (apiResponse.statusCode == 200) {
      return jsonDecode(apiResponse.body)["pickup"];
    } else {
      throw 'FAILED_TO_FETCH';
    }
  }

  static Future<List<String>> getFivePeekUpLines() async {
    http.Response apiResponse = await http.get(endpointFetchFive);
    List<String> pickUpLines = [];
    if (apiResponse.statusCode == 200) {
      List rawLines = jsonDecode(apiResponse.body);
      rawLines.forEach((rawLine) {
        pickUpLines.add(rawLine["pickup"]);
      });
      return pickUpLines;
    } else {
      throw 'FAILED_TO_FETCH';
    }
  }
}
