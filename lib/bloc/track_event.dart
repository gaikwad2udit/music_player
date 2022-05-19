part of 'track_bloc.dart';

abstract class TrackEvent extends Equatable {
  const TrackEvent();

  @override
  List<Object> get props => [];
}

class FetchTrackEvent extends TrackEvent {
  final _TrackID;

  FetchTrackEvent(this._TrackID);

  @override
  // TODO: implement props
  List<Object> get props => [_TrackID];
}

class FetchLyricsEvent extends TrackEvent {
  final _Trackid;

  FetchLyricsEvent(this._Trackid);

  @override
  List<Object> get props => [_Trackid];
}

class NointernetEventT extends TrackEvent {}
