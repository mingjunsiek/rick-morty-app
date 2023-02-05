import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/home/provider/home_provider.dart';
import 'package:rick_morty_app/home/widgets/organism/home_page_body.dart';
import 'package:rick_morty_app/home/widgets/organism/home_page_has_error.dart';
import 'package:rick_morty_app/home/widgets/organism/home_page_is_loading.dart';
import 'package:rick_morty_app/util/page_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @visibleForTesting
  static const isLoadingBodyKey = Key('home-page-is-loading-body');
  @visibleForTesting
  static const hasErrorBodyKey = Key('home-page-has-error-body');
  @visibleForTesting
  static const homePageBodyKey = Key('home-page-body');

  @override
  Widget build(BuildContext context) {
    context.read<HomeProvider>().fetchCharacters();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick & Morty'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          switch (provider.pageState) {
            case PageState.isLoading:
              return const HomePageIsLoading(
                key: isLoadingBodyKey,
              );
            case PageState.hasError:
              return const HomePageHasError(key: hasErrorBodyKey);
            case PageState.success:
              return const HomePageBody(
                key: homePageBodyKey,
              );
          }
        },
      ),
    );
  }
}
