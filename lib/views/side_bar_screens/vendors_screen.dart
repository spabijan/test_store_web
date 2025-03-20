import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/controllers/vendors_screen_view_model.dart';
import 'package:test_store_web/views/widgets/header_row.dart';
import 'package:test_store_web/views/widgets/vendor_list_widget.dart';

class VendorsScreen extends StatefulWidget {
  const VendorsScreen({super.key});
  static const String routeName = '/vendorsscreen';

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VendorsScreenViewModel>(context, listen: false).loadVendors();
    });
  }

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
            child: Text('Manage vendors',
                style: GoogleFonts.montserrat(
                    fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 16,
          ),
          const Row(
            children: [
              HeaderRow(flex: 1, text: 'Image'),
              HeaderRow(flex: 3, text: 'Full Name'),
              HeaderRow(flex: 2, text: 'Email'),
              HeaderRow(flex: 2, text: 'Address'),
              HeaderRow(flex: 2, text: 'Delete'),
            ],
          ),
          const VendorListWidget()
        ],
      )),
    );
  }
}
