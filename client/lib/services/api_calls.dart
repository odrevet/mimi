import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/info.dart';

Future<String> _getServerAddress() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return "http://${prefs.getString('address')}:${prefs.getInt('port')}";
}

Future<Info> fetchInfo() async {
  final serverAddress = await _getServerAddress();
  final response = await http.get(Uri.parse("$serverAddress/info.sh"));

  if (response.statusCode == 200) {
    return Info.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load info');
  }
}

Future<bool> control(String action) async {
  final serverAddress = await _getServerAddress();
  final response =
      await http.get(Uri.parse("$serverAddress/control.sh?action=$action"));

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to send control action');
  }
}

Future<List<String>> play(String filter, bool shuffle) async {
  final serverAddress = await _getServerAddress();
  String shuffleParam = shuffle ? '&shuffle=true' : '';
  String uri = "$serverAddress/play.sh?filter=${Uri.encodeComponent(filter)}${shuffleParam}";
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    List<dynamic> jsonArray = jsonDecode(response.body);
    return jsonArray.map((item) => item.toString()).toList();
  } else {
    throw Exception('Failed to play');
  }
}
