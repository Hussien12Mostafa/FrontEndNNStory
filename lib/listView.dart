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
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        // Define your header slivers here.
        return <Widget>[
          SliverAppBar(
            // Your app bar configuration here.
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Nested Scroll View Example'),
              // Add your header content here.
            ),
          ),
        ];
      },
      body: ListView.builder(
        itemCount: imagesUrl.length,
        itemBuilder: (BuildContext context, int index) {
          final imageUrl = imagesUrl[index];
          Image.memory(
            base64Decode(imageUrl.split(',')[1]),
            width: 200,
            height: 200,
          );
        },
      ),
    );
  }
}
