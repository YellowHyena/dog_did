import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_did/global_widgets/dog_data.dart';
import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/global_widgets/current_user.dart';
import 'package:dog_did/global_widgets/dog_did_scaffold.dart';
import 'package:dog_did/global_widgets/utils.dart';
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
  //TODO add ? icon for help?
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
  bool? genderState;
  String? newProfileImage;

  Future<void> save() async {
    final dog = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection('dogs').doc(widget.dog.id);

    if (nameController.text != widget.dog.name) await dog.update({'name': nameController.text});
    if (breedController.text != widget.dog.breed) await dog.update({'breed': breedController.text});
    if (ageController.text != widget.dog.age.toString()) await dog.update({'age': int.parse(ageController.text)});
    if (descController.text != widget.dog.description) await dog.update({'description': descController.text});
    if (genderState != widget.dog.isFemale && genderState != null) await dog.update({'isFemale': genderState});
    Utils.showSnackBar('Saved changes!', colorScheme().background);
  }

  void chooseImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final dog = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection('dogs').doc(widget.dog.id);
    Reference imgDir = FirebaseStorage.instance.ref().child('user').child(currentUser!.uid).child(widget.dog.id);
    try {
      await imgDir.putFile(File(file.path));
      final url = await imgDir.getDownloadURL();
      setState(() {
        dog.update({'imageURL': url});
        newProfileImage = url;
      });
      Utils.showSnackBar('Image is saved.', colorScheme().background);
    } catch (error) {
      if (kDebugMode) {
        Utils.showSnackBar('Adding image failed.', colorScheme().error);
      }
    }
  }

  deleteDog() async {
    try {
      await DogData.delete(widget.dog);
    } catch (e) {
      Utils.showSnackBar('Removing dog failed.', colorScheme().error);
      return;
    }
    Navigator.of(context).pop();
    Utils.showSnackBar('Dog was successfully removed.', colorScheme().background);
  }

  @override
  Widget build(BuildContext context) {
    final dog = widget.dog;
    breedController.text = breedController.text.isEmpty ? dog.breed : breedController.text;
    ageController.text = ageController.text.isEmpty ? dog.age.toString() : ageController.text;
    descController.text = descController.text.isEmpty ? dog.description : descController.text;
    nameController.text = nameController.text.isEmpty ? dog.name : nameController.text;
    inspect(dog.imageURL);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: DogDidScaffold(
        appBar: AppBar(actions: [IconButton(icon: const Icon(Icons.delete_forever_rounded), onPressed: () => Utils.confirmAction('delete this dog profile? This action is ireversible.', deleteDog, context))]),
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
                        boxShadow: [BoxShadow(blurRadius: 50, color: colorScheme().onBackground, spreadRadius: 1)],
                      ),
                      child: GestureDetector(
                        onTap: chooseImage,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: colorScheme().inversePrimary,
                          foregroundImage: NetworkImage(newProfileImage ?? widget.dog.imageURL),
                          child: Icon(
                            Icons.pets_rounded,
                            size: 120,
                            color: colorScheme().primary,
                          ),
                        ),
                      )),
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 40),
                    decoration: const InputDecoration(counterText: '', border: InputBorder.none, errorStyle: TextStyle(height: 0)),
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
                          Text('Gender: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorScheme().tertiary)),
                          DropdownButton(
                              underline: const SizedBox(),
                              style: const TextStyle(fontSize: 20),
                              icon: Icon(
                                genderState ?? dog.isFemale ? Icons.female_rounded : Icons.male_rounded,
                                color: colorScheme().primary,
                              ),
                              value: genderState ?? widget.dog.isFemale,
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
                                  genderState = value;
                                });
                              }),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorScheme().tertiary)),
                      ]),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(color: colorScheme().onBackground, borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: SingleChildScrollView(
                                          child: TextFormField(
                                        controller: descController,
                                        maxLines: 8,
                                        decoration: const InputDecoration(border: InputBorder.none),
                                      )))))
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            onPressed: save,
                            backgroundColor: colorScheme().primary,
                            child: const Text('Save'),
                          )
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
