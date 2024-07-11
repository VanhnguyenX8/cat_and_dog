import 'package:cat_and_dog/features/repo/storage_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'storage_event.dart';
part 'storage_state.dart';

class StorageBLoc extends Bloc<StorageEvent, StorageState> {
  StorageBLoc(this.repo) : super(const StorageState()) {
    on<StorageFetch>(_onStorageFetched);
    on<StorageSet>(_onSetStorage);
  }

  StorageRepo repo;

  Future<void> _onStorageFetched(StorageFetch event, Emitter<StorageState> emit) async {
    try {
      emit(state.copyWith(status: StorageStatus.loading, error: null));
      final data = await repo.checkValueOpenFirstApp();
      if (data == null) {
        return emit(state.copyWith(status: StorageStatus.successIntro, isIntro: data, error: null));
      } else if (data == true) {
        return emit(state.copyWith(status: StorageStatus.successNotIntro, isIntro: data, error: null));
      }
    } catch (error) {
      emit(state.copyWith(status: StorageStatus.failure, error: error.toString()));
    } finally {}
  }

  Future<void> _onSetStorage(StorageSet event, Emitter<StorageState> emit) async {
    try {
      emit(state.copyWith(status: StorageStatus.loading, error: null));
      final data = await repo.setValueOpenFirstApp();
      return emit(state.copyWith(status: StorageStatus.successNotIntro, isIntro: data, error: null));
    } catch (error) {
      emit(state.copyWith(status: StorageStatus.failure, error: error.toString()));
    } finally {}
  }
}
