import 'package:flutter/material.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_event.dart';
import 'package:mi_commerce/business_logic/search_bloc/search_state.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
          children: const [
            
          ],
        ),
      ),
    );
  }
}
