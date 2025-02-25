import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/models/banner/banner_view_model.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<BannerViewModel>();
    return Image.network(vm.image, width: 100, height: 100);
  }
}
