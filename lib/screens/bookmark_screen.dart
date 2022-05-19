import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:line_icons/line_icons.dart';
import 'package:music_player/model/Music_hive.dart';
import 'package:music_player/screens/music_detail_screen.dart';

class bookmarkScreen extends StatelessWidget {
  const bookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bookmarked'),
      ),
      body: MusicList(),
    );
  }
}

class MusicList extends StatelessWidget {
  //Music music;

  MusicList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Hive.box('bookmark').length,
      itemBuilder: (context, index) {
        var music = Hive.box('bookmark').getAt(index) as MusicHive;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // BlocProvider.of<MusicBloc>(context).add(FetchTrackEvent(
              //     music.message.body.trackList[index].track.trackId));

              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return MusicDetailScreen(
                  TrackID: music.TrackID,
                  Albumname: music.Albumname,
                  Singers: music.Singers,
                  Trackname: music.TrackName,
                );
              })).whenComplete(() => null);
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 130, 134, 137),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: MediaQuery.of(context).size.width * 8,
              child: Row(
                children: [
                  Expanded(child: Icon(Icons.queue_music)),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            music.TrackName,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Text(
                          music.Albumname,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        )
                      ],
                    ),
                  ),
                  Expanded(child: Text(music.Singers)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
