part of 'testscores_cubit.dart';

@immutable
class TestscoresState {}

class TestscoresInitial extends TestscoresState {}

class TestscoresLoading extends TestscoresState {}

class TestscoresLoaded extends TestscoresState {
  final List<Testscore>? testScores;

  TestscoresLoaded({required this.testScores});
}

class TestscoresError extends TestscoresState {
  final String errorMessage;

  TestscoresError({required this.errorMessage});
}
