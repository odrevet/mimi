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

Future<bool> play(String filter) async {
  final serverAddress = await _getServerAddress();
  final response =
  await http.get(Uri.parse("$serverAddress/play.sh?filter=${Uri.encodeComponent(filter)}"));

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to play');
  }
}
