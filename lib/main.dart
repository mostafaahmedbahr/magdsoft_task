import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_task/bloc/cubit.dart';
import 'package:magdsoft_task/services/dio_helper.dart';
import 'package:magdsoft_task/views/login/bloc/cubit_login.dart';
import 'package:magdsoft_task/views/login/login.dart';
import 'package:magdsoft_task/views/register_screen/bloc/cubit_register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>RegisterCubit()),
        BlocProvider(create: (context)=>AppCubit()..getUserData()),

      ],
        child:   MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Login(),
      ),
    );
  }
}
