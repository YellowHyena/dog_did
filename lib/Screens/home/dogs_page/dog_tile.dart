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
    return Column(
      children: [
        ListTile(
            leading: CircleAvatar(
              child: Text(widget.dog.age.toString()), //TODO change to picture of dog
            ),
            title: Text(widget.dog.name),
            subtitle: Text(widget.dog.breed),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DogProfile(dog: widget.dog)))),
        const Divider(
          height: 1,
          thickness: 3,
          indent: 30,
          endIndent: 30,
        )
      ],
    );
  }
}
