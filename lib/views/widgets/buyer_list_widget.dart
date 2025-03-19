import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/controllers/buyers_screen_view_model.dart';
import 'package:test_store_web/views/widgets/buyer_widget.dart';

class BuyerListWidget extends StatelessWidget {
  const BuyerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<BuyersScreenViewModel>();
    if (vm.isloading) {
      return CircularProgressIndicator.adaptive();
    } else if (vm.error.isNotEmpty) {
      return Center(child: Text("Error ${vm.error}"));
    } else if (vm.userList.isNotEmpty) {
      return ListView.builder(
        itemCount: vm.userList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Provider(
              create: (_) => vm.userList[index], child: const BuyerWidget());
        },
      );
    }
    return Center(child: Text('No users'));
  }
}
