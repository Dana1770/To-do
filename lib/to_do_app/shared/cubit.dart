import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TODO/to_do_app/shared/states.dart';
import 'package:sqflite/sqflite.dart';

import '../archieved.dart';
import '../done.dart';
import '../tasks.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialStates()) ;
static AppCubit get (context)=>BlocProvider.of(context);
  int current_Index=0;
  List<Widget>screens=[
    tasks(),
    done(),
    archieved()
  ];
  List<String>titles=[
    "Tasks",
    "Done",
    "Archieved"
  ];
  void ChangeIndex(index){
    current_Index=index;
    emit(App_Change_Botton_Navigation_Bar_State());
  }
 late Database database;
  List<Map>newTasks=[];
  List<Map>doneTasks=[];
  List<Map>archivedTasks=[];
  void CreateDB(){
    openDatabase('Todo.db',version: 1,
        onCreate: (database,version){
      print('database created');
      database.execute("CREATE TABLE tasks(id  INTEGER PRIMARY KEY ,title TEXT,time TEXT,date TEXT,status TEXT)").then((value) {print("table created");}).catchError((error){print("error when creating table${error.toString()}");

    });},onOpen:(database){
        getDataFromDatabase(database);

      print("database is opened");
    },
    ).then((value){
       database=value;
       emit(AppCreateDBstate());
    });}
  insertDB ({
    required String title,
    required String time,
    required String date,})async
  {
    await database.transaction((txn)async{
  txn.rawInsert(
    'INSERT INTO tasks (title, date, time, status) VALUES("$title","$date","$time","new")'
  ).then((value) {
    print('$value inserted sucessfully');
    emit(AppInsertDBstate());
    getDataFromDatabase(database);
    
  }).catchError((error){
    print("error when inserting new record ${error.toString()}");
  });

  });}
void getDataFromDatabase(database){
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    emit(AppGetDbLoadingState());
     database.rawQuery('SELECT * FROM tasks').then((value){

       value.forEach((element) {
         if(element['status']=='new'){
       newTasks.add(element);
         }
         else   if(element['status']=='done'){
           doneTasks.add(element);
         }
         else   if(element['status']=='archived'){
           archivedTasks.add(element);
         }
       }
         );
       emit(AppGetDBstate());

     });}
  bool isButtonSheetShown=false;
  IconData fabIcon=Icons.edit;
void changeButtonNavigationSheet ({
    required bool isShow,
  required IconData fab
}){
  isButtonSheetShown=isShow;
  fabIcon=fab;
  emit(AppChangeButtonSheet());


}
void UpdateData ({
    required String status,
    required int id,
}) async {
  database.rawUpdate(
      'UPDATE tasks SET status = ?  WHERE id = ?',
      ['$status', '$id']).then((value) {
        getDataFromDatabase(database);
        emit(AppUpdateState());
  });

}
  void deleteData ({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteState());
    });

  }


}
