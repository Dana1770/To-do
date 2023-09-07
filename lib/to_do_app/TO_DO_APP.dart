import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:TODO/to_do_app/shared/cubit.dart';
import 'package:TODO/to_do_app/shared/states.dart';
import 'package:TODO/to_do_app/tasks.dart';

import 'archieved.dart';
import 'done.dart';

class to_do extends StatelessWidget{

var ScaffoldKey=GlobalKey<ScaffoldState>();
var formKey=GlobalKey<FormState>();
var timeController=TextEditingController();
var dateController=TextEditingController();
var titleController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return BlocProvider(
      create: (context)=>AppCubit()..CreateDB(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is AppInsertDBstate) {
            Navigator.pop(context);
          }

        },
        builder:(context,state){
          AppCubit C=AppCubit.get(context);
           return Scaffold(
             key: ScaffoldKey,

drawer:  Drawer(
           child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
           child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
           CircleAvatar(
           radius: 40,
          child: Image(
          image: AssetImage(
           "assets/Man1.png",
           ),
          fit: BoxFit.fill,
           ),
          ),
         SizedBox(
          height: 30,
           ),
          Row(
           children: [
           Padding(
         padding: const EdgeInsets.only(left: 8.0),
         child: Icon(
           Icons.task,
           color: Colors.amber[800],
           ),
        ),
          TextButton(
           onPressed: () {
           AppCubit.get(context).ChangeIndex(0);
           Navigator.pop(context);
          },
           child: Text(
           "Tasks",
          style: TextStyle(fontSize: 20, color: Colors.black),
           )),
           ],
           ),
           SizedBox(
           height: 30,
          ),
          Row(
          children: [
       Padding(
         padding: const EdgeInsets.only(left: 8.0),
           child: Icon(
           Icons.done_all,
          color: Colors.amber[800],
           ),
          ),
        TextButton(
          onPressed: () {
         AppCubit.get(context).ChangeIndex(1);
           Navigator.pop(context);
           },
           child: const Text(
           "Done Tasks",
           style: TextStyle(fontSize: 20, color: Colors.black),
   )),
        ],
         ),
          const SizedBox(
           height: 30,
         ),
          Row(
         children: [
           Padding(
           padding: const EdgeInsets.only(left: 8.0),
           child: Icon(
           Icons.archive,
          color: Colors.amber[800],
           ),
          ),
         TextButton(
           onPressed: () {
           AppCubit.get(context).ChangeIndex(2);
         Navigator.pop(context);
     },
           child: Text(
           "Archived Tasks",
         style: TextStyle(fontSize: 20, color: Colors.black),
       )),
       ],
         ),
          ],
          ),
           ),
          ),          appBar: AppBar(
            backgroundColor: Colors.amber[800],
            title: Text(C.titles[AppCubit.get(context).current_Index],style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            actions: [
              IconButton(onPressed: (){}, icon:Icon(Icons.book))
            ],
          ),
          body: ConditionalBuilder(
          condition: state is! AppGetDbLoadingState,
          builder: (context)=>C.screens[C.current_Index],
          fallback: (context)=>Center(child: CircularProgressIndicator(),),

        ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.amber[900],
            currentIndex:C.current_Index,
            type: BottomNavigationBarType.fixed,
            onTap: (index){
             C.ChangeIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu,color: Colors.amber[800],),label: "Tasks",),
              BottomNavigationBarItem(icon: Icon(Icons.done,color: Colors.amber[800]),label: "Done"),
              BottomNavigationBarItem(icon: Icon(Icons.archive_outlined,color: Colors.amber[800]),label: "Archieved",),
            ],
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            if(C.isButtonSheetShown){
              if(formKey.currentState!.validate()){
                C.insertDB(title: titleController.text, time: timeController.text, date: dateController.text);

              }
            }
            else{
              ScaffoldKey.currentState?.showBottomSheet((context) =>Container(
               color: Colors.white,
               padding: EdgeInsets.all(20.0),
                child: Form(
                  key: formKey, child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   TextFormField(
                     controller: titleController,
                     keyboardType: TextInputType.text,
                     validator: (value){
                       if(value!.isEmpty){
                         return 'title must not be empty';
                       }
                       return null;
                     },
                     decoration: InputDecoration(label: Text("Task Title"),
                       prefix: Icon(Icons.title)

                     ),

                   ),
                    TextFormField(

                      controller: timeController,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'title must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(label: Text("Task Time "),
                          prefix: Icon(Icons.watch_later_rounded)

                      ),
                      onTap: (){showTimePicker(context: context,
                          initialTime:TimeOfDay.now()).then((value){
                            timeController.text=value!.format(context).toString();
                            print(value?.format(context));});}

                    ),
                    TextFormField(
                      controller: dateController,
                      keyboardType: TextInputType.datetime,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'title must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(label: Text("Task Date "),
                          prefix: Icon(Icons.date_range)

                      ),

                      onTap: (){
                        showDatePicker(context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:DateTime.parse('2100-12-03'), ).then((value){
                              dateController.text=DateFormat.yMMMd().format(value!);

                        });
                      },

                    ),
                    SizedBox(height: 15,)
                  ],
                ),
                  
                ),

              ),
                elevation: 20,
              ).closed.then((value){
              //  C.isButtonSheetShown=false;
                C.changeButtonNavigationSheet(isShow: false, fab: Icons.edit);

              });
         // C.isButtonSheetShown=true;
              C.changeButtonNavigationSheet(isShow: true, fab: Icons.add);
            }



          },
            child: Icon(C.fabIcon),backgroundColor: Colors.amber[800],),
        );}
      ),
    );
  }

}