import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _typeAheadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            TypeAheadField<Person>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: this._typeAheadController,
                autofocus: false,
              ),
              suggestionsCallback: (pattern) async {
                var lista = PersonService.getPersons(pattern);
                return lista;
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text(suggestion.toString()),
                  subtitle: Text(suggestion.toString()),
                );
              },
              onSuggestionSelected: (suggestion) {
                this._typeAheadController.text = suggestion.name;
              },
            ),
          ],
        ));
  }
}

class PersonService {
  static Future<Iterable<Person>> getPersons(String query) async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/mpoffo/FLutterTests/4898decbd4d1d8aa97f882c4102b7dbe4247e383/person.json');

    // Await the http get response, then decode the json-formatted response.
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var result = List.from(convert.jsonDecode(response.body))
            .map((e) => Person.fromJson(e))
            .toList();
        print(result);
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (err) {
      print(err);
    }

    return List.empty();
  }
}

class Person {
  String name;
  Person(this.name);

  factory Person.fromJson(dynamic json) {
    return Person(json['name'] as String);
  }

  @override
  String toString() {
    return this.name;
  }
}
