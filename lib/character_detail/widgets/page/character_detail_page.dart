import 'package:flutter/material.dart';
import 'package:rick_morty_app/character_detail/widgets/atom/character_image.dart';
import 'package:rick_morty_app/character_detail/widgets/molecule/basic_information_section.dart';
import 'package:rick_morty_app/character_detail/widgets/molecule/episode_section.dart';
import 'package:rick_morty_app/character_detail/widgets/molecule/location_section.dart';
import 'package:rick_morty_app/common/models/character.dart';
import 'package:rick_morty_app/util/spacing.dart';

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
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                CharacterImage(url: character.image),
                Spacing.sp10,
                BasicInformationSection(
                  character: character,
                ),
                Spacing.sp10,
                LocationSection(
                  character: character,
                ),
                Spacing.sp10,
                EpisodeSection(
                  character: character,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
