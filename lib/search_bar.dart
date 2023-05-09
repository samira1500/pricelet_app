import 'package:flutter/material.dart';
import 'package:pricelet_app/entity/item_entity.dart';

class SearchBarWidget extends StatefulWidget {
  final List<Item> items;
  final Function(List<Item>) onSearch;

  SearchBarWidget({required this.items, required this.onSearch});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _textEditingController = TextEditingController();

  void _onSearchTextChanged(String newText) {
    List<Item> searchResults = widget.items
        .where((i) => i.name.toLowerCase().contains(newText.toLowerCase()))
        .toList();

    widget.onSearch(searchResults);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        hintText: 'Search...',
      ),
      onChanged: _onSearchTextChanged,
    );
  }
}
