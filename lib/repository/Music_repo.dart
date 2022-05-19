import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_player/model/LyicsModel.dart';
import 'package:music_player/model/music.dart';
import 'package:music_player/model/music_new.dart';

class MusicRepo {
  Future<Music> getMusic() async {
    final result = await http.get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=34c866108f38a02e2b6a95c8e7216278'));

    //print(result.statusCode);
    // print(result.body);
    if (result.statusCode != 200) {
      throw Exception();
    }
    final jsondecoded = json.decode(result.body);
    return Music.fromJson(jsondecoded);
  }

  Future<Track> getTrack(int trackID) async {
    // print('adsfad');
    final result = await http.get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=${trackID}&apikey=34c866108f38a02e2b6a95c8e7216278'));

    //print(result.statusCode);
    // print(result.body);
    if (result.statusCode != 200) {
      // print("error fetching Json from an api");
      throw Exception();
    }
    final jsondecoded = json.decode(result.body);
    return Track.fromJson(jsondecoded['message']["body"]["track"]);
  }

  Future<Lyrics> getLyrics(int TrackID) async {
    // print("loading lyrics");
    final result = await http.get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${TrackID}&apikey=34c866108f38a02e2b6a95c8e7216278'));

    // print(result.statusCode);
//print(result.body);
    if (result.statusCode != 200) {
      // print("error fetching Json from an api");
      throw Exception();
    }
    final jsondecoded = json.decode(result.body);
    return Lyrics.fromJson(jsondecoded['message']["body"]["lyrics"]);
  }
}
