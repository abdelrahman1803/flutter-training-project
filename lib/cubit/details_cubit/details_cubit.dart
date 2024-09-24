import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_project/models/details_model.dart';
import 'package:training_project/requests/details_request.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  static DetailsCubit get(context) => BlocProvider.of(context);

  List<DetailsModel> detailsModel = [];
  List<String> personImages = [];

  void getDetailsModel({required int id}) {
    emit(DetailsLoading());
    DetailsRequest.getDetailsModel(id, onSuccess: (res) {
      if (res.isNotEmpty) {
        detailsModel = res;
        emit(DetailsSuccess());
      } else {
        emit(DetailsFail());
      }
    }, onError: (statusCode) {
      emit(DetailsFail());
    });
  }

  void getPersonImages({required int id}) {
    emit(DetailsLoading());
    DetailsRequest.getPersonImages(id, onSuccess: (res) {
      if (res.isNotEmpty) {
        personImages = res;
        emit(DetailsSuccess());
      } else {
        emit(DetailsFail());
      }
    }, onError: (statusCode) {
      emit(DetailsFail());
    });
  }
}
