import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:training_project/models/home_model.dart';

class HomeRequest with ChangeNotifier {
  Uri url = Uri.parse(
      "https://api.themoviedb.org/3/person/popular?api_key=2dfe23358236069710a379edd4c65a6b");
  List<Person> _persons = [];

  List<Person> get persons => _persons;

  Future<void> fetchPersons() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log("Data Calling Success");
      List<dynamic> jsonDecode = json.decode(response.body)['results'];
      _persons = jsonDecode.map((person) => Person.fromJson(person)).toList();
      notifyListeners();
    } else if (response.statusCode == 400) {
      log('Failed to Load Persons');
    } else if (response.statusCode == 500) {
      log("Server Error");
    }
  }
}
