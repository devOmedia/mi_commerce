import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_commerce/business_logic/product_details/product_details_bloc.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_bloc.dart';
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
          ),
          BlocProvider<ProductDetailsBloc>(
            create: (context) => ProductDetailsBloc(
              repository: RepositoryProvider.of<AppRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffE5E5E5),
            appBarTheme: const AppBarTheme(
              color: Color(0xffE5E5E5),
            ),
            primarySwatch: Colors.blue,
          ),
          home: const SearchScreen(),
        ),
      ),
    );
  }
}
