import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'package:fluttertube/delegates/data_search.dart';
import 'package:fluttertube/models/video.dart';
import 'package:fluttertube/screens/favorites.dart';
import 'package:fluttertube/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<VideosBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SizedBox(
          height: 120,
          child: Image.asset("images/youtube.png"),
        ),
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2)),
        elevation: 10,
        backgroundColor: Colors.white,
        actions: [
          Align(
              alignment: Alignment.center,
              child: StreamBuilder<Map<String, Video>>(
                  stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '${snapshot.data!.length}',
                        style: const TextStyle(color: Colors.black),
                      );
                    } else {
                      return Container();
                    }
                  })),
          IconButton(
            onPressed: () {
              //Favoritos
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=> Favorites())
              );
            },
            icon: const Icon(Icons.star),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () async {
              /*showSearch mostra uma página de pesquisa em tela cheia e retorna o resultado da pesquisa selecionado pelo usuário quando a página é fechada.*/
              String? result =
              await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                bloc.inSearch.add(result);
              }
            },
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.outVideos,
        //initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data as List<Video>;
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index < list.length) {
                  return VideoTile(list[index]);
                } else if (index > 1) {
                  bloc.inSearch.add('');
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: list.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
