import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _addressController.text = prefs.getString('address') ?? '';
      _portController.text = prefs.getInt('port').toString() ?? '';
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
