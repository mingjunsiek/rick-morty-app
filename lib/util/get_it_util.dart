import 'package:get_it/get_it.dart';
import 'package:rick_morty_app/home/repositories/rick_morty_repository.dart';
import 'package:rick_morty_app/util/api_client.dart';

final getIt = GetIt.instance;

void setUpApiClient() {
  getIt.registerSingleton<ApiClient>(ApiClient());
  getIt<ApiClient>().initialize();
}

void setUpRepositories() {
  getIt.registerSingleton<RickMortyRepository>(RickMortyRepository());
}
