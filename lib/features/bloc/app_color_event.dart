part of 'app_color_bloc.dart';

abstract class AppColorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppColorFetch extends AppColorEvent {
  final Color? color;
  AppColorFetch({this.color});
}
