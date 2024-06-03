import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Content extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  Content(
      {super.key,
      required this.title,
      required this.content,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Note',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(date),
            Gap(30),
            Text(
              content,
              style: TextStyle(color: Colors.black54, fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
