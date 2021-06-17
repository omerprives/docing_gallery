import 'dart:async';
import 'data_objects.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Item>> loadData() async {
  print("loading data...");
  final response = await http.post(
    Uri.parse('http://127.0.0.1:5000/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // todo: decide on request body
    body: jsonEncode(<String, String>{
      'title': 'mytitle', // todo: decide on request body
    }),
  );

  List<Item> ret = [];
  if (response.statusCode == 200) {
    print("response: 200 OK");
    final data = jsonDecode(response.body);
    print(data);
    for (Map i in data) {
      try {
        ret.add(Item.fromJson(i));
      } catch (exception) {
        print("cannot add item");
      }
    }
    return ret;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('ERROR: Status code is ' + response.statusCode.toString());
  }
}
