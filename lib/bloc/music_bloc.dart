import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:music_player/model/LyicsModel.dart';

import 'package:music_player/model/music_new.dart';
import 'package:music_player/repository/Music_repo.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicRepo musicRepo;

  MusicBloc(
    this.musicRepo,
  ) : super(MusicInitial()) {
    on<MusicEvent>((event, emit) async {
      if (event is FetchMusicEvent) {
        emit(MusicIsLoading());

        try {
          // print('loding the data');
          print('sdff0');
          Music music = await musicRepo.getMusic();
          emit(MusicIsLoaded(music));
        } catch (e) {
          emit(MusicIsNotLoaded());
        }
      } else if (event is ResetMusicEvent) {
        emit(MusicInitial());
      } else if (event is NointernetEvent) {
        emit(NointernetState());
      }
    });
  }
}
