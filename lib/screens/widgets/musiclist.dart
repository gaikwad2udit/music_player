import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:music_player/model/music_new.dart';
import 'package:music_player/screens/music_detail_screen.dart';

class MusicListMain extends StatelessWidget {
  Music music;

  MusicListMain({
    Key? key,
    required this.music,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: music.message.body.trackList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // BlocProvider.of<MusicBloc>(context).add(FetchTrackEvent(
              //     music.message.body.trackList[index].track.trackId));

              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return MusicDetailScreen(
                  TrackID: music.message.body.trackList[index].track.trackId,
                  Albumname:
                      music.message.body.trackList[index].track.albumName,
                  Singers: music.message.body.trackList[index].track.artistName,
                  Trackname:
                      music.message.body.trackList[index].track.trackName,
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
                            music.message.body.trackList[index].track.trackName,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Text(
                          music.message.body.trackList[index].track.albumName,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Text(music
                          .message.body.trackList[index].track.artistName)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
