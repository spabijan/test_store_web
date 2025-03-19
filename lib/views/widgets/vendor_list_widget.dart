import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/controllers/buyers_screen_view_model.dart';
import 'package:test_store_web/controllers/vendors_screen_view_model.dart';
import 'package:test_store_web/views/widgets/buyer_widget.dart';
import 'package:test_store_web/views/widgets/vendor_widget.dart';

class VendorListWidget extends StatelessWidget {
  const VendorListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<VendorsScreenViewModel>();
    if (vm.isloading) {
      return CircularProgressIndicator.adaptive();
    } else if (vm.error.isNotEmpty) {
      return Center(child: Text("Error ${vm.error}"));
    } else if (vm.vendorsList.isNotEmpty) {
      return ListView.builder(
        itemCount: vm.vendorsList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Provider(
              create: (_) => vm.vendorsList[index],
              child: const VendorWidget());
        },
      );
    }
    return Container();
  }
}
