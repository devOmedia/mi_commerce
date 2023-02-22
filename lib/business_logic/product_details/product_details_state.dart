import 'package:equatable/equatable.dart';
import 'package:mi_commerce/data/models/product_details.dart';

class ProductDetailsState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductDetailsLoadingState extends ProductDetailsState {}

class ProductDetailsLoadedState extends ProductDetailsState {
  final ProductDetailsModel detailsData;

  ProductDetailsLoadedState({required this.detailsData});
}

class ProductDetailsErrorState extends ProductDetailsState {}
