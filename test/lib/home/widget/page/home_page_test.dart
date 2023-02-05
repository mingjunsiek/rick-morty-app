import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/home/provider/home_provider.dart';
import 'package:rick_morty_app/home/repositories/rick_morty_repository.dart';
import 'package:rick_morty_app/home/widgets/molecule/character_card.dart';
import 'package:rick_morty_app/home/widgets/organism/home_page_has_error.dart';
import 'package:rick_morty_app/home/widgets/page/home_page.dart';

import 'mock_data/mock_characters.dart';

class MockRickMortyRepository extends Mock implements RickMortyRepository {}

void main() async {
  late final MockRickMortyRepository mockRickMortyRepository;
  late final GlobalKey childKey;

  void mockFailure() {
    when(
      () => mockRickMortyRepository.fetchCharacters(),
    ).thenAnswer(
      (_) async {
        await Future<void>.delayed(
          const Duration(
            seconds: 1,
          ),
        );
        return left(DioError(requestOptions: RequestOptions(path: '')));
      },
    );
  }

  void mockSuccess() {
    when(
      () => mockRickMortyRepository.fetchCharacters(),
    ).thenAnswer(
      (_) async {
        await Future<void>.delayed(
          const Duration(
            seconds: 1,
          ),
        );
        return right(characters);
      },
    );
  }

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    childKey = GlobalKey();
    mockRickMortyRepository = MockRickMortyRepository();
    mockSuccess();

    GetIt.instance
        .registerSingleton<RickMortyRepository>(mockRickMortyRepository);
  });

  testWidgets('should display loading body when page is loading',
      (WidgetTester tester) async {
    final isLoadingBodyFinder = find.byKey(HomePage.isLoadingBodyKey);
    await tester.pumpPage(childKey);
    expect(isLoadingBodyFinder, findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1000));
  });
  testWidgets('should display error body when page has error',
      (WidgetTester tester) async {
    mockFailure();
    final isLoadingBodyFinder = find.byKey(HomePage.isLoadingBodyKey);
    final hasErrorBodyFinder = find.byKey(HomePage.hasErrorBodyKey);
    await tester.pumpPage(childKey);
    expect(isLoadingBodyFinder, findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(hasErrorBodyFinder, findsOneWidget);
  });

  testWidgets('should display home page body when page successfully loads',
      (WidgetTester tester) async {
    final isLoadingBodyFinder = find.byKey(HomePage.isLoadingBodyKey);
    final homePageBodyFinder = find.byKey(HomePage.homePageBodyKey);
    mockSuccess();
    await tester.pumpPage(childKey);
    expect(isLoadingBodyFinder, findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(homePageBodyFinder, findsOneWidget);
  });
  testWidgets(
      'should change page state to success after tapping on retry button after receiving error from API',
      (WidgetTester tester) async {
    final isLoadingBodyFinder = find.byKey(HomePage.isLoadingBodyKey);
    final hasErrorBodyFinder = find.byKey(HomePage.hasErrorBodyKey);
    final homePageBodyFinder = find.byKey(HomePage.homePageBodyKey);

    mockFailure();
    await tester.pumpPage(childKey);
    expect(isLoadingBodyFinder, findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(hasErrorBodyFinder, findsOneWidget);

    mockSuccess();
    final retryButtonFinder = find.byKey(HomePageHasError.retryButtonKey);
    expect(retryButtonFinder, findsOneWidget);
    await tester.tap(retryButtonFinder);
    await tester.pump();
    expect(isLoadingBodyFinder, findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(homePageBodyFinder, findsOneWidget);
  });

  testWidgets('should display character cards when page successfully loads',
      (WidgetTester tester) async {
    final isLoadingBodyFinder = find.byKey(HomePage.isLoadingBodyKey);
    final homePageBodyFinder = find.byKey(HomePage.homePageBodyKey);
    mockSuccess();
    await tester.pumpPage(childKey);
    expect(isLoadingBodyFinder, findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(homePageBodyFinder, findsOneWidget);
    final characterCardsFinder = find.byType(
      CharacterCard,
    );
    int count = tester.widgetList<CharacterCard>(characterCardsFinder).length;
    expect(count, 8);
    final lastCharacterCard = find.byKey(const Key('character-card-20'));
    await tester.dragUntilVisible(
      lastCharacterCard,
      homePageBodyFinder,
      const Offset(0, -100),
    );
    expect(lastCharacterCard, findsOneWidget);
  });
}

extension on WidgetTester {
  Future<void> pumpPage(GlobalKey key) async {
    await pumpWidget(
      ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: HomePage(
              key: key,
            ),
          ),
        ),
      ),
    );
  }
}
