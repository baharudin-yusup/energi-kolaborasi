import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class DropdownPicker extends StatelessWidget {
  final Function(String) onChanged;
  final dynamic doneButton;
  final dynamic closeButton;
  final double size;
  final List<DropdownMenuItem<dynamic>> items;
  final String hint;
  final List<int> selectedItems;

  final type;

  DropdownPicker._(
      {this.onChanged,
      this.size,
      this.items,
      this.hint,
      this.type,
      this.selectedItems,
      this.doneButton,
      this.closeButton});

  factory DropdownPicker.single({
    @required Function(String) onChanged,
    @required double size,
    @required List<DropdownMenuItem<dynamic>> items,
    @required String hint,
  }) {
    return DropdownPicker._(
      onChanged: onChanged,
      size: size,
      items: items,
      hint: hint,
      type: 0,
    );
  }

  factory DropdownPicker.multiple({
    @required Function onChanged,
    @required double size,
    @required List<DropdownMenuItem<dynamic>> items,
    @required String hint,
    @required List<int> selectedItems,
    @required dynamic doneButton,
    @required dynamic closeButton,
  }) {
    return DropdownPicker._(
      onChanged: onChanged,
      size: size,
      items: items,
      hint: hint,
      type: 1,
      selectedItems: selectedItems,
      doneButton: doneButton,
      closeButton: closeButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    var selectedItems;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1.7,
            spreadRadius: 0.7,
          )
        ],
      ),
      width: size,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size * 0.05),
        child: type == 0
            ? SearchableDropdown.single(
                items: items,
                hint: hint,
                searchHint: hint,
                onChanged: onChanged,
                isExpanded: true,
                isCaseSensitiveSearch: false,
                style: Theme.of(context).textTheme.bodyText2,
              )
            : SearchableDropdown.multiple(
                selectedItems: selectedItems,
                items: items,
                hint: hint,
                searchHint: hint,
                onChanged: onChanged,
                isExpanded: true,
                isCaseSensitiveSearch: false,
                style: Theme.of(context).textTheme.bodyText2,
                closeButton: closeButton,
                doneButton: '',
              ),
      ),
    );
  }
}
