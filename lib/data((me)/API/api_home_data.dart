import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:training_project/data((me)/model/info_model.dart';

class ApiCalling {
  Uri url = Uri.parse(
      "https://api.themoviedb.org/3/person/popular?api_key=2dfe23358236069710a379edd4c65a6b");
  InfoDataModel infoDataModel = InfoDataModel();
  void callApi() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      log("api calling success");
    } else if (response.statusCode == 400) {
      log("api calling failed");
    } else if (response.statusCode == 500) {
      log("server error");
    }
  }
}
