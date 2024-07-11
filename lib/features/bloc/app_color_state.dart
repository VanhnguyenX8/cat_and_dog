part of 'app_color_bloc.dart';

enum AppColorStatus { initial, loading, success, failure }

class AppColorState extends Equatable {
  const AppColorState({this.status = AppColorStatus.initial, this.color = const Color(0XFFFF949B), this.error});

  final AppColorStatus status;
  final Color? color;
  final String? error;

  AppColorState copyWith({AppColorStatus? status, Color? color, String? error}) {
    return AppColorState(status: status ?? this.status, color: color ?? this.color, error: error ?? this.error);
  }

  @override
  String toString() {
    return '''StorageState { status: $status, color: $color, error: $error }''';
  }

  @override
  List<Object?> get props => [status, color, error];
}
