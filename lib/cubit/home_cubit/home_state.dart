part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Person> persons;

  HomeSuccess(this.persons);
}

class HomeFail extends HomeState {
  final String error;

  HomeFail(this.error);
}
