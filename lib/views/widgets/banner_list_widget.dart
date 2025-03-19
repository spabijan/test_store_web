import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/models/banner/banner_view_model.dart';
import 'package:test_store_web/controllers/banners_screen_view_model.dart';
import 'package:test_store_web/views/widgets/banner_widget.dart';

class BannerListWidget extends StatelessWidget {
  const BannerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<BannersScreenViewModel>();
    if (vm.isloading) {
      return CircularProgressIndicator.adaptive();
    } else if (vm.error.isNotEmpty) {
      return Center(child: Text("Error ${vm.error}"));
    } else if (vm.bannerList.isNotEmpty) {
      return GridView.builder(
          shrinkWrap: true,
          itemCount: vm.bannerList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8),
          itemBuilder: (context, index) => Provider(
              create: (_) => vm.bannerList[index],
              child: const BannerWidget()));
    }
    return Center(child: Text("No banners ${vm.error}"));
  }
}
