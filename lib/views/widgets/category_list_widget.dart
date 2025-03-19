import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/controllers/category_screen_view_model.dart';
import 'package:test_store_web/views/widgets/category_widget.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CategoryScreenViewModel>();

    if (vm.isLoading) {
      return CircularProgressIndicator.adaptive();
    } else if (vm.error.isNotEmpty) {
      return Center(child: Text('Error while loading categories: ${vm.error}'));
    } else if (vm.categoriesList.isEmpty) {
      return Center(child: Text('No categories'));
    }
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 8),
      itemCount: vm.categoriesList.length,
      itemBuilder: (BuildContext context, int index) => Provider(
          create: (_) => vm.categoriesList[index],
          child: const CategoryWidget()),
    );
  }
}
