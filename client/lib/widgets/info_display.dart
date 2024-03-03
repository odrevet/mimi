import 'package:flutter/material.dart';

import '../models/info.dart';

class InfoDisplay extends StatelessWidget {
  final Info info;

  const InfoDisplay({required this.info, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildInfoItem('Title', info.title),
          _buildInfoItem('Author', info.author),
          _buildInfoItem('File', info.file),
          _buildInfoItem('State', info.state),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '$title:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10), // Add some space between title and value
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis, // Handle long texts
          ),
        ),
      ],
    );
  }

}
