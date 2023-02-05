import 'package:flutter/material.dart';
import 'package:rick_morty_app/common/models/character.dart';

class BasicInformationSection extends StatelessWidget {
  const BasicInformationSection({
    super.key,
    required this.character,
  });
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Basic Information',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Name: ${character.name}',
        ),
        Text(
          'Species: ${character.species}',
        ),
        Text(
          'Status: ${character.status}',
        ),
        Text(
          'Gender: ${character.gender}',
        ),
      ],
    );
  }
}
