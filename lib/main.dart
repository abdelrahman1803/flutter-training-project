import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:training_project/cubit/home_cubit/home_cubit.dart';
import 'package:training_project/requests/home_request.dart';
import 'package:training_project/cubit/details_cubit/details_cubit.dart';
import 'package:training_project/screens/screens/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeRequest()),
        BlocProvider<DetailsCubit>(create: (context) => DetailsCubit()),
        BlocProvider(create: (context) => HomeCubit(HomeRequest())),
        // Add other providers if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
