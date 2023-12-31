import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'screens/home.dart';

/*
  * AVISO: executar a aplicação com o comando flutter run --no-sound-null-safety -d chrome --web-renderer html
* */

void main(){
  Api api = Api();
  //api.search("eletro");
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc())
      ],
      dependencies: [],
      child: MaterialApp(
        title: "FlutterTube",
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),

    );
  }
}