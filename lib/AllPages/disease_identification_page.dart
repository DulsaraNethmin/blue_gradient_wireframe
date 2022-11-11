import 'dart:io';
import 'package:blue_gradient_wireframe/AllPages/fish_feeding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DiseaseIdentificationPage extends StatefulWidget {
  const DiseaseIdentificationPage({Key? key}) : super(key: key);

  @override
  _DiseaseIdentificationPageState createState() =>
      _DiseaseIdentificationPageState();
}

class _DiseaseIdentificationPageState extends State<DiseaseIdentificationPage> {
  XFile? image;
  String? url;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<String> uploadImage(String name, String path) async {
    File file = File(path);
    try {
      await storage.ref('fish/$name').putFile(file);
      return await getImageUrl(name);
    } catch (e) {
      print(e);
      return "an error";
    }
  }

  Future<dynamic> setDatabase() async {
    Map<String, dynamic> data = {
      "user_id": current_user!.uid,
      "image_url": url
    };
    return await FirebaseFirestore.instance
        .collection('images')
        .doc()
        .set(data);
  }

  Future<String> getImageUrl(String name) async {
    String url = await storage.ref('fish/$name').getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/bg1.jpg"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            //if image not null show the image
            //if image null show button
            if (url != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        url!,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Disease Identification',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Fin Rot',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 227, 197, 197)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Information',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Fin rot is a symptom of disease or the actual disease in fish. This is a disease which is most often observed in aquaria and aquaculture, but can also occur in natural populations.',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 227, 197, 197)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Mediation and Treatment',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Use of phenoxethol, acriflavine and antibiotics such as kanamycin and chloramphenicol (Chloromycetin)',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 227, 197, 197)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            else
              ButtonTheme(
                minWidth: 200.0,
                height: 200.0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              title:
                                  const Text('Please choose media to select'),
                              content: Container(
                                height: MediaQuery.of(context).size.height / 6,
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      //if user click this button, user can upload image from gallery
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await getImage(ImageSource.gallery);
                                        if (image != null) {
                                          String name = image!.name;
                                          String path = image!.path;
                                          String download_url =
                                              await uploadImage(name, path);

                                          setState(() {
                                            url = download_url;
                                          });
                                          setDatabase();
                                          print(url);
                                        }
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(Icons.image),
                                          Text('From Gallery'),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      //if user click this button. user can upload image from camera
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        getImage(ImageSource.camera);
                                        if (image != null) {
                                          String name = image!.name;
                                          String path = image!.path;
                                          String download_url =
                                              await uploadImage(name, path);
                                          setState(() {
                                            url = download_url;
                                          });
                                          await setDatabase();
                                          print(url);
                                        }
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(Icons.camera),
                                          Text('From Camera'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Text('Upload Photo'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
