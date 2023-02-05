import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rick_morty_app/util/get_it_util.dart';

import 'api_client.dart';

typedef DioCall = Future<Response<dynamic>> Function(Dio dio);
typedef ToExpectedResult<T> = T Function(Response<dynamic> response);

class DioUtil {
  DioUtil._();
  static Task<Either<DioError, T>> toTaskEither<T>({
    required DioCall dioCall,
    required ToExpectedResult<T> toExpectedResult,
    Dio? client,
  }) {
    return Task(() => dioCall(client ?? getIt<ApiClient>().client))
        .attempt()
        .map(
          (either) => either.fold(
            (error) {
              return Left(error as DioError);
            },
            (response) {
              try {
                final result = toExpectedResult(response);
                return Right(result);
              } on Exception catch (e) {
                return Left(e as DioError);
              }
            },
          ),
        );
  }
}
