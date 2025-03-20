import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/controllers/orders_screen_view_model.dart';
import 'package:test_store_web/models/order/order_view_model.dart';
import 'package:test_store_web/views/widgets/header_row.dart';

class OrdersListWidget extends StatelessWidget {
  const OrdersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var order = context.watch<OrdersScreenViewModel>();
    if (order.isLoading) {
      return const CircularProgressIndicator.adaptive();
    } else if (order.error.isNotEmpty) {
      return Center(
          child: Text('Error while loading categories: ${order.error}'));
    } else if (order.orderList.isEmpty) {
      return const Center(child: Text('No categories'));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: order.orderList.length,
      itemBuilder: (BuildContext context, int index) => Provider(
          create: (_) => order.orderList[index],
          child: const OrderListItemWiget()),
    );
  }
}

class OrderListItemWiget extends StatelessWidget {
  const OrderListItemWiget({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<OrderViewModel>();
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExpandableTableRow(
              flex: 1, widget: Image.network(vm.image, width: 50, height: 50)),
          ExpandableTableRow(
              flex: 2,
              widget: Text(vm.productName,
                  style: GoogleFonts.montserrat(
                      color: Colors.black, fontSize: 16))),
          ExpandableTableRow(
              flex: 1,
              widget: Text('\$${vm.productPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(
                      color: Colors.black, fontSize: 16))),
          ExpandableTableRow(
              flex: 2,
              widget: Text(vm.category,
                  style: GoogleFonts.montserrat(
                      color: Colors.black, fontSize: 16))),
          ExpandableTableRow(
              flex: 3,
              widget: Text(vm.buyerFullName,
                  style: GoogleFonts.montserrat(
                      color: Colors.black, fontSize: 16))),
          ExpandableTableRow(
              flex: 2,
              widget: Text(vm.buyerAddress,
                  style: GoogleFonts.montserrat(
                      color: Colors.black, fontSize: 16))),
          ExpandableTableRow(
              flex: 3,
              widget: Text(vm.delivaryAddress,
                  style: GoogleFonts.montserrat(
                      color: Colors.black, fontSize: 16))),
          ExpandableTableRow(
              flex: 1,
              widget: Text(_getStatus(vm),
                  style: GoogleFonts.montserrat(
                      color: Colors.black, fontSize: 16))),
        ]);
  }

  String _getStatus(OrderViewModel order) {
    if (order.delivered) {
      return 'delivered';
    } else if (order.processing) {
      return 'processing';
    }
    return 'cancelled';
  }
}
