import 'package:dog_did/global_widgets/dog_did_scaffold.dart';
import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/screens/dogs/dog_tile.dart';
import 'package:flutter/material.dart';
import '../../global_widgets/dog_data.dart';
import 'dog_profile.dart';

class DogsPage extends StatelessWidget {
  const DogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DogDidScaffold(
      appBar: AppBar(
        title: const Text('Dogs'),
        actions: [
          IconButton(
              onPressed: () async {
                DogData dog = await DogData.createDogInDatabase();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DogProfile(dog: dog)));
              },
              icon: Icon(
                Icons.add_rounded,
                color: colorScheme().primary,
              ))
        ],
      ),
      body: StreamBuilder<List<DogData>>(
          stream: DogData.readDogs(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            } else if (snapshot.hasData) {
              return ListView(children: snapshot.data!.map((e) => DogTile(dog: e)).toList());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
