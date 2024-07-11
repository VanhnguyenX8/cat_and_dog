import 'package:cat_and_dog/features/cats/repo/cat_repo.dart';
import 'package:cat_and_dog/features/home/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  CatBloc(this.catRepository) : super(const CatState()) {
    on<CatFetched>(_onCatFetched);
  }

  CatRepo catRepository;

  Future<void> _onCatFetched(CatFetched event, Emitter<CatState> emit) async {
    try {
      emit(state.copyWith(status: CatStatus.loading, error: null));
      final data = catRepository.getCats();
      await Future.delayed(const Duration(seconds: 2), () {
        // code to be executed after 2 seconds
        return emit(state.copyWith(status: CatStatus.success, cats: data, error: null));
      });
    } catch (error) {
      emit(state.copyWith(status: CatStatus.failure, error: error.toString()));
    } finally {}
  }

  // @override
  // Future<void> close() {
  //   return super.close();
  // }
}
