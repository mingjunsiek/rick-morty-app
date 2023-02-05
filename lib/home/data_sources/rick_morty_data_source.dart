import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rick_morty_app/common/models/character.dart';
import 'package:rick_morty_app/util/dio_util.dart';

class RickMortyDataSource {
  const RickMortyDataSource();

  Future<Either<DioError, List<Character>>> fetchCharacters() {
    return DioUtil.toTaskEither<List<Character>>(
      dioCall: (dio) => dio.get(
        '/api/character',
      ),
      toExpectedResult: (response) {
        final resultsObject =
            (response.data as Map<String, dynamic>)['results'];
        final results = List<Map<String, dynamic>>.from(resultsObject as List);
        return results
            .map((item) => Character.fromJson(
                  item,
                ))
            .toList();
      },
    ).run();
  }
}
