import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kataku/app/components/show_item.dart';
import 'package:kataku/app/modules/utils/imageitem.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class ImageButtonItemBuilder extends StatefulWidget {
  final String category;
  final List<ImageItem> data;
  const ImageButtonItemBuilder(this.category, this.data, {super.key});

  @override
  State<ImageButtonItemBuilder> createState() => _ImageButtonItemBuilderState();
}

class _ImageButtonItemBuilderState extends State<ImageButtonItemBuilder> {
  SharedPreferences? prefs;
  List<Map<String, String>> userAdd = List.empty(
    growable: true,
  );

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
    // prefs!.setString('user-${widget.category}', encodedMap);
    final String? useradd = prefs!.getString('user-${widget.category}');
    if (useradd == null) return;

    final List<dynamic> listUserAdd = json.decode(useradd);
    for (var el in listUserAdd) {
      Map<String, String> map = el.cast<String, String>();
      userAdd.add(map);
    }
    setState(() {});
    // userAdd = json.decode(useradd) as List<Map<String, String>>;
    print(userAdd);
    // userAdd
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (BuildContext ctx, int index) {
        if (index < widget.data.length) {
          return Material(
            type: MaterialType.transparency,
            child: Ink(
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowItemImage(
                              widget.data[index].namaItem,
                              widget.data[index].gambarItem,
                              audioSrcItem: widget.data[index].audioSrcItem,
                            )),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Image.asset(widget.data[index].gambarItem),
                ),
              ),
            ),
          );
        }
        if (index < widget.data.length + userAdd.length) {
          print('harusnya masuk');
          return Material(
            type: MaterialType.transparency,
            child: Ink(
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowItemImage(
                              userAdd[index - widget.data.length].keys.first,
                              userAdd[index - widget.data.length].values.first,
                              isFromAsset: false,
                            )),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Image.file(
                      File(userAdd[index - widget.data.length].values.first)),
                ),
              ),
            ),
          );
        }
        return AddImageButton(widget.category, userAdd);
      },
      itemCount: widget.data.length + userAdd.length + 1,
    );
  }
}

class AddImageButton extends StatefulWidget {
  final String category;
  List<Map<String, String>> userAdd;

  AddImageButton(this.category, this.userAdd, {super.key});

  @override
  State<AddImageButton> createState() => _AddImageButtonState();
}

class _AddImageButtonState extends State<AddImageButton> {
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
          title: const Text('Masukkan nama Item'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Nama Item"),
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
            prefs!.setString('user-${widget.category}', encodedMap);

            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.all(1.0),
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

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }
}
