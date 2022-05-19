import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:line_icons/line_icons.dart';

import 'package:music_player/bloc/music_bloc.dart';
import 'package:music_player/bloc/track_bloc.dart';
import 'package:music_player/model/LyicsModel.dart';
import 'package:music_player/model/Music_hive.dart';
import 'package:music_player/model/music_new.dart';
import 'package:music_player/repository/Music_repo.dart';

class MusicDetailScreen extends StatefulWidget {
  // Music music;
  int TrackID;
  String Trackname;
  String Albumname;
  String Singers;

  MusicDetailScreen({
    Key? key,
    required this.TrackID,
    required this.Trackname,
    required this.Albumname,
    required this.Singers,
  }) : super(key: key);
  @override
  State<MusicDetailScreen> createState() => _MusicDetailScreenState();
}

class _MusicDetailScreenState extends State<MusicDetailScreen> {
  bool isLyricsLoading = true;
  bool _isBookmarked = false;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TrackBloc>(context).add(FetchTrackEvent(widget.TrackID));

    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        BlocProvider.of<TrackBloc>(context).add(NointernetEventT());
      }
      if (result == ConnectivityResult.mobile) {
        BlocProvider.of<TrackBloc>(context)
            .add(FetchTrackEvent(widget.TrackID));
      }
    });
  }

  void addtoHivebox(MusicHive music) async {
    await Hive.box('bookmark').put(music.TrackID, music);
  }

  void removefrombox(MusicHive music) async {
    await Hive.box('bookmark').delete(music.TrackID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Track Details'),
          actions: [
            IconButton(
                onPressed: () {
                  var music = MusicHive(
                      TrackName: widget.Trackname,
                      Albumname: widget.Albumname,
                      Singers: widget.Singers,
                      TrackID: widget.TrackID);

                  setState(() {
                    if (_isBookmarked) {
                      removefrombox(music);
                      _isBookmarked = false;
                    } else {
                      addtoHivebox(music);
                      _isBookmarked = true;
                    }
                  });
                },
                icon: !_isBookmarked
                    ? Icon(LineIcons.bookmark)
                    : Icon(Icons.bookmark))
          ],
        ),
        body: BlocBuilder<TrackBloc, TrackState>(
          builder: (context, state) {
            if (state is TrackIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TrackIsLoaded) {
              return deatails(
                track: state.getTrack,
                lyrics: state.getLyrics,
              );
            } else if (state is NointernetStateT) {
              return const Center(
                child: Text('Check your internet Connection'),
              );
            }
            return Center(child: Text("error"));
          },
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //subscription.cancel();
  }
}

class deatails extends StatelessWidget {
  Track track;
  Lyrics lyrics;

  deatails({
    Key? key,
    required this.track,
    required this.lyrics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //  color: Colors.red,
        child: ListView(
      children: [
        ListTile(
          title: Text('Name'),
          subtitle: Text(track.trackName),
        ),
        ListTile(
          title: Text('Artist'),
          subtitle: Text(track.artistName),
        ),
        ListTile(
          title: Text('Album Name'),
          subtitle: Text(track.albumName),
        ),
        ListTile(
          title: Text('Explicit'),
          subtitle: Text(track.explicit == 0 ? 'False' : 'True'),
        ),
        ListTile(
          title: Text('Rating'),
          subtitle: Text(track.trackRating.toString()),
        ),
        ListTile(
          title: Text('Lyrics'),
          subtitle: Text(lyrics.lyricsBody.toString()),
        ),
      ],
    ));
  }
}

class Fulldeatails extends StatelessWidget {
  Track track;
  Lyrics? lyrics;
  BuildContext global;
  Fulldeatails({
    Key? key,
    required this.track,
    required this.lyrics,
    required this.global,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: ListView(
          children: [
            ListTile(
              title: Text('Name'),
              subtitle: Text(track.trackName),
            ),
            ListTile(
              title: Text('Artist'),
              subtitle: Text(track.artistName),
            ),
            ListTile(
              title: Text('Album Name'),
              subtitle: Text(track.albumName),
            ),
            ListTile(
              title: Text('Explicit'),
              subtitle: Text(track.explicit == 0 ? 'False' : 'True'),
            ),
            ListTile(
              title: Text('Rating'),
              subtitle: Text(track.trackRating.toString()),
            ),
          ],
        ));
  }
}
