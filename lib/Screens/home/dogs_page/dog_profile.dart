import 'dart:ffi';

import 'package:dog_did/dog_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dog_profile_form.dart';

class DogProfile extends StatefulWidget {
  const DogProfile({super.key, required this.dog});
  final DogData dog;

  @override
  State<DogProfile> createState() => _DogProfileState();
}

class _DogProfileState extends State<DogProfile> {
  @override
  Widget build(BuildContext context) {
    final dog = widget.dog;
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
                child: Column(
                  children: [
                    DogProfileEntry(
                      text: 'Breed',
                      initialValue: dog.breed,
                    ),
                    DogProfileEntry(
                      text: 'Age',
                      initialValue: dog.age.toString(),
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
                                  initialValue: dog.description,
                                  maxLines: 8,
                                  decoration: const InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
