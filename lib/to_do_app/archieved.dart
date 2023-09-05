import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TODO/to_do_app/shared/component.dart';
import 'package:TODO/to_do_app/shared/cubit.dart';
import 'package:TODO/to_do_app/shared/states.dart';

class archieved extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<AppCubit,AppStates>(

        listener: (BuildContext context, AppStates state) {  },
        builder: (BuildContext context, AppStates state){
          var tasks=AppCubit.get(context).archivedTasks;
          return tasksBuilder(tasks: tasks);}

    );
  }

}