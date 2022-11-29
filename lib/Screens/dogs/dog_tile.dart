import 'package:flutter/material.dart';
import '../../global_widgets/dog_data.dart';
import '../../global_widgets/color_scheme.dart';
import 'dog_profile.dart';

class DogTile extends StatelessWidget {
  final DogData dog;

  const DogTile({super.key, required this.dog});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            foregroundImage: NetworkImage(dog.imageURL),
            radius: 30,
            backgroundColor: colorScheme().inversePrimary,
            child: Icon(
              Icons.pets_rounded,
              size: 40,
              color: colorScheme().primary,
            ),
          ),
          title: Text(
            dog.name,
            style: const TextStyle(fontSize: 25),
          ),
          subtitle: Row(
            children: [
              Text(dog.breed),
              Icon(
                dog.isFemale ? Icons.female_rounded : Icons.male_rounded,
                color: colorScheme().primary,
              )
            ],
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DogProfile(dog: dog))),
        ),
        Divider(
          height: 10,
          thickness: 1,
          indent: 10,
          endIndent: 10,
          color: colorScheme().primary,
        )
      ],
    );
  }
}
