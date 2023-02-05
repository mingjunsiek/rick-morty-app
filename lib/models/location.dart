import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  const factory Location({
    required String name,
    required String url,
  }) = _Location;

  const Location._();
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
