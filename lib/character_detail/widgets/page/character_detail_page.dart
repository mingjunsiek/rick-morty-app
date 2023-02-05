import 'package:flutter/material.dart';
import 'package:rick_morty_app/common/models/character.dart';

class CharacterDetailPage extends StatelessWidget {
  const CharacterDetailPage({
    super.key,
    required this.character,
  });
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
    );
  }
}
