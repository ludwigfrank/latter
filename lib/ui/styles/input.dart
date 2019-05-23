import 'package:flutter/material.dart';

InputDecoration defaultTextInputDecoration = InputDecoration(
    filled: true,
    enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
            width: 1,
            color: Colors.blueGrey[100]
        )
    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            width: 1,
            color: Colors.blueGrey[100]
        )
    )
);