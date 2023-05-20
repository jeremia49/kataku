import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class AddBTNImage extends StatefulWidget {
  final String itemName;

  AddBTNImage(
    this.itemName, {
    super.key,
  });

  @override
  State<AddBTNImage> createState() {
    return _AddBTNImageState();
  }
}

class _AddBTNImageState extends State<AddBTNImage> {
  File? targetImage;
  SharedPreferences? prefs;
  final ImagePicker _picker = ImagePicker();

  Future<void> checkImage() async {
    prefs ??= await SharedPreferences.getInstance();
    final filename = prefs!.getString("image-${widget.itemName}") ?? "";
    if (filename == "") return;

    final imageTarget = File(filename);
    if (await imageTarget.exists()) {
      setState(() {
        targetImage = imageTarget;
      });
    } else {
      setState(() {
        targetImage = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkImage();
  }

  Future<void> pickImage(BuildContext ctx, ImageSource imageSource) async {
    try {
      final XFile? image = await _picker.pickImage(source: imageSource);
      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menerima file'),
          ),
        );
        return;
      }
      var uuid = Uuid();
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      File imageTarget = File(
          "${appDocumentsDir.path}/${widget.itemName}-${uuid.v4()}${p.extension(image.path)}");
      prefs!.setString("image-${widget.itemName}", imageTarget.path);
      await File(image.path).copy(imageTarget.path);
      setState(() {
        targetImage = File(imageTarget.path);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menyimpan file'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 225, 219, 137),
            width: 4.0,
          ),
          shape: BoxShape.rectangle,
        ),
        child: InkWell(
          onTap: () async {
            return showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.photo),
                      title: Text("Pilih dari Galeri"),
                      onTap: () async {
                        if (!context.mounted) return;
                        await pickImage(context, ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                        leading: Icon(Icons.camera),
                        title: Text("Ambil dengan Kamera"),
                        onTap: () async {
                          if (!context.mounted) return;
                          await pickImage(context, ImageSource.camera);
                          Navigator.of(context).pop();
                        }),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: targetImage != null
                ? Image.file(
                    targetImage!,
                    width: MediaQuery.of(context).size.width * 0.3,
                  )
                : Image.asset(
                    "assets/images/add_btn.png",
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
          ),
        ),
      ),
    );
  }
}
