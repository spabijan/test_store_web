import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/models/category/category_view_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CategoryViewModel>();
    return Column(children: [
      Image.network(vm.image, height: 100, width: 100),
      Text(vm.name),
    ]);
  }
}
