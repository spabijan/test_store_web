import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text('Categories',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: Colors.grey),
            ),
            Row(
              spacing: 16,
              children: [
                _pickImageComponent(
                    textDecoration: 'Category image',
                    imageField: getImage,
                    onPickImage: (image) => setState(() => _image = image)),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    onChanged: (value) => _categoryName = value,
                    validator: _validateNewCategoryName,
                    decoration:
                        InputDecoration(labelText: 'Enter Category Name'),
                  ),
                ),
                TextButton(onPressed: () {}, child: Text('Cancel')),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: _onFormSubmit,
                    child: Text('Save', style: TextStyle(color: Colors.white))),
              ],
            ),
            Divider(color: Colors.grey),
            _pickImageComponent(
                textDecoration: 'Category banner',
                imageField: getBanner,
                onPickImage: (image) => setState(() => _banner = image)),
          ],
        ),
      ),
    );
  }

  // those getters are needen to prevent anomaly, then _banner is not null, but
  // _pickImageComponent still has null value in imageField
  // instead - send reference to getter
  dynamic get getBanner => _banner;
  dynamic get getImage => _image;

  Column _pickImageComponent(
      {required String textDecoration,
      required dynamic imageField,
      required void Function(dynamic image) onPickImage}) {
    return Column(
      spacing: 8,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: imageField != null
                  ? Image.memory(imageField)
                  : Text(textDecoration)),
        ),
        ElevatedButton(
          onPressed: () => _pickImage(onPickImage: onPickImage),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: Text("Pick Image", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }

  void _pickImage({required void Function(dynamic image) onPickImage}) async {
    var result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      onPickImage(result.files.first.bytes);
    }
  }

  void _onFormSubmit() {
    if (_formKey.currentState!.validate()) {}
  }

  String? _validateNewCategoryName(value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return 'Please enter category name';
    }
  }
}
