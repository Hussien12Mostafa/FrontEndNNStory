// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/apiBack.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController textEditingController = TextEditingController();
//   String? imageUrl;

//   _getImageFromAPI() async {
//     String enteredText = textEditingController.text;

//     List<int>? s =
//         await getImage(enteredText) as List<int>?; //Map<String, dynamic>
//     if (s != null) {
//       setState(() {
//         imageUrl = 'data:image/jpeg;base64,' + base64Encode(s);
//         print("read");
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {

// ignore_for_file: prefer_const_constructors

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Generate Story Images'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Enter some text:',
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: textEditingController,
//               maxLines: null, // This allows multiple lines for paragraphs
//               keyboardType: TextInputType.multiline,
//               decoration: InputDecoration(
//                 labelText: 'Type your paragraph here',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _getImageFromAPI, // Call your function here
//               child: Text('Generate Image'),
//             ),
//             SizedBox(height: 20),
//             imageUrl != null
//                 ? Image.memory(
//                     base64Decode(imageUrl!.split(',')[1]),
//                     width: 200,
//                     height: 200,
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apiBack.dart';
import 'package:flutter_application_1/listView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();

  List<String> imagesUrl = [];
  String? highlightedText;
  List<String> splitStringIntoParts(String input) {
    List<String> words = input.split(' ');

    List<String> parts = [];
    String currentPart = '';

    for (int i = 0; i < words.length; i++) {
      if ((i > 0) && (i % 5 == 0)) {
        parts.add(currentPart.trim());

        currentPart = '';
      }
      currentPart += words[i] + ' ';
    }

    if (currentPart.isNotEmpty && currentPart != '') {
      parts.add(currentPart.trim());
    }
    print(parts.length);
    return parts;
  }

  _getImageFromAPI() async {
    final baseOffset = textEditingController.selection.baseOffset;
    final extentOffset = textEditingController.selection.extentOffset;
    print(baseOffset);
    print(extentOffset);
    String selectedText = textEditingController.text.substring(
      extentOffset,
      baseOffset,
    );

    List<String> parts = splitStringIntoParts(selectedText);
    print(parts);
    for (int i = 0; i < parts.length; i++) {
      if (!parts[i].isEmpty) {
        List<int>? s = await getImage(parts[i]) as List<int>?;
        if (s != null) {
          imagesUrl.add('data:image/jpeg;base64,' + base64Encode(s));
        }
      }
    }
    print(imagesUrl.length);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(231, 240, 239, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(135, 178, 173, 1),
        title: Text(
          'Generate Story Images',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text('Enter Your Story:'),
            SizedBox(height: 10),
            TextFormField(
              //style: TextStyle(color: const Color.fromARGB(159, 193, 189, 127)),
              controller: textEditingController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(159, 193, 189, 1), width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusColor: const Color.fromRGBO(183, 209, 206, 1),
                hoverColor: const Color.fromRGBO(183, 209, 206, 1),
                fillColor: const Color.fromRGBO(183, 209, 206, 1),
                labelStyle: TextStyle(
                  color: Color.fromRGBO(159, 193, 189, 1),
                ),
                labelText: 'Type your paragraph here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(
                        159, 193, 189, 1)), // Set the background color here
              ),
              onPressed: _getImageFromAPI,
              child: Text('Generate Image For Highlight Part',
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
            SizedBox(height: 20),
            ListViewImages(imagesUrl: imagesUrl),
          ],
        ),
      ),
    );
  }
}
