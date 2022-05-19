import 'package:flutter/cupertino.dart';

class MusicModel {
  final TrackName;
  final Albumname;
  final Singers;
  final TrackID;
  bool isBookmarked;

  MusicModel(this.TrackName, this.Albumname, this.Singers, this.TrackID,
      this.isBookmarked);
}

class DetailedMusic {}
