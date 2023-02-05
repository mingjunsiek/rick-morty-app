import 'package:flutter/material.dart';
import 'package:rick_morty_app/common/models/character.dart';

class EpisodeSection extends StatelessWidget {
  const EpisodeSection({
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
          'Episodes',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ...character.episode
            .map(
              (episode) => Text(
                episode,
              ),
            )
            .toList(),
      ],
    );
  }
}
