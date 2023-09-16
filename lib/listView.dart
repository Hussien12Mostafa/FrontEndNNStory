import 'dart:convert';

import 'package:flutter/material.dart';

class ListViewImages extends StatelessWidget {
  List<String> imagesUrl;

  ListViewImages({
    super.key,
    required this.imagesUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: imagesUrl.map((imageUrl) {
        return Image.memory(
          base64Decode(imageUrl.split(',')[1]),
          width: 200,
          height: 200,
        );
      }).toList(),
    );
  }
}
