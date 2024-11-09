  import 'package:flutter/material.dart';

InputDecoration inputDecoration() {
    return const InputDecoration(
      fillColor: Colors.red,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      hintText: '',
    );
  }