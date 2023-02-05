import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage({
    super.key,
    required this.url,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(url);
  }
}
