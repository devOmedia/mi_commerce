import 'package:flutter/material.dart';
import 'package:mi_commerce/data/models/products_model.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //===================================>> search field
            CustomSearchFieldWidget(
              searchController: _searchController,
              size: size,
              onChange: (value) {},
            ),
            //=======================================>> product image
            SizedBox(height: size.height * 0.02),
            Container(
              height: size.height * 0.35,
              width: size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Image.network(data.image!),
            )
          ],
        ),
      ),
    );
  }
}
