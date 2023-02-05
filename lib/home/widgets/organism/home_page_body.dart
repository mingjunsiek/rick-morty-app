import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/home/provider/home_provider.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: context.read<HomeProvider>().characters.length,
        itemBuilder: (_, index) {
          final character = context.read<HomeProvider>().characters[index];
          return Card(
            child: Text(character.name),
          );
        });
  }
}
