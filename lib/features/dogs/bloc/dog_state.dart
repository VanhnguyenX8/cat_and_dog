part of 'dog_bloc.dart';


enum DogStatus { initial, loading, success, failure }

class DogState extends Equatable {
  const DogState({this.status = DogStatus.initial, this.dogs = const [], this.error});

  final DogStatus status;
  final List<Animal> dogs;
  final String? error;

  DogState copyWith({DogStatus? status, List<Animal>? dogs, String? error}) {
    return DogState(status: status ?? this.status, dogs: dogs ?? this.dogs, error: error ?? this.error);
  }

  @override
  String toString() {
    return '''Dog state { status: $status, Animal: $dogs, error: $error }''';
  }

  @override
  List<Object?> get props => [status, dogs, error];
}
