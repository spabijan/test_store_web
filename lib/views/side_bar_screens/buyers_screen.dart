import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_web/views/widgets/header_row.dart';

class BuyersScreen extends StatelessWidget {
  const BuyersScreen({super.key});
  static const String routeName = '/buyerscreen';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text('Manage buyers',
                style: GoogleFonts.montserrat(
                    fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              HeaderRow(flex: 1, text: 'Image'),
              HeaderRow(flex: 3, text: 'Full Name'),
              HeaderRow(flex: 2, text: 'Email'),
              HeaderRow(flex: 2, text: 'Address'),
              HeaderRow(flex: 2, text: 'Delete'),
            ],
          )
        ],
      )),
    );
  }
}
