import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/home/provider/home_provider.dart';
import 'package:rick_morty_app/home/repositories/rick_morty_repository.dart';
import 'package:rick_morty_app/home/widgets/page/home_page.dart';
import 'package:rick_morty_app/util/page_state.dart';

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
        return right([]);
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

  testWidgets(
      'should change page state to success when fetchCharacters() successfully returns a response',
      (WidgetTester tester) async {
    await tester.pumpPage(childKey);
    final provider =
        Provider.of<HomeProvider>(childKey.currentContext!, listen: false);
    expect(provider.pageState, PageState.isLoading);

    await tester.pump(const Duration(milliseconds: 1000));
    expect(provider.pageState, PageState.success);

    verify(
      () => mockRickMortyRepository.fetchCharacters(),
    ).called(1);
  });
  testWidgets(
      'should change page state to isLoading when setIsLoading() is called',
      (WidgetTester tester) async {
    await tester.pumpPage(childKey);
    final provider =
        Provider.of<HomeProvider>(childKey.currentContext!, listen: false);
    expect(provider.pageState, PageState.isLoading);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(provider.pageState, PageState.success);
    verify(
      () => mockRickMortyRepository.fetchCharacters(),
    ).called(1);

    provider.setIsLoading();
    expect(provider.pageState, PageState.isLoading);
  });

  testWidgets(
      'should change page state to hasError when fetchCharacters() receives error',
      (WidgetTester tester) async {
    mockFailure();
    await tester.pumpPage(childKey);
    final provider =
        Provider.of<HomeProvider>(childKey.currentContext!, listen: false);
    expect(provider.pageState, PageState.isLoading);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(provider.pageState, PageState.hasError);
    verify(
      () => mockRickMortyRepository.fetchCharacters(),
    ).called(1);
  });
  testWidgets(
      'should change page state to success after tapping on retry button after receiving error from API',
      (WidgetTester tester) async {
    mockFailure();
    await tester.pumpPage(childKey);
    final provider =
        Provider.of<HomeProvider>(childKey.currentContext!, listen: false);
    expect(provider.pageState, PageState.isLoading);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(provider.pageState, PageState.hasError);
    verify(
      () => mockRickMortyRepository.fetchCharacters(),
    ).called(1);

    mockSuccess();
    provider.onRetryTapped();
    expect(provider.pageState, PageState.isLoading);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(provider.pageState, PageState.success);
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
