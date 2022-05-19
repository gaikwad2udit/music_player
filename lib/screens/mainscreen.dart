import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import 'package:music_player/bloc/music_bloc.dart';
import 'package:music_player/bloc/track_bloc.dart';
import 'package:music_player/model/music_new.dart';
import 'package:music_player/screens/bookmark_screen.dart';
import 'package:music_player/screens/music_detail_screen.dart';
import 'package:music_player/screens/widgets/musiclist.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var isDeviceConnected = false;
  List<bool> isbookmarked = [];

  void initializebookmarklist() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        BlocProvider.of<MusicBloc>(context).add(NointernetEvent());
      }
      if (result == ConnectivityResult.mobile) {
        BlocProvider.of<MusicBloc>(context).add(FetchMusicEvent());
      }
      var a = InternetConnectionChecker().hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<MusicBloc>(context).add(FetchMusicEvent());

    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Trending'),
          ),
          actions: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text("Bookmark"),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return bookmarkScreen();
                            },
                          ));
                        },
                        icon: Icon(LineIcons.bookmark))),
              ],
            )
          ],
        ),
        body: BlocBuilder<MusicBloc, MusicState>(
          builder: (context, state) {
            if (state is MusicInitial) {
              BlocProvider.of<MusicBloc>(context).add(FetchMusicEvent());
              return Center(child: CircularProgressIndicator());
            } else if (state is NointernetState) {
              return Center(child: Text("check you internet connection"));
            } else if (state is MusicIsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MusicIsLoaded) {
              return MusicListMain(
                music: state.getMusic,
              );
            } else if (state is MusicIsNotLoaded) {
              return Center(child: Text("check you internet connection"));
            }
            return Text("something is wrong");
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
