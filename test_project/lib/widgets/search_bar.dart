import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: h / 17,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0), color: Colors.white),
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _searchQueryController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.black),
            hintText: 'Search for food items',
            hintStyle: TextStyle(color: Colors.black45),
            border: InputBorder.none,
          ),
          style:const TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ),
    );
  }
}
