import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/home/provider/home_provider.dart';
import 'package:rick_morty_app/home/widgets/page/home_page.dart';
import 'package:rick_morty_app/util/get_it_util.dart';

void main() {
  setUpApiClient();
  setUpRepositories();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        child: const HomePage(),
      ),
    );
  }
}
