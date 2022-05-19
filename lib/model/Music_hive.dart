import 'package:hive_flutter/hive_flutter.dart';
part 'Music_hive.g.dart';

@HiveType(typeId: 0)
class MusicHive {
  @HiveField(0)
  final TrackID;

  @HiveField(1)
  final TrackName;

  @HiveField(2)
  final Singers;

  @HiveField(3)
  final Albumname;

  MusicHive({
    required this.TrackName,
    required this.Albumname,
    required this.Singers,
    required this.TrackID,
  });
}
