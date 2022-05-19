part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  const MusicState();

  @override
  List<Object> get props => [];
}

class MusicInitial extends MusicState {}

class MusicIsLoading extends MusicState {}

class MusicIsLoaded extends MusicState {
  final _music;

  MusicIsLoaded(this._music);
  Music get getMusic => _music;
  @override
  // TODO: implement props
  List<Object> get props => [_music];
}

class MusicIsNotLoaded extends MusicState {}

class NointernetState extends MusicState {}
