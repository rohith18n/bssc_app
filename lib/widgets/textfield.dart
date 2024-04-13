import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool hasFocus;
  final String initialValue;
  final FocusNode focusNode;
  final void Function(bool)? onFocusChange;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hasFocus,
    required this.initialValue,
    required this.focusNode,
    this.onFocusChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      readOnly: true,
      initialValue: initialValue,
      style: TextStyle(
        color: hasFocus ? Colors.indigo : Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: hasFocus ? Colors.indigo : Colors.black,
          ),
        ),
        labelStyle: TextStyle(
          color: hasFocus ? Colors.indigo : Colors.black,
        ),
      ),
      onTap: () {
        if (onFocusChange != null) {
          onFocusChange!(true);
        }
      },
      onChanged: (value) {
        if (onFocusChange != null) {
          onFocusChange!(focusNode.hasFocus);
        }
      },
      onEditingComplete: () {
        if (onFocusChange != null) {
          onFocusChange!(false);
        }
      },
    );
  }
}
