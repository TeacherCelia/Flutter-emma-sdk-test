import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Toast configurado para mostrarse de tres estilos diferentes
class CustomToast {
  static void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: const Color(0xFF19FF98),
      textColor: Colors.black,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }

  static void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }

  static void showInfo(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }
}
