import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_task/views/login/bloc/states_login.dart';

import '../../../model/model.dart';
 import '../../../services/dio_helper.dart';
import '../../../services/end_points.dart';


class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;
  LoginModel? loginModel;
   void changeSuffixIcon()
  {
    isVisible =! isVisible;
    emit(ChangeSuffixIconState());
  }

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        "email":email,
        "password":password,
      },
    ).then((value)
    {
      print(value.data);

      loginModel= LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error)
    {
      print("error in userlogin ${error.toString()}");
      emit(LoginErrorState(error.toString()));
    });

  }

}