import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_bloc.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_state.dart';
import 'package:mi_commerce/data/app_reposity.dart';
import 'package:mi_commerce/presentation/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SearchProductBloc>(
            create: (context) => SearchProductBloc(
              RepositoryProvider.of<AppRepository>(context),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SearchScreen(),
        ),
      ),
    );
  }
}
