import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_color_event.dart';
part 'app_color_state.dart';

class AppColorBLoc extends Bloc<AppColorEvent, AppColorState> {
  AppColorBLoc() : super(const AppColorState()) {
    on<AppColorFetch>(_onAppColorFetch);
  }

  Future<void> _onAppColorFetch(AppColorFetch event, Emitter<AppColorState> emit) async {
    try {
      emit(state.copyWith(status: AppColorStatus.loading, error: null));
      return emit(state.copyWith(status: AppColorStatus.success, color: event.color, error: null));
    } catch (error) {
      emit(state.copyWith(status: AppColorStatus.failure, error: error.toString()));
    } finally {}
  }
}
