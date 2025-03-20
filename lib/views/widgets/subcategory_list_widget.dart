import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/controllers/subcategory_screen_view_model.dart';
import 'package:test_store_web/views/widgets/subcategory_widget.dart';

class SubcategoryListWidget extends StatelessWidget {
  const SubcategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<SubcategoryScreenViewModel>();

    if (vm.isLoading) {
      return const CircularProgressIndicator.adaptive();
    } else if (vm.error.isNotEmpty) {
      return Center(
          child: Text('Error while loading subcategories: ${vm.error}'));
    } else if (vm.subcategories.isEmpty) {
      return const Center(child: Text('No subcategories'));
    }
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 8),
      itemCount: vm.subcategories.length,
      itemBuilder: (BuildContext context, int index) => Provider(
          create: (_) => vm.subcategories[index],
          child: const SubcategoryWidget()),
    );
  }
}
