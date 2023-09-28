import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String globalId = "";
class AboutTopic extends StatefulWidget {
  final String id;

  AboutTopic({required this.id}){
    globalId = this.id;
  }

  @override
  _AboutTopicState createState() => _AboutTopicState();
}

class _AboutTopicState extends State<AboutTopic> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId:
      globalId,
      flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: true,
          loop: false,
          enableCaption: false),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('About'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
      ),

      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        bottomActions: <Widget>[
          const SizedBox(width: 14.0),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
        ],
        aspectRatio: 4 / 3,
        progressIndicatorColor: Colors.white,
        onReady: () {
          print('Player is ready.');
        },
      ),
    );
  }
}
