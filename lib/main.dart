import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final player = AudioPlayer();
  bool isPlaynig = true;
  Duration duration = Duration.zero;
  Duration postion = Duration.zero;
  late StreamSubscription<Duration> possitonSupscreption;
  late StreamSubscription<Duration> durationSupscreption;
  late StreamSubscription<PlayerState> onchengedSupscreption;

  @override
  void initState() {
    super.initState();
    player.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });
    player.onPositionChanged.listen((p) {
      setState(() {
        postion = p;
      });
    });

    player.onPlayerStateChanged.listen((event) {
      isPlaynig = (event == PlayerState.playing);
    });
  }

  @override
  void disposed() {
    possitonSupscreption.cancel();
    durationSupscreption.cancel();
    possitonSupscreption.cancel();
    player.dispose();
    super.dispose();
  }

  Future<void> audioPlay({required String url}) async {
    await player.play(UrlSource(url));
  }

  Future<void> audioPause() async {
    await player.pause();
  }

  Future<void> audioStop() async {
    await player.stop();
  }

  Future<void> seekPlayer({required Duration postion}) async {
    await player.seek(postion);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Widget build(BuildContext context) {
    final maxduration = duration.inSeconds.toDouble();
    final double curentPosstion = postion.inSeconds.toDouble().clamp(
      0,
      maxduration > 0 ? maxduration : 0,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 150),
            Slider(
              min: 0,
              max: maxduration,
              value: curentPosstion,
              onChanged: (value) {
                seekPlayer(postion: Duration(seconds: value.toInt()));
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${formatTime(postion)}'),
                  Text('${formatTime(duration)}'),
                ],
              ),
            ),
            SizedBox(height: 100),
            IconButton(
              icon: Icon(isPlaynig ? Icons.play_arrow : Icons.pause_sharp),
              style: IconButton.styleFrom(
                backgroundColor: isPlaynig ? Colors.deepOrangeAccent : null,
              ),
              // color: isPlaynig ? Colors.deepOrangeAccent : null,
              focusColor: isPlaynig ? Colors.deepOrangeAccent : null,
              isSelected: isPlaynig ? true : false,
              onPressed: () {
                isPlaynig
                    ? audioPause()
                    : audioPlay(
                        url:
                            'https://cdn.mp3quran.net/audio/maher-muaiqly/r1/001.mp3',
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
