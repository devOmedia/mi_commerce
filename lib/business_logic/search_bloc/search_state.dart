import 'package:equatable/equatable.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_event.dart';
import 'package:mi_commerce/data/models/products_model.dart';

class SearchProductState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingState extends SearchProductState {}

class LoadedState extends SearchProductState {
  final ProductsModel productsModel;

  LoadedState(this.productsModel);
}

class OnErrorState extends SearchProductState{}
