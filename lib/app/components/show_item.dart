import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart' as au;
import 'package:kataku/app/components/image_with_edit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
import 'package:record/record.dart';

class ShowItemImage extends StatefulWidget {
  final String namaItem;
  final String gambarItem;
  final String audioSrcItem;
  final bool isFromAsset;
  final String category;

  const ShowItemImage(this.namaItem, this.category, this.gambarItem,
      {super.key, this.audioSrcItem = "", this.isFromAsset = true});

  @override
  State<ShowItemImage> createState() => _ShowItemImageState();
}

class _ShowItemImageState extends State<ShowItemImage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    if (!await Permission.microphone.request().isGranted) {
      await Permission.microphone.request();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Akses mikrophone diperlukan!'),
        ),
      );
      return;
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt < 33) {
      if (!await Permission.storage.request().isGranted) {
        if (await Permission.storage.request() != PermissionStatus.granted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Akses storage diperlukan!'),
            ),
          );
        }
        return;
      }
    }
  }

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
                      widget.category,
                      widget.namaItem,
                      widget.gambarItem,
                      isFromAsset: widget.isFromAsset,
                      width: 0.7,
                    );
                  }(),
                  SizedBox(
                    height: 40,
                  ),
                  secondText(
                    category: widget.category,
                    namaItem: widget.namaItem,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  AudioPlayer(
                    widget.category,
                    widget.namaItem,
                    widget.audioSrcItem,
                  ),
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
          textAlign: TextAlign.center,
          softWrap: true,
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
  final record = Record();
  IconData ic = Icons.volume_up_rounded;
  SharedPreferences? prefs;
  String? prefSound;
  bool isRecording = false;

  Future<void> pickAudio(BuildContext context, {bool isRecord = false}) async {
    if (isRecord) {
      if (await record.hasPermission()) {
        var uuid = Uuid();
        final Directory appDocumentsDir =
            await getApplicationDocumentsDirectory();
        File audioTarget =
            File("${appDocumentsDir.path}/${widget.category}-${uuid.v4()}.wav");
        await prefs!.setString(
            'audio-${widget.category}-${widget.namaItem}', audioTarget.path);
        prefSound = audioTarget.path;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rekaman dimulai'),
          ),
        );
        setState(() {
          ic = Icons.stop;
          isRecording = true;
        });
        await record.start(
          path: audioTarget.path,
          encoder: AudioEncoder.wav,
          bitRate: 128000,
          samplingRate: 44100,
        );
        return;
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );
      // print(result);
      if (result != null) {
        PlatformFile file = result.files.first;
        try {
          var uuid = Uuid();
          final Directory appDocumentsDir =
              await getApplicationDocumentsDirectory();
          File audioTarget = File(
              "${appDocumentsDir.path}/${widget.category}-${uuid.v4()}${file.extension}");
          await File(file.path!).copy(audioTarget.path);
          await prefs!.setString(
              'audio-${widget.category}-${widget.namaItem}', audioTarget.path);
          prefSound = audioTarget.path;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () async {
        if (isRecording) {
          return;
        }
        return showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text("Pilih dari File"),
                  onTap: () async {
                    if (!context.mounted) return;
                    await pickAudio(context, isRecord: false);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                    leading: Icon(Icons.mic),
                    title: Text("Rekam Suara"),
                    onTap: () async {
                      if (!context.mounted) return;
                      await pickAudio(context, isRecord: true);
                      Navigator.of(context).pop();
                    }),
              ],
            );
          },
        );
      },
      onTap: () async {
        if (isRecording) {
          await record.stop();
          setState(() {
            isRecording = false;
            ic = Icons.volume_up_rounded;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File berhasil disimpan'),
            ),
          );
          return;
        }
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
    prefSound = prefs!.getString('audio-${widget.category}-${widget.namaItem}');
    if (prefSound == null) return;
    setState(() {});
  }

  @override
  void dispose() async {
    player.stop();
    record.dispose();
    super.dispose();
  }
}
