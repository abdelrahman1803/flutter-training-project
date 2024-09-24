import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:training_project/data((me)/model/info_model.dart';

class CallingInfo {
  InfoDataModel infoDataModel = InfoDataModel();
  personInfo(int id) async {
    var response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/person/$id?api_key=2dfe23358236069710a379edd4c65a6b "));
    if (response.statusCode == 200) {
      log("data send successfully");
      
    } else if (response.statusCode == 400) {
      log("failed to receive data");
    } else if (response.statusCode == 500) {
      log("server error");
    }
  }
}
