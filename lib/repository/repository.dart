import 'dart:convert';

import "package:http/http.dart" as http;


class Repository {
Future fetchCurrenices() async {
final url = Uri.parse("https://api.cryptorank.io/v1/currencies?api_key=8a46d059306d5b03f719788ae2c583f5bd04e3eaa4b0801a56de4b85583b&limit=20");
final responce = await http.get(url);
if (responce.statusCode == 200) {
  return json.decode(responce.body)["data"];

}
else {
  throw Exception("Error while fetching currencies");
}
}
}