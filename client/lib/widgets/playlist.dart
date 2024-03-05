import 'package:flutter/material.dart';

class Playlist extends StatelessWidget {
  final List<String> entries;

  const Playlist({required this.entries, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(entries[index]),
          onTap: () {},
        );
      },
    );
  }
}
