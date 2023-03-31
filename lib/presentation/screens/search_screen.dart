import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_bloc.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_event.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_state.dart';
import 'package:mi_commerce/data/app_reposity.dart';
import 'package:mi_commerce/data/models/products_model.dart';
import 'package:mi_commerce/presentation/screens/product_details_screen.dart';
import 'package:mi_commerce/presentation/utils/constants.dart';

import '../widgets/custom_search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  ScrollController? _controller;
  @override
  void initState() {
    _searchController = TextEditingController();
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

//before research reset the offset value.
  _resetOfsetLimit() {
    if (_searchController.text.isEmpty) {
      AppRepository.offsetLimit = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    _resetOfsetLimit();
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<SearchProductBloc, SearchProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    //search field
                    CustomSearchFieldWidget(
                      size: size,
                      searchController: _searchController,
                      onChange: (searchPattern) {
                        //calling api as per search pattern.
                        context.read<SearchProductBloc>().add(
                              SearchEvent(
                                  limit: 0, searchPattern: searchPattern),
                            );
                      },
                    ),
                    SizedBox(height: size.height * 0.02),
                    // loading state
                    if (state is LoadingState)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    //data loaded state,
                    //view search results.
                    if (state is LoadedState)
                      SizedBox(
                        height: size.height * 0.85,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification.metrics.pixels ==
                                notification.metrics.maxScrollExtent) {
                              context.read<SearchProductBloc>().add(
                                    SearchEvent(
                                        limit: 4,
                                        searchPattern: _searchController.text),
                                  );
                            }
                            return true;
                          },
                          child: GridView.builder(
                            controller: _controller,
                            itemCount: state
                                .productsModel.data!.products!.results!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        (orientation == Orientation.portrait)
                                            ? 2
                                            : 3),
                            itemBuilder: (BuildContext context, int index) {
                              if (state.productsModel.data != null) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailsScreen(
                                                data: state.productsModel.data!
                                                    .products!.results![index],
                                              ),
                                            ),
                                          );
                                        },
                                        //check if result has any data at current index
                                        child: state
                                                    .productsModel
                                                    .data!
                                                    .products!
                                                    // ignore: unnecessary_null_comparison
                                                    .results![index] !=
                                                null
                                            ? productCardWidget(
                                                size,
                                                state.productsModel.data!
                                                    .products!.results![index])
                                            : Container(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              } else {
                                return const Text("Product ase nai");
                              }
                            },
                          ),
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget productCardWidget(Size size, Results results) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 8, bottom: 8),
          height: size.height * 0.30,
          // width: size.width * 0.45,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image(
                image: NetworkImage(results.image!),
                alignment: Alignment.center,
                height: size.height * 0.09,
                fit: BoxFit.fill,
              )),
              //product name and type
              SizedBox(
                height: size.height * 0.01,
              ),
              DefaultTextStyle(
                style: TextStyle(
                  fontFamily: "poppins",
                  color: const Color(0xff323232),
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.03,
                ),
                child: Text(
                  results.productName!,
                ),
              ),
              //poduct price
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (results.charge!.discountCharge != null)
                    priceTextWidget(
                        text: "ক্রয় ",
                        size: size,
                        color: const Color(0xffda2079),
                        price: results.charge!.discountCharge!)
                  else
                    priceTextWidget(
                        text: "ক্রয় ",
                        size: size,
                        color: const Color(0xffda2079),
                        price: results.charge!.currentCharge!),
                  Text(
                    "৳${results.charge!.currentCharge!}",
                    style: TextStyle(
                        color: const Color(0xffda2079),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.lineThrough,
                        fontSize: size.width * 0.035),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: priceTextWidget(
                          text: "বিক্রয়",
                          size: size,
                          color: const Color(0xffda2079),
                          price: results.charge!.sellingPrice ?? 0.0)),
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: priceTextWidget(
                          text: "লাভ",
                          size: size,
                          color: const Color(0xffda2079),
                          price: results.charge!.profit ?? 0.0)),
                  // Text(
                  //   '৳ 20.00',
                  //   style: TextStyle(
                  //       color: const Color(0xffda2079),
                  //       fontWeight: FontWeight.w600,
                  //       decoration: TextDecoration.lineThrough,
                  //       fontSize: size.width * 0.035),
                  // )
                ],
              ),
            ],
          ),
        ),
        //===========================>> out of stock container
        if (results.stock == 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffFFCCCC),
              ),
              child: const Text(
                "স্টকে নেই",
                style: TextStyle(
                  color: Color(0xffC62828),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        else
          // add to card widget
          // Positioned(
          //   bottom: 0,
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Container(
          //       width: size.width * 0.1,
          //       decoration: const BoxDecoration(
          //         shape: BoxShape.circle,
          //         gradient: LinearGradient(
          //           begin: Alignment.centerLeft,
          //           end: Alignment.centerRight,
          //           colors: [
          //             KColor.addToCard2,
          //             KColor.addToCard1,
          //           ],
          //         ),
          //       ),
          //       child: const Center(
          //         child: Icon(
          //           Icons.add,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * 0.04,
              width: size.width * 0.25,
              decoration: BoxDecoration(
                color: KColor.lightPink,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: KColor.red,
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Flexible(
                    child: Text(
                      "17 পিস",
                      style: TextStyle(
                          color: KColor.red, fontWeight: FontWeight.w500),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: KColor.addToCard2,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }

  Widget priceTextWidget({size, color = const Color(0xffda2079), price, text}) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: text,
            style: TextStyle(
              fontSize: size.width * 0.03,
              fontFamily: "baloo da2",
              fontWeight: FontWeight.w400,
            )),
        TextSpan(
          text: "৳$price",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: size.width * 0.035,
            color: color,
          ),
        ),
      ],
    ));
  }
}
