import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/controllers/orders_screen_view_model.dart';
import 'package:test_store_web/views/widgets/header_row.dart';
import 'package:test_store_web/views/widgets/orders_list_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static const String routeName = '/ordersscreen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrdersScreenViewModel>(context, listen: false).loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text('Manage orders',
                  style: GoogleFonts.montserrat(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                HeaderRow(flex: 1, text: 'Product Image'),
                HeaderRow(flex: 2, text: 'Product Name'),
                HeaderRow(flex: 1, text: 'Product Price'),
                HeaderRow(flex: 2, text: 'Product Category'),
                HeaderRow(flex: 3, text: 'Buyer Name'),
                HeaderRow(flex: 2, text: 'Buyer Email'),
                HeaderRow(flex: 3, text: 'Delivery Address'),
                HeaderRow(flex: 1, text: 'Status'),
              ],
            ),
            const OrdersListWidget()
          ],
        ),
      ),
    );
  }
}
