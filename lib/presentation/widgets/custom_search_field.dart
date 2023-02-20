import 'package:flutter/material.dart';

class CustomSearchFieldWidget extends StatelessWidget {
  const CustomSearchFieldWidget({
    Key? key,
    required this.size,
    required TextEditingController searchController,
    required this.onChange,
  })  : _searchController = searchController,
        super(key: key);

  final Size size;
  final TextEditingController _searchController;
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.08,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Center(
        child: TextFormField(
          controller: _searchController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: "কাঙ্ক্ষিত পণ্যটি খুঁজুন",
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.search_outlined,
              color: Color(0xffA7A7A7),
            ),
          ),
          onChanged: onChange,
        ),
      ),
    );
  }
}
