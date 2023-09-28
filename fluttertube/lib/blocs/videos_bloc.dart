import 'dart:async';
import 'dart:ui';
import 'package:fluttertube/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';

class VideosBloc implements BlocBase {

  late Api api;
  late List<Video> videos;
  /*
  * Um stream é uma sequência de eventos assíncronos.
  * Diferentemente de Future um Stream notifica quando existe um evento pronto.
  * Para criar um Stream, usamos a classe StreamController;
  * */


  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc(){
    api = Api();
    /*
  * Você pode processar um stream usando await for ou listen() a partir da API Stream;
  * */
    _searchController.stream.listen(_search);
  }
/*
* Realiza a bsuca por vídeos
* */
  void _search(String search) async{
    /*
    * Se a string de busca não for vazia, então realizar a busca.
    * Caso contrário, concatenar a lista de vídeos atual com a lista de vídeos da próxima página
    * */
    if(search != ''){
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

}