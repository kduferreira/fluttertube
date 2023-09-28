import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/models/video.dart';


class VideoTile extends StatelessWidget {

  final Video video;
  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
        initialVideoId: video.id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,

        )
    );

    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,

              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),

              onReady: () {
                print("estou pronto");
              },
            ),

            /*AspectRatio(
                aspectRatio: 16.0/9.0,
                child: Image.network(video.thumb, fit: BoxFit.cover,)
            ), */
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          style: const TextStyle(color: Colors.black,fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          video.channel,
                          style: const TextStyle(color: Colors.black,fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                  stream: bloc.outFav,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return IconButton(
                        icon: Icon(snapshot.data!.containsKey(video.id) ?
                        Icons.star : Icons.star_border),
                        color: Colors.black,
                        iconSize: 30,
                        onPressed: (){
                          bloc.toggleFavorite(video);
                        },
                      );
                    }else{
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
