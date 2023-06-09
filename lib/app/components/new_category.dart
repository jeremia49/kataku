import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:path/path.dart' as p;

class AddCategoryButton extends StatefulWidget {
  final Function onSuccess;
  List<Map<String, String>> userAdd;

  AddCategoryButton(this.userAdd, this.onSuccess, {super.key});

  @override
  State<AddCategoryButton> createState() => _AddCategoryButtonState();
}

class _AddCategoryButtonState extends State<AddCategoryButton> {
  final TextEditingController _textFieldController = TextEditingController();
  String valueText = "";
  String codeDialog = "";
  final ImagePicker _picker = ImagePicker();
  SharedPreferences? prefs;

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Masukkan nama Kategori'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Nama Kategori"),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('Batal'),
              onPressed: () {
                setState(() {
                  _textFieldController.text = "";
                  codeDialog = "";
                  Navigator.pop(context);
                });
              },
            ),
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: const Text('Ok'),
              onPressed: () {
                setState(() {
                  codeDialog = valueText;
                  _textFieldController.text = "";
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        child: InkWell(
          onTap: () async {
            await _displayTextInputDialog(context);
            if (codeDialog.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Operasi dibatalkan'),
                  duration: Duration(seconds: 1),
                ),
              );
              return;
            }
            final String? imagePath =
                await pickImage(context, ImageSource.camera);
            if (imagePath == null) return;

            final Map<String, String> array = {codeDialog: imagePath};
            widget.userAdd.add(array);

            String encodedMap = json.encode(widget.userAdd.toList());
            prefs!.setString('category', encodedMap);

            widget.onSuccess();
          },
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Image.asset("assets/images/add_btn.png"),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
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
      var uuid = const Uuid();
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      File imageTarget = File(
          "${appDocumentsDir.path}/category-${uuid.v4()}${p.extension(image.path)}");
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

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }
}
