part of 'track_bloc.dart';

abstract class TrackState extends Equatable {
  const TrackState();

  @override
  List<Object> get props => [];
}

class TrackInitial extends TrackState {}

class TrackIsLoading extends TrackState {}

class LyricsIsLoading extends TrackState {}

class TrackIsLoaded extends TrackState {
  final _track;
  final _Lyrics;

  TrackIsLoaded(this._track, this._Lyrics);

  Track get getTrack => _track;
  Lyrics get getLyrics => _Lyrics;

  @override
  // TODO: implement props
  List<Object> get props => [_track];
}

class LyricsIsLoaded extends TrackState {
  final _Lyrics;

  LyricsIsLoaded(this._Lyrics);

  Lyrics get getLyrics => _Lyrics;

  @override
  // TODO: implement props
  List<Object> get props => [_Lyrics];
}

class TrackIsNotLoaded extends TrackState {}

class LyricsIsNotLoaded extends TrackState {}

class NointernetStateT extends TrackState {}
