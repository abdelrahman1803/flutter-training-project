import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:training_project/models/details_model.dart';

class DetailsRequest {
  static Future<void> getDetailsModel(
    int id, {
    required Function(List<DetailsModel>) onSuccess,
    required Function(int) onError,
  }) async {
    const String apiKey = "2dfe23358236069710a379edd4c65a6b";
    final response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/person/$id?api_key=$apiKey"));

    if (response.statusCode == 200) {
      log('Response: ${response.body}');
      var jsonResponse = json.decode(response.body);
      log('Parsed Response: $jsonResponse');
      List<DetailsModel> details = [DetailsModel.fromJson(jsonResponse)];
      onSuccess(details);
    } else {
      log('Error: ${response.statusCode}');
      onError(response.statusCode);
    }
  }

  static Future<void> getPersonImages(
    int id, {
    required Function(List<String>) onSuccess,
    required Function(int) onError,
  }) async {
    const String apiKey = "2dfe23358236069710a379edd4c65a6b";
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/person/$id/images?api_key=$apiKey"));

    if (response.statusCode == 200) {
      log('Images Response: ${response.body}');
      var jsonResponse = json.decode(response.body);
      log('Parsed Images Response: $jsonResponse');
      List<String> images = (jsonResponse['profiles'] as List)
          .map((image) => image['file_path'] as String)
          .toList();
      onSuccess(images);
    } else {
      log('Images Error: ${response.statusCode}');
      onError(response.statusCode);
    }
  }
}
