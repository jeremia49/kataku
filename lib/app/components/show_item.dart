import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart' as au;
import 'package:kataku/app/components/image_with_edit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class ShowItemImage extends StatelessWidget {
  final String namaItem;
  final String gambarItem;
  final String audioSrcItem;
  final bool isFromAsset;
  final String category;

  const ShowItemImage(this.namaItem, this.category, this.gambarItem,
      {super.key, this.audioSrcItem = "", this.isFromAsset = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset("assets/images/bg_base.jpg"),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 50,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  () {
                    return ImageWithEdit(
                      category,
                      namaItem,
                      gambarItem,
                      isFromAsset: isFromAsset,
                      width: 0.7,
                    );
                    // if (isFromAsset) {
                    //   return Image.asset(
                    //     gambarItem,
                    //     width: MediaQuery.of(context).size.width * 0.7,
                    //   );
                    // }
                    // return Image.file(
                    //   File(gambarItem),
                    //   width: MediaQuery.of(context).size.width * 0.7,
                    // );
                  }(),
                  SizedBox(
                    height: 40,
                  ),
                  secondText(category: category, namaItem: namaItem),
                  SizedBox(
                    height: 40,
                  ),
                  AudioPlayer(category, namaItem, audioSrcItem),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Image.asset("assets/images/home_btn.png"),
              iconSize: 50,
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 255, 246, 129),
    );
  }
}

class secondText extends StatefulWidget {
  const secondText({
    super.key,
    required this.namaItem,
    required this.category,
  });

  final String namaItem;
  final String category;

  @override
  State<secondText> createState() => _secondTextState();
}

class _secondTextState extends State<secondText> {
  final TextEditingController _textFieldController = TextEditingController();
  SharedPreferences? prefs;
  String valueText = "";
  String codeDialog = "";
  String? prefText;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
    prefText =
        prefs!.getString('secondText-${widget.category}-${widget.namaItem}');
    setState(() {});
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Masukkan Nama Baru'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Nama Baru"),
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
    return Ink(
      child: InkWell(
        onLongPress: () async {
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

          await prefs!.setString(
              'secondText-${widget.category}-${widget.namaItem}', codeDialog);
          setState(() {
            prefText = codeDialog;
          });
        },
        child: Text(
          () {
            if (prefText != null) {
              return prefText!;
            }
            return widget.namaItem;
          }(),
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}

class AudioPlayer extends StatefulWidget {
  final String src;
  final String category;
  final String namaItem;

  const AudioPlayer(this.category, this.namaItem, this.src, {super.key});

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  final player = au.AudioPlayer();
  IconData ic = Icons.volume_up_rounded;
  SharedPreferences? prefs;
  String? prefSound;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () async {
        setState(() {
          ic = Icons.mic;
        });
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.audio,
        );
        if (result != null) {
          PlatformFile file = result.files.first;
          try {
            var uuid = Uuid();
            final Directory appDocumentsDir =
                await getApplicationDocumentsDirectory();
            File imageTarget = File(
                "${appDocumentsDir.path}/${widget.category}-${uuid.v4()}${file.extension}");
            await File(file.path!).copy(imageTarget.path);
            await prefs!.setString(
                'audio-${widget.category}-${widget.namaItem}',
                imageTarget.path);
            prefSound = imageTarget.path;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('File berhasil disimpan'),
              ),
            );
            setState(() {});
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gagal menyimpan file'),
              ),
            );
          }
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Operasi dibatalkan !'),
            duration: Duration(seconds: 1),
          ),
        );
        return;
      },
      onTap: () async {
        if ((prefSound == null || prefSound!.isEmpty) && widget.src.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File tidak ada !'),
              duration: Duration(seconds: 1),
            ),
          );
          return;
        }
        await player.stop();
        if (prefSound == null || prefSound!.isEmpty) {
          await player.play(
            au.AssetSource(widget.src),
            position: const Duration(milliseconds: 0),
          );
        } else {
          await player.play(
            au.DeviceFileSource(prefSound!),
            position: const Duration(milliseconds: 0),
          );
        }
      },
      child: Icon(
        ic,
        size: 100,
      ),
    );
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
    // await player.setSource(au.AssetSource(widget.src));

    if (await Permission.storage.isGranted) {
    } else if (!(await Permission.storage.isPermanentlyDenied)) {
      final status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
      } else {
        openAppSettings();
      }
    } else {
      openAppSettings();
    }

    prefSound = prefs!.getString('audio-${widget.category}-${widget.namaItem}');
    if (prefSound == null) return;
    setState(() {});
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }
}
