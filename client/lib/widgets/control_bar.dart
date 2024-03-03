import 'package:flutter/material.dart';

import '../services/api_calls.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({super.key});

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      IconButton(
          onPressed: () => control('previous'),
          icon: Icon(Icons.skip_previous)),
      IconButton(onPressed: () => control('next'), icon: Icon(Icons.skip_next)),
      IconButton(
          onPressed: () => control('toggle_pause'), icon: Icon(Icons.pause)),
      IconButton(onPressed: () => control('stop'), icon: Icon(Icons.stop)),
      IconButton(
          onPressed: () => control('backward'), icon: Icon(Icons.fast_rewind)),
      IconButton(
          onPressed: () => control('forward'), icon: Icon(Icons.fast_forward)),
      IconButton(
          onPressed: () => control('poweroff'),
          icon: Icon(Icons.power_settings_new)),
    ]);
  }
}
