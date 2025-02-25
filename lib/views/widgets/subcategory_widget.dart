import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/models/subcategory/subcategory_view_model.dart';

class SubcategoryWidget extends StatelessWidget {
  const SubcategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<SubcategoryViewModel>();
    return Column(children: [
      Image.network(vm.categoryImage, height: 100, width: 100),
      Text(vm.categoryName),
      Text(vm.subcategoryName),
    ]);
  }
}
