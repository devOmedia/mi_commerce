import 'package:flutter/material.dart';
import 'package:mi_commerce/data/models/products_model.dart';
import 'package:mi_commerce/presentation/utils/constants.dart';
import 'package:mi_commerce/presentation/widgets/custom_search_field.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productData});
  final Results productData;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
    final data = widget.productData;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "প্রোডাক্ট ডিটেইল",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: (() => Navigator.pop(context)),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //===================================>> search field
              CustomSearchFieldWidget(
                searchController: _searchController,
                size: size,
                onChange: (value) {},
              ),
              //=======================================>> product image
              SizedBox(height: size.height * 0.02),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.3,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Image.network(data.image!),
                ),
              ),
              //======================================>> product details.
              SizedBox(height: size.height * 0.02),
              //product name
              Text(
                data.productName!,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: KColor.black),
              ),
              // brand name
              brandInfoWidget(data, size),
              SizedBox(height: size.height * 0.02),
              //product pricing card widget
              poductPricingCard(size, data),
              SizedBox(height: size.height * 0.02),
              Text(
                "বিস্তারিত",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: const Color(0xff323232)),
              ),
              Text(
                data.description!,
                style: const TextStyle(
                  color: Color(0XFF646464),
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container poductPricingCard(Size size, Results data) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: size.height * 0.2,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // current charge.
          DefaultTextStyle(
            style: TextStyle(
              color: KColor.red,
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.045,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "ক্রয়মূল্যঃ",
                ),
                Text(data.charge!.currentCharge.toString())
              ],
            ),
          ),
          // selling price
          DefaultTextStyle(
            style: TextStyle(
              color: KColor.black,
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.045,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "বিক্রয়মূল্যঃ",
                ),
                Text(data.charge!.sellingPrice.toString())
              ],
            ),
          ),
          const Expanded(
            child: Divider(
              thickness: 2,
            ),
          ),
          // profit price
          DefaultTextStyle(
            style: TextStyle(
              color: KColor.black,
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.045,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "লাভঃ",
                ),
                Text(data.charge!.profit.toString())
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row brandInfoWidget(Results data, Size size) {
    return Row(
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'ব্রান্ডঃ ',
                style:
                    TextStyle(color: KColor.grey, fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: data.brand!.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.04,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(4),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: KColor.red),
        ),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'ডিস্ট্রিবিউটরঃ ',
                style:
                    TextStyle(color: KColor.grey, fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: data.seller,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.04,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
