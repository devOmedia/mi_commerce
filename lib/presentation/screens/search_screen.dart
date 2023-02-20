import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_bloc.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_event.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_state.dart';
import 'package:mi_commerce/data/models/products_model.dart';

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
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
                        print(searchPattern);
                        context.read<SearchProductBloc>().add(
                              SearchEvent(
                                  limit: 0, searchPattern: searchPattern),
                            );
                      },
                    ),
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
                              return productCardWidget(
                                  size,
                                  state.productsModel.data!.products!
                                      .results![index]);
                            } else {
                              return const Text("Product ase nai");
                            }
                          },
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

  Container productCardWidget(Size size, Results results) {
    return Container(
      margin: const EdgeInsets.only(left: 8, bottom: 8),
      height: size.height * 0.20,
      width: size.width * 0.40,
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
                      price: results.charge!.sellingPrice!)),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: priceTextWidget(
                      text: "লাভ",
                      size: size,
                      color: const Color(0xffda2079),
                      price: results.charge!.profit!)),
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
