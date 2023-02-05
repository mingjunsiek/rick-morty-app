import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/home/provider/home_provider.dart';

class HomePageHasError extends StatelessWidget {
  const HomePageHasError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Error has occured, please try again later'),
          TextButton(
            onPressed: context.read<HomeProvider>().onRetryTapped,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
