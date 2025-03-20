import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/models/vendor/vendor_view_model.dart';
import 'package:test_store_web/views/widgets/header_row.dart';

class VendorWidget extends StatelessWidget {
  const VendorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<VendorViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ExpandableTableRow(
            flex: 1,
            widget: CircleAvatar(
                child: Text(
              vm.fullName[0],
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ))),
        ExpandableTableRow(
            flex: 3,
            widget: Text(vm.fullName,
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 16))),
        ExpandableTableRow(
            flex: 2,
            widget: Text(vm.email,
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 16))),
        ExpandableTableRow(
            flex: 2,
            widget: Text(vm.address,
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 16))),
        ExpandableTableRow(
            flex: 2,
            widget: TextButton(
              onPressed: () {},
              child: Text('DELETE',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                      fontSize: 16)),
            )),
      ],
    );
  }
}
