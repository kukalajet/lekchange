import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exchange_repository/exchange_repository.dart';
import 'package:lekchange/blocs/blocs.dart';
import 'package:lekchange/screens/screens.dart';

class App extends StatelessWidget {
  final ExchangeRepository exchangeRepository;

  const App({Key? key, required this.exchangeRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repositoryProviders = <RepositoryProvider>[
      RepositoryProvider<ExchangeRepository>(create: (_) => exchangeRepository)
    ];

    final scanBloc = ScanBloc(exchangeRepository: exchangeRepository);
    final exchangeBloc = ExchangeBloc(
      exchangeRepository: exchangeRepository,
      scanBloc: scanBloc,
    );

    final blocProviders = <BlocProvider>[
      BlocProvider<ScanBloc>(
        create: (_) => scanBloc,
      ),
      BlocProvider<ExchangeBloc>(
        create: (_) => exchangeBloc..add(ExchangeFetched()),
      )
    ];

    return MultiRepositoryProvider(
      providers: repositoryProviders,
      child: MultiBlocProvider(
        providers: blocProviders,
        child: const AppView(),
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
