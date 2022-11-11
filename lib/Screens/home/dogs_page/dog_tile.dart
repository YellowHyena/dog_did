import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../dog_data.dart';
import 'dog_profile.dart';

class DogTile extends StatefulWidget {
  final DogData dog;

  const DogTile({super.key, required this.dog});
  @override
  State<DogTile> createState() => _DogTileState();
}

class _DogTileState extends State<DogTile> {
  @override
  Widget build(BuildContext context) {
    inspect(widget.dog);
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            foregroundImage: NetworkImage(widget.dog.imageURL),
            radius: 30,
          ),
          title: Text(
            widget.dog.name,
            style: const TextStyle(fontSize: 25),
          ),
          subtitle: Row(
            children: [
              Text(widget.dog.breed),
              Icon(
                widget.dog.isFemale ? Icons.female_rounded : Icons.male_rounded,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DogProfile(dog: widget.dog))),
        ),
        Divider(
          height: 10,
          thickness: 3,
          indent: 10,
          endIndent: 10,
          color: Theme.of(context).colorScheme.primary,
        )
      ],
    );
  }
}
