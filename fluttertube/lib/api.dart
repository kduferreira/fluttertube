import 'dart:convert';
import 'package:fluttertube/models/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = 'AIzaSyB7o_xhHn-YcHlpdx6wDlNdOAI04s6F1xU';

class Api {
  late String _search;
  late String _nextToken;

  Future<List<Video>> search(String search) async {
    _search = search;

    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"));
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"));
    return decode(response);
  }

  List<Video> decode(http.Response response) {
    //200 = HTTP OK
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      _nextToken = decoded["nextPageToken"];
      List<Video> videos = decoded["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }
}
