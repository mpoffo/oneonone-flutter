import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PersonService {
  static Future<Iterable<Person>> getPersons(String query) async {
    var url = Uri.https('oneonone-back.herokuapp.com', '/api/pessoas/');
    //var url = Uri.parse('person.json');

    // Await the http get response, then decode the json-formatted response.
    try {
      var response = await http.get(url,
          headers: {"Content-Type": "application/json; charset=utf-8"});
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
    return Person(json['nome'] as String);
  }

  @override
  String toString() {
    return this.name;
  }
}
