import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future showMyDialog(BuildContext context, String error) {
  if (error != 'Tanımsız bir hata oluştu.') {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          error,
          style: GoogleFonts.exo2(fontSize: 15),
        ),
        actions: [
          CupertinoButton(
            child: Text("Tamam", style: GoogleFonts.exo2()),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  } else {
    return null;
  }
}
