import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class ImageWithEdit extends StatefulWidget {
  final String category;
  final String namaItem;
  final String gambarItem;
  final bool isFromAsset;
  final double width;

  const ImageWithEdit(
    this.category,
    this.namaItem,
    this.gambarItem, {
    super.key,
    this.isFromAsset = false,
    this.width = 1.0,
  });

  @override
  State<ImageWithEdit> createState() => _ImageWithEditState();
}

class _ImageWithEditState extends State<ImageWithEdit> {
  final ImagePicker _picker = ImagePicker();
  SharedPreferences? prefs;
  String? prefImage;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
    prefImage = prefs!.getString('user-${widget.category}-${widget.namaItem}');
    if (prefImage == null) return;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        child: InkWell(
          onLongPress: () async {
            final String? imagePath =
                await pickImage(context, ImageSource.camera);
            if (imagePath == null) return;
            prefs?.setString(
                'user-${widget.category}-${widget.namaItem}', imagePath);
            prefImage = imagePath;
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: () {
              if (prefImage == null) {
                if (widget.isFromAsset) {
                  return Image.asset(
                    widget.gambarItem,
                    width: MediaQuery.of(context).size.width * widget.width,
                  );
                }
                return Image.file(
                  File(widget.gambarItem),
                  width: MediaQuery.of(context).size.width * widget.width,
                );
              }
              return Image.file(
                File(prefImage!),
                width: MediaQuery.of(context).size.width * widget.width,
              );
            }(),
          ),
        ),
      ),
    );
  }

  Future<String?> pickImage(BuildContext ctx, ImageSource imageSource) async {
    try {
      final XFile? image = await _picker.pickImage(source: imageSource);
      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menerima file'),
          ),
        );
        return null;
      }
      var uuid = Uuid();
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      File imageTarget = File(
          "${appDocumentsDir.path}/${widget.category}-${uuid.v4()}${p.extension(image.path)}");
      await File(image.path).copy(imageTarget.path);
      return imageTarget.path;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menyimpan file'),
        ),
      );
      return null;
    }
  }
}
