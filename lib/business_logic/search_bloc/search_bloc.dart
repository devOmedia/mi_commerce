import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_event.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_state.dart';
import 'package:mi_commerce/data/app_reposity.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  SearchProductBloc(this.repository) : super(SearchProductState()) {
    on<SearchEvent>((event, emit) async {
      emit(LoadingState());
      //get the search data
      final results = await repository.getSearchResult(
          searchPattern: event.searchPattern, limit: event.limit);

      if (results != null) {
        //if success
        emit(LoadedState(results));
      } else {
        emit(OnErrorState());
      }
    });
  }

  final AppRepository repository;
}
