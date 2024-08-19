import 'package:employe_portal/color.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class CustomSearchField extends StatefulWidget {
  final List<String> suggestions;
  final Icon icon;
  final TextEditingController controller;
  final String hint;
  final VoidCallback onSuggestionAdded;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;

  const CustomSearchField({
    Key? key,
    required this.suggestions,
    required this.icon,
    required this.hint,
    required this.onSuggestionAdded,
    required this.controller,
    this.focusNode,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _CustomSearchFieldState createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focus.dispose();
    }
    super.dispose();
  }

  Widget searchChild(String x) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
        child: Text(
          x, 
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SearchField<String>(
      suggestionDirection: SuggestionDirection.flex,
      onSearchTextChanged: (query) {
        final filter = widget.suggestions
            .where((element) => element.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return filter
            .map((e) => SearchFieldListItem<String>(e, child: searchChild(e)))
            .toList();
      },
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || !widget.suggestions.contains(value.trim())) {
          return 'Enter a valid industry name';
        }
        return null;
      },
      onSubmit: (x) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(x);
        }
      },
      autofocus: false,
      key: const Key('searchfield'),
      hint: widget.hint,
      itemHeight: 50,
      scrollbarDecoration: ScrollbarDecoration(
        thickness: 6,
        radius: const Radius.circular(18),
        trackColor: Colors.grey,
        trackBorderColor: Colors.red,
        thumbColor: const Color(0xff2476BD),
      ),
      suggestionStyle: const TextStyle(
        fontSize: 18,
        color: Colors.blueGrey,
        fontWeight: FontWeight.w400,
      ),
      searchStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      suggestionItemDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      searchInputDecoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.red,
            style: BorderStyle.solid,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.grey,
            style: BorderStyle.solid,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.white,
            style: BorderStyle.solid,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        prefixIcon: IconButton(
          icon: widget.icon,
          onPressed: () {
            print("Icon pressed");
          },
        ),
      ),
      suggestionsDecoration: SuggestionDecoration(
        elevation: 8.0,
        selectionColor: Colors.grey.shade100,
        hoverColor: Colors.purple.shade100,
        gradient: const LinearGradient(
          colors: [Color(0xffffffffffff), Color.fromARGB(255, 255, 255, 255)],
          stops: [0.25, 0.75],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      suggestions: widget.suggestions
          .map((e) => SearchFieldListItem<String>(e, child: searchChild(e)))
          .toList(),
      focusNode: _focus,
      suggestionState: Suggestion.expand,
      onSuggestionTap: (SearchFieldListItem<String> x) {
        // Handle suggestion tap action here
      },
    );
  }
}