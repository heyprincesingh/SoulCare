// ignore_for_file: unused_field

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulcare/models/color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class youtubeVideoScreen extends StatefulWidget {
  const youtubeVideoScreen({super.key});
  @override
  _MyyoutubeVideoScreen createState() => _MyyoutubeVideoScreen();
}

class _MyyoutubeVideoScreen extends State<youtubeVideoScreen> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> videoList = [
    "WO4tIrjBDkk",
    "BOksW_NabEk",
    "qM-gZintWDc",
    "qX9FSZJu448",
    "9Z2DFhF6ICE",
    "eAK14VoY7C0",
    "k-ov9XZzByA",
    "Y9FEQYp1imc"
  ];

  @override
  void initState() {
    super.initState();
    final random = Random();
    _controller = YoutubePlayerController(
      initialVideoId: videoList[random.nextInt(videoList.length)].toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        liveUIColor: Colors.red,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {},
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: themeColor,
          title: Text(
            "Motivation Video",
            style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Container(
          color: bgColor,
          child: ListView(
            children: [
              player,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _space,
                    _text('Title', _videoMetaData.title),
                    _space,
                    _text('Channel', _videoMetaData.author),
                    _space,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous,color: Colors.white),
                          onPressed: (){},
                        ),
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,color: Colors.white
                          ),
                          onPressed: _isPlayerReady
                              ? () {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                            setState(() {});
                          }
                              : null,
                        ),
                        IconButton(
                          icon: Icon(_muted ? Icons.volume_off : Icons.volume_up,color: Colors.white),
                          onPressed: _isPlayerReady
                              ? () {
                            _muted
                                ? _controller.unMute()
                                : _controller.mute();
                            setState(() {
                              _muted = !_muted;
                            });
                          }
                              : null,
                        ),
                        FullScreenButton(
                          controller: _controller,
                          color: Colors.white,
                        ),
                        IconButton(
                            icon: const Icon(Icons.skip_next,color: Colors.white),
                            onPressed: (){}
                        ),
                      ],
                    ),
                    _space,
                    Row(
                      children: <Widget>[
                        const Text(
                          "Volume",
                          style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            inactiveColor: Colors.transparent,
                            value: _volume,
                            min: 0.0,
                            max: 100.0,
                            divisions: 10,
                            activeColor: Colors.white,
                            label: '${(_volume).round()}',
                            onChanged: _isPlayerReady
                                ? (value) {
                              setState(() {
                                _volume = value;
                              });
                              _controller.setVolume(_volume.round());
                            }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _space => const SizedBox(height: 10);

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.grey,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
