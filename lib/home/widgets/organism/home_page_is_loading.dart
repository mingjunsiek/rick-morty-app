import 'package:flutter/material.dart';

class HomePageIsLoading extends StatelessWidget {
  const HomePageIsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
