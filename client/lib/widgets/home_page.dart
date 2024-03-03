import 'package:client/services/api_calls.dart';
import 'package:client/widgets/info_display.dart';
import 'package:client/widgets/settings.dart';
import 'package:flutter/material.dart';

import '../models/info.dart';
import 'control_bar.dart';

class MimiClient extends StatelessWidget {
  const MimiClient({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MimiClient',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mimi Client'),
      routes: {
        '/settings': (context) => Settings(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _info = Info();
  TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    _refreshInfo();
    super.initState();
  }

  void _refreshInfo() async {
    var info = await fetchInfo();
    setState(() {
      _info = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InfoDisplay(info: _info),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextField(
                          controller: _filterController,
                          decoration: InputDecoration(
                            labelText: 'Music filter',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String inputText = _filterController.text;
                            play(inputText);
                          },
                          child: Text('Play'),
                        ),
                      ])),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(child: ControlBar()),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshInfo,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
