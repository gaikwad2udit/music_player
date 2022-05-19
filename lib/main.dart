import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:music_player/bloc/music_bloc.dart';
import 'package:music_player/bloc/track_bloc.dart';
import 'package:music_player/model/Music_hive.dart';
import 'package:music_player/repository/Music_repo.dart';
import 'package:music_player/screens/mainscreen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appdocdir = await getApplicationDocumentsDirectory();
  Hive.init(appdocdir.path);
  Hive.registerAdapter(MusicHiveAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MusicBloc(MusicRepo()),
        ),
        BlocProvider(
          create: (context) => TrackBloc(MusicRepo()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: FutureBuilder(
          future: Hive.openBox('bookmark'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                Text("error opening local Storage");
              }
              return MainScreen();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
