import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_did/dog_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dog_profile_form.dart';

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
    super.dispose();
  }

  final breedController = TextEditingController();
  final ageController = TextEditingController();
  final descController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var _enabled = false;

  void save() {
    final user = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('dogs').doc(widget.dog.id);

    if (breedController.text != widget.dog.breed) user.update({'breed': breedController.text});
    if (ageController.text != widget.dog.age.toString()) user.update({'age': int.parse(ageController.text)});
    if (descController.text != widget.dog.description) user.update({'description': descController.text});
  }

  void enableSave(String? string) => formKey.currentState!.validate() ? setState(() => _enabled = true) : setState(() => _enabled = false);

  @override
  Widget build(BuildContext context) {
    final dog = widget.dog;
    breedController.text = dog.breed;
    ageController.text = dog.age.toString();
    descController.text = dog.description;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.dog.name),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: ListView(
            children: [
              Column(
                children: [
                  const CircleAvatar(radius: 100),
                  Text(
                    dog.name,
                    style: const TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(
                    height: 40,
                    thickness: 3,
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
                      const SizedBox(height: 10),
                      Row(children: [
                        Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.tertiary)),
                      ]),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground, borderRadius: BorderRadius.circular(10)),
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
                            backgroundColor: Theme.of(context).colorScheme.primary,
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
