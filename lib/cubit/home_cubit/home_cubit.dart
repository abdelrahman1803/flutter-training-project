import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_project/models/home_model.dart';
import 'package:training_project/requests/home_request.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRequest homeRequest;

  HomeCubit(this.homeRequest) : super(HomeInitial());

  static HomeCubit getInstance(context, dynamic BlocProvider) =>
      BlocProvider.of(context);

  List<Person> persons = [];
  List<String> favoriteItems = []; // List to track favorite persons by ID

  void fetchPersons() async {
    emit(HomeLoading());
    try {
      await homeRequest.fetchPersons();
      persons = homeRequest.persons;
      emit(HomeSuccess(persons));
    } catch (e) {
      emit(HomeFail(e.toString()));
    }
  }

  void toggleFavorite(String personId) {
    if (favoriteItems.contains(personId)) {
      favoriteItems.remove(personId);
    } else {
      favoriteItems.add(personId);
    }
    emit(HomeSuccess(persons));
  }

  void removePerson(String personId) {
    persons.removeWhere((person) => person.id.toString() == personId);
    emit(HomeSuccess(persons));
  }

  List<Person> get favoritePersons => persons
      .where((person) => favoriteItems.contains(person.id.toString()))
      .toList();
}
