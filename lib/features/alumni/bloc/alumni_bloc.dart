import 'dart:convert';

import 'package:alumni_hub_ft_uh/constants/keys.dart';
import 'package:alumni_hub_ft_uh/features/alumni/domain/alumni_repository.dart';
import 'package:alumni_hub_ft_uh/features/alumni/domain/models/alumni_get_many_model.dart';
import 'package:alumni_hub_ft_uh/features/alumni/domain/models/alumni_response.dart';
import 'package:alumni_hub_ft_uh/features/user/domain/models/user_model.dart';
import 'package:alumni_hub_ft_uh/features/user/domain/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cached_query/cached_query.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part "alumni_event.dart";
part "alumni_state.dart";

@injectable
class AlumniAngkatanBloc extends Bloc<AlumniEvent, AlumniState> {
  final AlumniRepository _alumniRepository;
  String? search;
  String? angkatan;

  AlumniAngkatanBloc(this._alumniRepository) : super(AlumniAngkatanInitial()) {
    on<AlumniEventGetAngkatan>((event, emit) async {
      final query = _alumniRepository.getAngkatanAlumni(AlumniAngkatanParams(
        search: search,
        all: angkatan == 'all',
        angkatan: angkatan,
      ));
      return emit.forEach<QueryState<AlumniAngkatanResponse>>(query.stream,
          onData: (queryState) {
        if (queryState.status == QueryStatus.loading) {
          return AlumniAngkatanLoading();
        } else if (queryState.status == QueryStatus.error) {
          return AlumniAngkatanError(queryState.error.toString());
        }
        return AlumniAngkatanSuccess(queryState.data!);
      });
    });
  }
}

@injectable
class AlumniJurusanBloc extends Bloc<AlumniEvent, AlumniState> {
  final AlumniRepository _alumniRepository;

  AlumniJurusanBloc(this._alumniRepository) : super(AlumniJurusanInitial()) {
    on<AlumniEventGetJurusan>((event, emit) async {
      final query =
          _alumniRepository.getJurusanAlumni(event.alumniJurusanParams);
      return emit.forEach<QueryState<AlumniJurusanResponse>>(query.stream,
          onData: (queryState) {
        if (queryState.status == QueryStatus.loading) {
          return AlumniJurusanLoading();
        } else if (queryState.status == QueryStatus.error) {
          return AlumniJurusanError(queryState.error.toString());
        }
        return AlumniJurusanSuccess(queryState.data!);
      });
    });
  }
}

@injectable
class AlumniGetManyBloc extends Bloc<AlumniEvent, AlumniState> {
  final AlumniRepository _alumniRepository;

  AlumniGetManyBloc(this._alumniRepository) : super(AlumniGetManyInitial()) {
    on<AlumniEventGetMany>((event, emit) async {
      final query =
          _alumniRepository.getAlumniClaimData(event.alumniGetManyParams);
      return emit.forEach<QueryState<AlumniGetManyResponse>>(query.stream,
          onData: (queryState) {
        if (queryState.status == QueryStatus.loading) {
          return AlumniGetManyLoading();
        } else if (queryState.status == QueryStatus.error) {
          return AlumniGetManyError(queryState.error.toString());
        }
        return AlumniGetManySuccess(queryState.data!);
      });
    });
  }
}

@injectable
class AlumniUpdateBloc extends Bloc<AlumniEvent, AlumniState> {
  final AlumniRepository _alumniRepository;
  final UserRepository _userRepository;

  AlumniUpdateBloc(this._alumniRepository, this._userRepository)
      : super(AlumniUpdateInitial()) {
    on<AlumniEventUpdate>((event, emit) async {
      emit(AlumniUpdateLoading());
      try {
        final response =
            await _alumniRepository.updateAlumni(event.alumniUpdateBody);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final userSession =
            UserSession.fromJson(json.decode(prefs.getString(kUserSession)!));
        await _userRepository.saveUserSession(UserSession(
            token: userSession.token,
            user: userSession.user?.copyWith(alumni: response.data)));
        emit(AlumniUpdateSuccess(response));
      } catch (e) {
        emit(AlumniUpdateError(e.toString()));
      }
    });
  }
}
