import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_did/dog_data.dart';
import 'package:dog_did/global_widgets/dog_did_scaffold.dart';
import 'package:dog_did/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dog_profile_entry.dart';

class DogProfile extends StatefulWidget {
  const DogProfile({super.key, required this.dog});
  final DogData dog;

  @override
  State<DogProfile> createState() => _DogProfileState();
}

class _DogProfileState extends State<DogProfile> {
  @override
  void dispose() {
    breedController.dispose();
    ageController.dispose();
    descController.dispose();
    nameController.dispose();
    super.dispose();
  }

  final breedController = TextEditingController();
  final ageController = TextEditingController();
  final descController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void save() {
    final dog = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('dogs').doc(widget.dog.id);

    if (nameController.text != widget.dog.name) dog.update({'name': nameController.text});
    if (breedController.text != widget.dog.breed) dog.update({'breed': breedController.text});
    if (ageController.text != widget.dog.age.toString()) dog.update({'age': int.parse(ageController.text)});
    if (descController.text != widget.dog.description) dog.update({'description': descController.text});
    if (gender != widget.dog.isFemale) dog.update({'isFemale': gender});
    Utils.showSnackBar('Saved changes!', Theme.of(context).colorScheme.background);
  }

  void chooseImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    final currentUser = FirebaseAuth.instance.currentUser?.uid;
    // print(file?.path);
    if (file == null) return;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirUsers = referenceRoot.child('user');
    Reference referenceDirUser = referenceDirUsers.child(currentUser!);
    Reference imgToUpload = referenceDirUser.child(widget.dog.id);
    inspect(widget.dog.id);
    try {
      await imgToUpload.putFile(File(file.path));
      final dogDoc = FirebaseFirestore.instance.doc(widget.dog.docPath);
      final url = await imgToUpload.getDownloadURL();
      dogDoc.update({'imageURL': url});
      Utils.showSnackBar('Image saved!', Theme.of(context).colorScheme.background);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  bool? gender;
  @override
  Widget build(BuildContext context) {
    final dog = widget.dog;
    breedController.text = dog.breed;
    ageController.text = dog.age.toString();
    descController.text = dog.description;
    nameController.text = dog.name;
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: DogDidScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(blurRadius: 50, color: theme.onBackground, spreadRadius: 1)],
                      ),
                      child: GestureDetector(
                        onTap: chooseImage,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: theme.primary,
                          foregroundImage: NetworkImage(dog.imageURL),
                        ),
                      )),
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 40),
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      errorStyle: TextStyle(height: 0),
                    ),
                    controller: nameController,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      DogProfileEntry(
                        text: 'Breed',
                        controller: breedController,
                      ),
                      DogProfileEntry(
                        text: 'Age',
                        controller: ageController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                      ),
                      Row(
                        children: [
                          Text('Gender: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.tertiary)),
                          DropdownButton(
                              underline: const SizedBox(),
                              style: const TextStyle(fontSize: 20),
                              icon: Icon(
                                gender ?? dog.isFemale ? Icons.female_rounded : Icons.male_rounded,
                                color: theme.primary,
                              ),
                              value: gender ?? widget.dog.isFemale,
                              items: const [
                                DropdownMenuItem<bool?>(
                                  value: true,
                                  child: Text('Female'),
                                ),
                                DropdownMenuItem<bool?>(
                                  value: false,
                                  child: Text('Male'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              }),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.tertiary)),
                      ]),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(color: theme.onBackground, borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: SingleChildScrollView(
                                  child: TextFormField(
                                    controller: descController,
                                    maxLines: 8,
                                    decoration: const InputDecoration(border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            onPressed: save,
                            backgroundColor: theme.primary,
                            child: const Text('Save'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO add gender, edit name and picture
