import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:TODO/shared/bloc_observer.dart';
import 'package:TODO/to_do_app/TO_DO_APP.dart';
void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
home:to_do(),
    );
  }

}
