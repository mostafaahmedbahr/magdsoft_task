import 'package:flutter_bloc/flutter_bloc.dart';
 import '../../../model/model.dart';
import '../../../services/dio_helper.dart';
import '../../../services/end_points.dart';
import 'states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;
LoginModel? loginModel;
  void changeSuffixIcon() {
    isVisible = !isVisible;
    emit(ChangeSuffixIconRegisterState());
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data:
      {
        "email":email,
        "password":password,
        "phone":phone,
        "name":name,
      },
    ).then((value)
    {
      print(value.data);
      loginModel= LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      print("error in user register ${error.toString()}");
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String uId,
    required String name,
    required String phone,
  }) {

  }
}