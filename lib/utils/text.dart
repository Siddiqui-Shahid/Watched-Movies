import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class modified_text extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final bool isDiscreption;
  final FontWeight fontWeight;

  final int maxLines;

  const modified_text(
      {Key key,
      this.text,
      this.color,
      this.size,
      this.isDiscreption = false,
      this.fontWeight = FontWeight.normal,
      this.maxLines = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
          color: color, fontSize: size, fontWeight: fontWeight),
      overflow: isDiscreption ? null : TextOverflow.ellipsis,
      maxLines: isDiscreption ? null : maxLines,
    );
  }
}
