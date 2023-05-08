import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart' as au;

class ShowItemImage extends StatelessWidget {
  final String namaItem;
  final String gambarItem;
  final String audioSrcItem;
  final bool isFromAsset;

  const ShowItemImage(this.namaItem, this.gambarItem,
      {super.key, this.audioSrcItem = "", this.isFromAsset = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
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
                      if (isFromAsset) {
                        return Image.asset(
                          gambarItem,
                          width: MediaQuery.of(context).size.width * 0.7,
                        );
                      }
                      return Image.file(
                        File(gambarItem),
                        width: MediaQuery.of(context).size.width * 0.7,
                      );
                    }(),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      namaItem,
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    () {
                      if (audioSrcItem != "") return AudioPlayer(audioSrcItem);
                      return const SizedBox(
                        height: 1,
                      );
                    }(),
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
      ),
      backgroundColor: Color.fromARGB(255, 255, 246, 129),
    );
  }
}

class AudioPlayer extends StatefulWidget {
  final String src;
  const AudioPlayer(this.src, {super.key});

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  final player = au.AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await player.play(
          player.source!,
          position: const Duration(milliseconds: 0),
        );
      },
      child: const Icon(
        Icons.volume_up_rounded,
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
    await player.setSource(au.AssetSource(widget.src));
  }
}
