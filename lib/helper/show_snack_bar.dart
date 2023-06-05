import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,
    {FirebaseAuthException? exception, String? text}) {
  if (exception != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          exception.code,
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text!),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
