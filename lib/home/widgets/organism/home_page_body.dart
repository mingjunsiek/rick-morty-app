import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/home/provider/home_provider.dart';
import 'package:rick_morty_app/home/widgets/molecule/character_card.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final characters = context.read<HomeProvider>().characters;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
          itemCount: characters.length,
          itemBuilder: (_, index) {
            final character = characters[index];
            return CharacterCard(
              character: character,
            );
          }),
    );
  }
}
