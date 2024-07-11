part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StorageFetch extends StorageEvent {
  StorageFetch();
}
class StorageSet extends StorageEvent {
  StorageSet();
}

