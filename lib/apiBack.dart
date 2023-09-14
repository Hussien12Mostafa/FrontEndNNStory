import 'dart:convert';

import 'package:http/http.dart' as http;

final String apiHuggingFace =
    "https://api-inference.huggingface.co/models/CompVis/stable-diffusion-v1-4";
String token = "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";

Future<List<int>?> getImage(String text) async {

  String ss = "sketch of " + text;
  
  Map<String, dynamic> m = {"inputs": ss};

  final response = await http.post(
    Uri.parse(apiHuggingFace),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: json.encode(m),
  );
  print("got it");
  if (response.statusCode == 200) {
    print("cong");
    // Assuming the response is binary image data
    List<int> imageBytes = response.bodyBytes;

    return imageBytes;
  } else {
    print("try again");
    return null;
  }
}
