import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //var image2 =  ;
  var image;
  bool pickedImage = false;
  var tmp;
  var txt =
      'Our world is like a terminal cancer. Saying you\'ll change things through individual will is rambling of a peace-loving fool.';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body:
            // color: Colors.lightBlueAccent,
            // width: 100,
            // height: 100,
            // child: DecoratedBox(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image:
            //       fit: BoxFit.cover,
            Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: tmp != null
                    ? FileImage(
                        tmp!,
                      )
                    : AssetImage(
                        'images/1.jpg',
                      ) as ImageProvider,
                fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // tmp != null
              //     ? Image.file(
              //         tmp!,
              //         fit: BoxFit.fill,
              //       )
              //     : Image.asset('images/1.jpg', fit: BoxFit.fill),
              Expanded(
                flex: 9,
                child: SizedBox(
                    //height: 100,
                    ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  txt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  color: Colors.black, //Color(0x33808080),
                  //width: 100,
                  height: 77,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          // Pick an image
                          image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            //pickedImage = true;

                            tmp = File(image.path);
                            //image2 = image;
                          });
                        },
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          var decodedData;
                          var done = false;
                          while (!done) {
                            http.Response response = await http.get(Uri.parse(
                                'https://animechan.vercel.app/api/random'));
                            if (response.statusCode == 200) {
                              String responseData = response.body;
                              decodedData = jsonDecode(responseData);
                              if (decodedData['quote'].toString().length <
                                  150) {
                                done = true;
                              }
                              //return decodedData;
                            } else {
                              print(response.statusCode);
                              done = true;
                            }
                          }

                          setState(() {
                            txt = decodedData['quote'];
                          });
                        },
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.update_rounded,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // ),
        //),
        //),
      ),
    );
  }
}

// class MainScreen extends StatelessWidget {
//
// }
