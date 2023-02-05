import 'package:flutter/material.dart';
import 'package:rick_morty_app/common/models/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
  });
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Name: ${character.name}',
            ),
            Text(
              'Species: ${character.species}',
            ),
            Text(
              'Status: ${character.status}',
            ),
          ],
        ),
      ),
    );
  }
}
