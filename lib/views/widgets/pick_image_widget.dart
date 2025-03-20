import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget(
      {required this.textDecoration, required this.onPickImage, super.key,
      this.imageByteData});

  final String textDecoration;
  final dynamic imageByteData;
  final void Function(dynamic image) onPickImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: imageByteData != null
                  ? Image.memory(imageByteData)
                  : Text(textDecoration)),
        ),
        ElevatedButton(
          onPressed: () => _pickImage(onPickImage: onPickImage),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text('Pick Image', style: TextStyle(color: Colors.white)),
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
}
