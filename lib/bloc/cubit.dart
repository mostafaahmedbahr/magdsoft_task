import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_task/bloc/states.dart';
import 'package:magdsoft_task/model/model.dart';

import '../services/dio_helper.dart';
import '../services/end_points.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());

  static AppCubit get(context) =>BlocProvider.of(context);

  LoginModel? loginModel;
  void getUserData()
  {
    emit(LoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
       token:  TOKEN,
    ).then((value)
    {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(SuccessUserDataState(loginModel!));
    }).catchError((error){
      print("error in getUserData ${error.toString()}");
      emit(ErrorUserDataState());
    });
  }

}