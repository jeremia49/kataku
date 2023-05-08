import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class AddBTNImage extends StatefulWidget {
  File? targetImage;
  final String itemName;
  final String defaultImage = "assets/images/add_btn.png";
  final ImagePicker _picker = ImagePicker();
  String? name;
  SharedPreferences? prefs;

  AddBTNImage(
    this.itemName, {
    super.key,
    this.prefs,
  });

  @override
  State<AddBTNImage> createState() {
    return _AddBTNImageState();
  }
}

class _AddBTNImageState extends State<AddBTNImage> {
  Future<void> checkImage() async {
    widget.prefs ??= await SharedPreferences.getInstance();
    final filename = widget.prefs!.getString(widget.itemName) ?? "";
    if (filename == "") return;

    final imageTarget = File(filename);
    if (await imageTarget.exists()) {
      setState(() {
        widget.targetImage = imageTarget;
      });
    } else {
      setState(() {
        widget.targetImage = null;
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
      final XFile? image = await widget._picker.pickImage(source: imageSource);
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
      widget.prefs!.setString(widget.itemName, imageTarget.path);
      File(image.path).copy(imageTarget.path);
      setState(() {
        widget.targetImage = File(imageTarget.path);
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
                            await pickImage(context, ImageSource.camera);
                            Navigator.of(context).pop();
                          }),
                    ],
                  );
                });
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: widget.targetImage != null
                ? Image.file(
                    widget.targetImage!,
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
