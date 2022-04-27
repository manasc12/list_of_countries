import 'package:flutter/material.dart';

Center buildCenteredTextWidget({required String text}) {
  return Center(
      child: Text(
    text,
    style: const TextStyle(fontSize: 20),
  ));
}
