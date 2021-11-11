import 'package:ekuid_assignment/cubit/home_cubit_cubit.dart';
import 'package:ekuid_assignment/helper/theme.dart';
import 'package:ekuid_assignment/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData(),
        home: HomePage(),
      ),
    );
  }
}
