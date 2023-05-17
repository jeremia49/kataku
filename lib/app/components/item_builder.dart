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
  final bool withoutAdd;
  const ImageButtonItemBuilder(this.category, this.data,
      {super.key, this.withoutAdd = false});

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
            return ImageClassExtended(
              widget.category,
              widget.data[index].namaItem,
              widget.data[index].gambarItem,
              isFromAsset: true,
              audioSrcItem: widget.data[index].audioSrcItem,
            );
          }
          if (index < widget.data.length + userAdd.length) {
            return ImageClassExtended(
              widget.category,
              userAdd[index - widget.data.length].keys.first,
              userAdd[index - widget.data.length].values.first,
              isFromAsset: false,
            );
          }
          return AddImageButton(widget.category, userAdd, () {
            setState(() {});
          });
        },
        itemCount: () {
          if (widget.withoutAdd) {
            return widget.data.length;
          }
          return widget.data.length + userAdd.length + 1;
        }());
  }
}

class AddImageButton extends StatefulWidget {
  final Function onSuccess;
  final String category;
  List<Map<String, String>> userAdd;

  AddImageButton(this.category, this.userAdd, this.onSuccess, {super.key});

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

            widget.onSuccess();
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

class ImageClassExtended extends StatefulWidget {
  final String category;
  final String namaItem;
  final String gambarItem;
  final String audioSrcItem;
  final bool isFromAsset;

  const ImageClassExtended(
    this.category,
    this.namaItem,
    this.gambarItem, {
    super.key,
    this.isFromAsset = false,
    this.audioSrcItem = "",
  });

  @override
  State<ImageClassExtended> createState() => _ImageClassExtendedState();
}

class _ImageClassExtendedState extends State<ImageClassExtended> {
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
    // prefs!.setString('user-${widget.category}', encodedMap);
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
          onTap: () async {
            if (prefImage == null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowItemImage(
                    widget.namaItem,
                    widget.gambarItem,
                    audioSrcItem: widget.audioSrcItem,
                    isFromAsset: widget.isFromAsset,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowItemImage(
                    widget.namaItem,
                    prefImage!,
                    audioSrcItem: widget.audioSrcItem,
                    isFromAsset: false,
                  ),
                ),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: () {
              if (prefImage == null) {
                if (widget.isFromAsset) {
                  return Image.asset(
                    widget.gambarItem,
                  );
                }
                return Image.file(
                  File(widget.gambarItem),
                );
              }
              return Image.file(
                File(prefImage!),
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
