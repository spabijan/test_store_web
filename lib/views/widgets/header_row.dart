import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    super.key,
    required this.flex,
    required this.text,
  });

  final int flex;
  final String text;

  @override
  Widget build(BuildContext context) {
    return UserTableRow(
      flex: flex,
      widget: Text(
        text,
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
      ),
      color: Color(0xff3c55ef),
    );
  }
}

class UserTableRow extends StatelessWidget {
  const UserTableRow({
    super.key,
    required this.flex,
    required this.widget,
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
            child: Padding(padding: EdgeInsets.all(8), child: widget)));
  }
}
