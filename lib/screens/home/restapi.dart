import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestApi extends StatefulWidget {
  const RestApi({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  RestApiState createState() => RestApiState(url);
}

class RestApiState extends State<RestApi> {
  final String url;

  RestApiState(this.url);

  Future<String> getData() async {
    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
    );
    List data = json.decode(response.body);
    print(data);
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Click me"),
          onPressed: getData,
        ),
      ),
    );
  }
}
