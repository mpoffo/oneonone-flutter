import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'br.com.sprintfield.oneonone.person/person.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One:One',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'One:One'),
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
