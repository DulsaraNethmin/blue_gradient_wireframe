import 'dart:io';
import 'package:blue_gradient_wireframe/AllPages/fish_feeding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:path_provider/path_provider.dart';

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
    print('cam2');
    setState(() {
      image = img;
    });
  }

  Future selectImageFromcamera(BuildContext context) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final temp_img = XFile(image.path);
      setState(() {
        this.image = temp_img;
      });
    } catch (e) {
      print(e);
    }
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

  Future<dynamic> setDatabase(String name) async {
    Map<String, dynamic> data = {
      "user_id": current_user!.uid,
      "image_url": url,
      "name": name,
      "result": "2"
    };
    return await FirebaseFirestore.instance
        .collection('images')
        .doc("image1")
        .set(data);
  }

  Future<String> getImageUrl(String name) async {
    String url = await storage.ref('fish/$name').getDownloadURL();
    return url;
  }

  Future<dynamic> getResult() async {
    var res = await FirebaseFirestore.instance
        .collection("images")
        .doc("image1")
        .get();
    print(res.data()!["result"]);
    return res;
  }

  Future<dynamic> deleteImage() async {
    var data = await FirebaseFirestore.instance
        .collection("images")
        .doc("image1")
        .get();
    String name = data.data()!["name"];
    print(name);
    storage.ref("fish/${name}").delete();
  }

  String getDiseases(String n) {
    String diseases = "";
    switch (n) {
      case "0":
        diseases = "Fin Rot, Rot";
        break;
      case "1":
        diseases = "Fungus and Bacteria";
        break;
      case "2":
        diseases = "Your fish seems to be healthy";
        break;
      case "3":
        diseases = "Pop Eye";
    }
    return diseases;
  }

  String getMoreInfo(String n) {
    String diseases = "";
    switch (n) {
      case "0":
        diseases =
            "Fin rot is one of the most common diseases in aquarium fish, but it is also one of the most preventable. Technically, fin rot is caused by several different species of bacteria, but the root cause is usually environmental in nature and is often related to stress, which can weaken a fish immune system.";
        break;
      case "1":
        diseases =
            "Fungi. True fungal infections in fish are less common than parasites or bacteria. They typically appear as white cottony or \"furry\" growths on fish but can also be internal. They can be induced by substandard water quality, infected food, or open wounds.";
        break;
      case "2":
        diseases = "If fish behavior gets odd please isolate the fish.";
        break;
      case "3":
        diseases =
            "Popeye disease is a condition that causes the eye of a fish to bulge, swell up, or protrude from the socket. The bulging appearance of the eye is a result of fluid buildup. The fluid can accumulate behind the eye or within the eye itself.";
    }
    return diseases;
  }

  String getTreatment(String n) {
    String diseases = "";
    switch (n) {
      case "0":
        diseases =
            "Use of phenoxethol, acriflavine, and antibiotics such as kanamycin and chloramphenicol (Chloromycetin).";
        break;
      case "1":
        diseases =
            "Levamisole, metronidazole or praziquantel. Metronidazole and praziquantel are especially effective when used as food soaks. Antibiotics such as nitrofurazone or erythromycin may also help prevent secondary bacterial infections.";
        break;
      case "2":
        diseases = ":)";
        break;
      case "3":
        diseases =
            "Blended kanamycin based medication that safely and effectively treats several fungal, and bacterial fish diseases.";
    }
    return diseases;
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
                    FutureBuilder(
                        future: getResult(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasData) {
                            return Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    getDiseases(snapshot.data["result"]),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 227, 197, 197)),
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
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
                                      getMoreInfo(snapshot.data["result"]),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(
                                              255, 227, 197, 197)),
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
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
                                      getTreatment(snapshot.data["result"]),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(
                                              255, 227, 197, 197)),
                                    ),
                                  ),
                                ],
                              )
                            ]);
                          }
                          return CircularProgressIndicator();
                        }),
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
                                          try {
                                            await deleteImage();
                                          } catch (e) {
                                            print(e);
                                          }
                                          await setDatabase(name);
                                          // await deleteImage();
                                          print(url);
                                          await getResult();
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
                                        selectImageFromcamera(context);
                                        //getImage(ImageSource.camera);
                                        //final newImage = File('${(await getTemporaryDirectory()).path}/your_name.jpg');
                                        if (image != null) {
                                          print('cam');
                                          String name = image!.name;
                                          String path = image!.path;
                                          String download_url =
                                              await uploadImage(name, path);

                                          setState(() {
                                            url = download_url;
                                          });
                                          try {
                                            await deleteImage();
                                          } catch (e) {
                                            print(e);
                                          }
                                          await setDatabase(name);
                                          // await deleteImage();
                                          print(url);
                                          await getResult();
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
