import 'package:flutter/material.dart';
import 'package:rick_morty_app/common/models/character.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({
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
          'Location',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Name: ${character.location.name}',
        ),
      ],
    );
  }
}
