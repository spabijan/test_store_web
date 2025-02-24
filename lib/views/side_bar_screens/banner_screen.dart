import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_web/controllers/banners_screen_view_model.dart';
import 'package:test_store_web/errors/http_error.dart';
import 'package:test_store_web/views/widgets/banner_list_widget.dart';
import 'package:test_store_web/views/widgets/pick_image_widget.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});
  static const String routeName = '/bannerscreen';

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  dynamic _banner;
  dynamic get getBanner => _banner;

  @override
  void initState() {
    super.initState();
    _loadBannersOnState();
  }

  void _loadBannersOnState() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BannersScreenViewModel>(context, listen: false).loadBanners();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSending =
        context.select((BannersScreenViewModel bannerVM) => bannerVM.isSending);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Text('Baners',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            Divider(color: Colors.grey),
            Row(
              spacing: 16,
              children: [
                PickImageWidget(
                    textDecoration: 'Banner',
                    imageByteData: getBanner,
                    onPickImage: (image) => setState(() => _banner = image)),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: _onUploadBanner,
                    child: isSending
                        ? CircularProgressIndicator.adaptive()
                        : Text('Save', style: TextStyle(color: Colors.white))),
              ],
            ),
            Divider(color: Colors.grey),
            BannerListWidget()
          ],
        ),
      ),
    );
  }

  _onUploadBanner() async {
    try {
      await Provider.of<BannersScreenViewModel>(context, listen: false)
          .uploadBanner(pickedImage: _banner);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Uploaded banner')));
      }
    } on HttpError catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      setState(() => _banner = null);
    }
  }
}
