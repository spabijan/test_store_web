import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/controllers/category_screen_view_model.dart';
import 'package:test_store_web/errors/http_error.dart';
import 'package:test_store_web/views/widgets/category_list_widget.dart';
import 'package:test_store_web/views/widgets/pick_image_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static const String routeName = '/categoryscreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  dynamic _image;
  dynamic _banner;
  late String _categoryName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryScreenViewModel>(context, listen: false)
          .loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSending =
        context.select((CategoryScreenViewModel vm) => vm.isSending);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text('Categories',
                    style:
                        TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(color: Colors.grey),
              ),
              Row(
                spacing: 16,
                children: [
                  PickImageWidget(
                      textDecoration: 'Category image',
                      imageByteData: getImage,
                      onPickImage: (image) => setState(() => _image = image)),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) => _categoryName = value,
                      validator: _validateNewCategoryName,
                      decoration:
                          const InputDecoration(labelText: 'Enter Category Name'),
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Cancel')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: _onFormSubmit,
                      child: isSending
                          ? const CircularProgressIndicator.adaptive()
                          : const Text('Save',
                              style: TextStyle(color: Colors.white))),
                ],
              ),
              const Divider(color: Colors.grey),
              PickImageWidget(
                  textDecoration: 'Category banner',
                  imageByteData: getBanner,
                  onPickImage: (image) => setState(() => _banner = image)),
              const Divider(color: Colors.grey),
              const CategoryListWidget()
            ],
          ),
        ),
      ),
    );
  }

  // those getters are needen to prevent anomaly, then _banner is not null, but
  // _pickImageComponent still has null value in imageField
  // instead - send reference to getter
  dynamic get getBanner => _banner;
  dynamic get getImage => _image;

  void _onFormSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        await Provider.of<CategoryScreenViewModel>(context, listen: false)
            .uploadCategory(
                pickedImage: _image,
                pickedBanner: _banner,
                name: _categoryName,
                context: context);
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Uploaded category')));
        }
      } on HttpError catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
  }

  String? _validateNewCategoryName(value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return 'Please enter category name';
    }
  }
}
