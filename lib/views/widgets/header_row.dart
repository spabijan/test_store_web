import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    required this.flex, required this.text, super.key,
  });

  final int flex;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ExpandableTableRow(
      flex: flex,
      widget: Text(
        text,
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
      ),
      color: const Color(0xff3c55ef),
    );
  }
}

class ExpandableTableRow extends StatelessWidget {
  const ExpandableTableRow({
    required this.flex, required this.widget, super.key,
    this.color = Colors.white,
  });

  final int flex;
  final Widget widget;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Container(
            decoration: BoxDecoration(
                color: color, //Color(0xff3c55ef)
                border: Border.all(color: Colors.grey.shade700)),
            child: Padding(padding: const EdgeInsets.all(8), child: widget)));
  }
}
