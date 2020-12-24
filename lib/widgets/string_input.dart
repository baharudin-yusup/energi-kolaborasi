import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StringInputType {
  short,
  normal,
  long,
}

class StringInput extends StatelessWidget {
  final double size;

  final String hint;

  final Function(String) onChanged;
  final Function(String) onSaved;
  final TextInputType keyboardType;
  final Function(String) validator;
  final List<TextInputFormatter> inputFormatters;

  final StringInputType type;

  StringInput({
    @required double size,
    @required String hint,
    @required Function(String) onChanged,
    Function(String) onSaved,
    TextInputType keyboardType,
    Function(String) validator,
    List<TextInputFormatter> inputFormatters,
    StringInputType type,
  })  : this.size = size,
        this.hint = hint,
        this.onChanged = onChanged,
        this.onSaved = onSaved ?? onChanged,
        this.keyboardType = keyboardType ?? TextInputType.text,
        this.validator = validator,
  this.type = type ?? StringInputType.normal,
  this.inputFormatters = inputFormatters ?? [];

  @override
  Widget build(BuildContext context) {
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
            blurRadius: 1.1,
            spreadRadius: 0.9,
          )
        ],
      ),
      width: size,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size * 0.05),
        child: TextFormField(
          decoration: InputDecoration(
            hintStyle: Theme.of(context).textTheme.bodyText2,
            hintText: hint,
            border: InputBorder.none,
          ),
          keyboardType: keyboardType,
          maxLines: type == StringInputType.long ? 5 : 1,
          onChanged: onChanged,
          onSaved: onSaved,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText1,
          autocorrect: false,
          validator: validator,
          maxLength: type == StringInputType.short ? 30 : null,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }
}
