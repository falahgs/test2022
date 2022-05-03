import 'dart:convert';

import 'package:flutter_restapi/models/cases.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://studentalraed.herokuapp.com/degrees";

  Future<List<Cases>> getCases() async {
    Response res = await get(apiUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Cases> cases =
          body.map((dynamic item) => Cases.fromJson(item)).toList();
      return cases;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<Cases> getCaseById(String id) async {
    
    final response = await get('$apiUrl/$id');

    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Cases> createCase(Cases cases) async {
    Map data = {
      'id': cases.id,
      'name': cases.name,
      'gender': cases.gender,
      'age': cases.age,
      'address': cases.address,
      'city': cases.city,
      'country': cases.country,
      'status': cases.status,
      'imgUrl': cases.imgUrl
    };

    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<Cases> updateCases(String id, Cases cases) async {
    Map data = {
      'id': cases.id,
      'name': cases.name,
      'gender': cases.gender,
      'age': cases.age,
      'address': cases.address,
      'city': cases.city,
      'country': cases.country,
      'status': cases.status,
      'imgUrl': cases.imgUrl
    };
    print('update $apiUrl/$id');
    final Response response = await put(
      '$apiUrl/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteCase(String id) async {
    print('id :$id');
    var response = await http.delete(Uri.parse('$apiUrl/$id'),
        headers: {'Access-Control-Allow-Origin': '*'});
    print('url :$apiUrl/$id');
    // Response res = await delete('$apiUrl/$id');
    print('respomse ${response.statusCode}');

    if (response.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }

   Future<List<Cases>> getBooks(String query) async {
    final url = Uri.parse(
        'https://studentalraed.herokuapp.com/degrees'
        
        
        );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List books = json.decode(response.body);

      return books.map((json) => Cases.fromJson(json)).where((case1) {
        final titleLower = case1.name.toLowerCase();
        final authorLower = case1.city.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
