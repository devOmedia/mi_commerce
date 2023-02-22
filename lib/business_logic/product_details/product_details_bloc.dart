import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_commerce/business_logic/product_details/product_details_event.dart';
import 'package:mi_commerce/business_logic/product_details/product_details_state.dart';
import 'package:mi_commerce/data/app_reposity.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc({required this.repository})
      : super(ProductDetailsState()) {
    on<GetProductDetails>((event, emit) async {
      emit(ProductDetailsLoadingState());

      final details = repository.getProductDetails(event.slug);

      if (details != null) {
        emit(ProductDetailsLoadedState(detailsData: details));
      } else {
        emit(ProductDetailsErrorState());
      }
    });
  }

  final AppRepository repository;
}
