import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/controllers/category_screen_view_model.dart';
import 'package:test_store_web/controllers/subcategory_screen_view_model.dart';
import 'package:test_store_web/models/category/category.dart';
import 'package:test_store_web/models/category/category_view_model.dart';
import 'package:test_store_web/views/widgets/pick_image_widget.dart';
import 'package:test_store_web/views/widgets/subcategory_list_widget.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String routeName = '/subcategoryscreen';
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryScreenViewModel>(context, listen: false)
          .loadCategories();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SubcategoryScreenViewModel>(context, listen: false)
          .loadsubCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    var categoriesVM = context.watch<CategoryScreenViewModel>();
    var vm = context.watch<SubcategoryScreenViewModel>();
    return Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('Subcategories',
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                ),
                if (categoriesVM.isLoading)
                  Center(child: CircularProgressIndicator.adaptive())
                else if (categoriesVM.error.isNotEmpty)
                  Center(child: Text('Error :${categoriesVM.error}'))
                else if (categoriesVM.categoriesList.isEmpty)
                  Center(child: Text('No categories'))
                else
                  DropdownButtonFormField<CategoryViewModel>(
                      validator: (value) {
                        if (value == null) {
                          return 'Select category';
                        }
                        return null;
                      },
                      hint: Text('Select category'),
                      items: categoriesVM.categoriesList
                          .map((element) => DropdownMenuItem(
                              value: element, child: Text(element.name)))
                          .toList(),
                      onChanged: (value) => vm.selectedCategory = value),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(color: Colors.grey),
                ),
                Row(
                  spacing: 16,
                  children: [
                    PickImageWidget(
                        textDecoration: 'Category image',
                        imageByteData: vm.image,
                        onPickImage: (image) => vm.image = image),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        onChanged: (value) => vm.subcategoryName = value,
                        validator: vm.validateNewCategoryName,
                        decoration: InputDecoration(
                            labelText: 'Enter Subcategory Name'),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Text('Cancel')),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: _onFormSubmit,
                        child: vm.isSending
                            ? CircularProgressIndicator.adaptive()
                            : Text('Save',
                                style: TextStyle(color: Colors.white))),
                  ],
                ),
                Divider(color: Colors.grey),
                if (vm.error.isNotEmpty)
                  Center(
                      child: Text(vm.error,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold))),
                SubcategoryListWidget()
              ],
            ),
          ),
        ));
  }

  void _onFormSubmit() async {
    if (_formKey.currentState!.validate()) {
      var vm = Provider.of<SubcategoryScreenViewModel>(context, listen: false);
      try {
        await vm.uploadSubcategory();
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Uploaded subcategory')));
        }
        setState(() {
          vm.reset();
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }
  }
}
