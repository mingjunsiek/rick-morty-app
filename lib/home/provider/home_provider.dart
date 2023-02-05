import 'package:flutter/material.dart';
import 'package:rick_morty_app/common/models/character.dart';
import 'package:rick_morty_app/home/repositories/rick_morty_repository.dart';
import 'package:rick_morty_app/util/get_it_util.dart';
import 'package:rick_morty_app/util/page_state.dart';

class HomeProvider with ChangeNotifier {
  List<Character> characters = [];
  PageState pageState = PageState.isLoading;
  final RickMortyRepository repository = getIt<RickMortyRepository>();

  void onRetryTapped() {
    setIsLoading();
    fetchCharacters();
  }

  void setIsLoading() {
    pageState = PageState.isLoading;
    notifyListeners();
  }

  void fetchCharacters() async {
    final result = await repository.fetchCharacters();
    result.fold(
      (error) {
        pageState = PageState.hasError;
        notifyListeners();
      },
      (response) {
        pageState = PageState.success;
        characters = response;
        notifyListeners();
      },
    );
  }
}
