import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/web.dart' as web;

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _portController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  int _getDefaultPort() {
    if (kIsWeb) {
      return int.parse(web.window.location.port);
    } else {
      return 80;
    }
  }

  String _getDefaultAddress() {
    if (kIsWeb) {
      String url = web.window.location.href;
      return Uri.parse(url).host;
    } else {
      return 'localhost';
    }
  }

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? port = prefs.getInt('port');
    String? address = prefs.getString('address');

    setState(() {
      _addressController.text = address ?? _getDefaultAddress();
      _portController.text =
          port == null ? _getDefaultPort().toString() : port.toString();
    });
  }

  _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', _addressController.text.trim());
    prefs.setInt('port', int.parse(_portController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Address:'),
          TextField(
            controller: _addressController,
            onChanged: (_) => _saveSettings(),
          ),
          SizedBox(height: 10),
          Text('Port:'),
          TextField(
            controller: _portController,
            keyboardType: TextInputType.number,
            onChanged: (_) => _saveSettings(),
          ),
        ],
      ),
    );
  }
}
