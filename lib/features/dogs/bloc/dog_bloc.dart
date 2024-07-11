import 'package:cat_and_dog/features/dogs/repo/dog_repo.dart';
import 'package:cat_and_dog/features/home/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'dog_event.dart';
part 'dog_state.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  DogBloc(this.repo) : super(const DogState()) {
    on<DogFetched>(_onCatFetched);
  }

  DogRepo repo;

  Future<void> _onCatFetched(DogFetched event, Emitter<DogState> emit) async {
    try {
      emit(state.copyWith(status: DogStatus.loading, error: null));
      final data = repo.getDogs();
      await Future.delayed(const Duration(seconds: 2), () {
        // code to be executed after 2 seconds
        return emit(state.copyWith(status: DogStatus.success, dogs: data, error: null));
      });
    } catch (error) {
      emit(state.copyWith(status: DogStatus.failure, error: error.toString()));
    } finally {}
  }

  // @override
  // Future<void> close() {
  //   return super.close();
  // }
}
