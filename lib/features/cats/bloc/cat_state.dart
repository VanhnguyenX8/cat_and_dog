part of 'cat_bloc.dart';


enum CatStatus { initial, loading, success, failure }

class CatState extends Equatable {
  const CatState({this.status = CatStatus.initial, this.cats = const [], this.error});

  final CatStatus status;
  final List<Animal> cats;
  final String? error;

  CatState copyWith({CatStatus? status, List<Animal>? cats, String? error}) {
    return CatState(status: status ?? this.status, cats: cats ?? this.cats, error: error ?? this.error);
  }

  @override
  String toString() {
    return '''CatState { status: $status, Animal: $cats, error: $error }''';
  }

  @override
  List<Object?> get props => [status, cats, error];
}
