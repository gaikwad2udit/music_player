import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/model/LyicsModel.dart';

import 'package:music_player/model/music_new.dart';
import 'package:music_player/repository/Music_repo.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  MusicRepo musicRepo;

  TrackBloc(
    this.musicRepo,
  ) : super(TrackInitial()) {
    on<TrackEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is FetchTrackEvent) {
        emit(TrackIsLoading());

        try {
          // print('loding the data 2');
          //  print(event.getTrackid);
          int trackId = event._TrackID;
          Track track = await musicRepo.getTrack(event._TrackID);
          Lyrics lyrics = await musicRepo.getLyrics(trackId);
          emit(TrackIsLoaded(track, lyrics));
        } catch (e) {
          emit(TrackIsNotLoaded());
        }
      } else if (event is NointernetEventT) {
        emit(NointernetStateT());
      }
    });
  }
}
