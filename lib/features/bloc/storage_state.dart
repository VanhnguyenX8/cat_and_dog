part of 'storage_bloc.dart';

enum StorageStatus { initial, loading, successNotIntro,successIntro, failure }

class StorageState extends Equatable {
  const StorageState({this.status = StorageStatus.initial, this.isIntro, this.error});

  final StorageStatus status;
  final bool? isIntro;
  final String? error;

  StorageState copyWith({StorageStatus? status, bool? isIntro, String? error}) {
    return StorageState(status: status ?? this.status, isIntro: isIntro ?? this.isIntro, error: error ?? this.error);
  }

  @override
  String toString() {
    return '''StorageState { status: $status, isIntro: $isIntro, error: $error }''';
  }

  @override
  List<Object?> get props => [status, isIntro, error];
}
