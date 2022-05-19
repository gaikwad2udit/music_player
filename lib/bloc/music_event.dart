part of 'music_bloc.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();

  @override
  List<Object> get props => [];
}

class FetchMusicEvent extends MusicEvent {
  // final _Music;

  // FetchMusicEvent(this._Music);

  // @override
  // List<Object> get props => _Music;
  // String type='';

  // FetchMusicEvent({
  //    this.type ='',
  // });
  //  @override
  // List<Object> get props => type;
}

class ResetMusicEvent extends MusicEvent {}

class NointernetEvent extends MusicEvent {}
