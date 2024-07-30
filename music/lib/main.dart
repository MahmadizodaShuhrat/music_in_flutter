import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart' as audioplayers;
import 'package:just_audio/just_audio.dart' as just_audio;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audio Player Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AudioPlayerScreen(),
    );
  }
}

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late just_audio.AudioPlayer _justAudioPlayer;
  late audioplayers.AudioPlayer _audioplayersPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _justAudioPlayer = just_audio.AudioPlayer();
    _audioplayersPlayer = audioplayers.AudioPlayer();
    _justAudioPlayer.setAsset('assets/AUDIO-2023-02-28-07-11-49.mp3');
  }

  Future<void> _playAudio() async {
    try {
      await _audioplayersPlayer.play(audioplayers.AssetSource('AUDIO-2023-02-28-07-11-49.mp3'));
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> _pauseAudio() async {
    try {
      await _audioplayersPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } catch (e) {
      print("Error pausing audio: $e");
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _audioplayersPlayer.stop();
      setState(() {
        isPlaying = false;
      });
    } catch (e) {
      print("Error stopping audio: $e");
    }
  }

  @override
  void dispose() {
    _justAudioPlayer.dispose();
    _audioplayersPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isPlaying ? _pauseAudio : _playAudio,
              child: Text(isPlaying ? 'Pause Audio' : 'Play Audio'),
            ),
            ElevatedButton(
              onPressed: _stopAudio,
              child: Text('Stop Audio'),
            ),
          ],
        ),
      ),
    );
  }
}
