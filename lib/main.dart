import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map responsedata = {};
  List listdata = [];
  Future fetchdata() async {
    try {
      http.Response response;
      response = await http.get(Uri.parse('https://reqres.in/api/users/'));
      if (response.statusCode == 200) {
        setState(() {
          responsedata = jsonDecode(response.body);
          listdata = responsedata['data'];
        });
      }
    } catch (e) {
      print("Error occuured $e");
    }
  }

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('get method Api'),
      ),
      body: ListView.builder(
          itemCount: listdata.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.amber,
              child: Column(
                children: [
                  // Text(responsedata['page'].toString()),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.network(listdata[index]['avatar']),
                  ),
                  Text('User Id: ${listdata[index]['id'].toString()}'),
                  Text('Email Address:${listdata[index]['email']}'),
                  Text(
                      'Full Name: ${listdata[index]['first_name']}  ${listdata[index]['last_name']}'),
                  const Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            );
          }),
    ));
  }
}
