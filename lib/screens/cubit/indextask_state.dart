part of 'indextask_cubit.dart';

@immutable
class IndextaskState {}

class IndextaskInitial extends IndextaskState {}

class IndextaskLoading extends IndextaskState {}

class IndextaskLoaded extends IndextaskState {
  final List<IndexTasks> indexTasks;

  IndextaskLoaded(this.indexTasks);
}

class IndextaskError extends IndextaskState {
  final String errorMessage;

  IndextaskError(this.errorMessage);
}
