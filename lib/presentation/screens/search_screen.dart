import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_bloc.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_state.dart';

import '../widgets/custom_search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<SearchProductBloc, SearchProductState>(
          listener: (context, state) {
            
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    //search field
                    CustomSearchFieldWidget(
                        size: size, searchController: _searchController),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
