import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exchange_repository/exchange_repository.dart';
import 'package:lekchange/blocs/scan/scan.dart';
import 'package:lekchange/screens/screens.dart';

class App extends StatelessWidget {
  final ExchangeRepository exchangeRepository;

  const App({Key? key, required this.exchangeRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repositoryProviders = <RepositoryProvider>[
      RepositoryProvider<ExchangeRepository>(create: (_) => exchangeRepository)
    ];

    final blocProviders = <BlocProvider>[
      BlocProvider<ScanBloc>(
        create: (_) => ScanBloc(exchangeRepository: exchangeRepository),
      )
    ];

    return MultiRepositoryProvider(
      providers: repositoryProviders,
      child: MultiBlocProvider(
        providers: blocProviders,
        child: AppView(key: key),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ScannerScreen(key: key));
  }
}
