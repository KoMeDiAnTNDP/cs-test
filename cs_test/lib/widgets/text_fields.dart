import 'package:flutter/material.dart';

class CSTextFormField extends StatelessWidget {
  final String label;
  final FocusNode focusNode;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final FormFieldSetter<String> onSaved;
  final Key key;
  final TextInputAction textInputAction;
  final bool obscureText;

  CSTextFormField({@required this.label,
    this.focusNode,
    this.validator,
    this.onFieldSubmitted,
    this.onSaved,
    this.textInputAction,
    this.obscureText = false,
    this.key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      focusNode: this.focusNode,
      textInputAction: this.textInputAction,
      obscureText: this.obscureText,
      style: new TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: this.label,
        hintText: this.label,
        hasFloatingPlaceholder: false,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme
                .of(context)
                .errorColor),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme
                .of(context)
                .errorColor),
            borderRadius: BorderRadius.circular(10)),
        fillColor: Theme
            .of(context)
            .scaffoldBackgroundColor
            .withAlpha(64),
        labelStyle: TextStyle(color: Theme
            .of(context)
            .scaffoldBackgroundColor),
        hintStyle: TextStyle(color: Theme
            .of(context)
            .scaffoldBackgroundColor),
      ),
      validator: this.validator,
      onFieldSubmitted: this.onFieldSubmitted,
      onSaved: this.onSaved,
      key: this.key,
    );
  }
}
