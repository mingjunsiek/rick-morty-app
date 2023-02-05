import 'package:flutter/material.dart';
import 'package:rick_morty_app/character_detail/widgets/page/character_detail_page.dart';
import 'package:rick_morty_app/common/models/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
  });
  final Character character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CharacterDetailPage(
            character: character,
          ),
        ),
      ),
      child: Card(
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
      ),
    );
  }
}
