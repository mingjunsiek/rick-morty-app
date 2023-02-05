import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/character.dart';
import '../data_sources/rick_morty_data_source.dart';

class RickMortyRepository {
  final RickMortyDataSource _dataSource = const RickMortyDataSource();

  Future<Either<DioError, List<Character>>> fetchCharacters() =>
      _dataSource.fetchCharacters();
}
