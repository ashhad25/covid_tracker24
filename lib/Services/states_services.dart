import 'dart:convert';

import 'package:covid_tracker/Models/world_states_model.dart';
import 'package:covid_tracker/Services/Utitlities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrls.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Erorr');
    }
  }

  Future<List<dynamic>> fetchCountriesRecords() async {
    var data;
    final response = await http.get(Uri.parse(AppUrls.countriesApi));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Erorr');
    }
  }
}
