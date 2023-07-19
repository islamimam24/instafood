import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorSnackBar(message) {
  Get.snackbar("", "",
      backgroundColor: Colors.red.shade800,
      snackStyle: SnackStyle.FLOATING,
      titleText: const Text("Warning!",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      messageText: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ));
}
