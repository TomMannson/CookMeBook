import 'package:flutter/material.dart';

InputDecoration inputDecoration({String? hintText, String? labelText}) {
  return InputDecoration(
    fillColor: Colors.red,
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
      ),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
    labelText: labelText,
  );
}
