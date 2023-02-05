import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_morty_app/models/location.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required Location origin,
    required Location location,
    required String image,
    required List<String> episode,
    required String url,
    required DateTime created,
  }) = _Character;

  const Character._();
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}
