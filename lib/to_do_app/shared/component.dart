import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TODO/to_do_app/shared/cubit.dart';

Widget buildTaskItem (Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child:   Row(
      children: [
        CircleAvatar(
  
          backgroundColor: Colors.amber[800],
  
            radius: 40,
  
  
  
            child: Text('${model['time']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
  
  
  
  
  
  
  
          ),
  
  
  
          SizedBox(width: 20,),
  
  
  
          Expanded(
  
            child: Column(
  
  
  
              mainAxisSize: MainAxisSize.min,
  
  
  
              children: [
  
  
  
                Text('${model['title']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
  
  
  
                Text('${model['date']}',style: TextStyle(color: Colors.grey),),
  
  
  
              ],
  
  
  
            ),
  
          ),
  
          SizedBox(width: 20,),
  
          IconButton(onPressed: (){AppCubit.get(context).UpdateData(status: 'done', id:model['id']);}, icon: Icon(Icons.done,color: Colors.green,)),
  
          IconButton(onPressed: (){AppCubit.get(context).UpdateData(status: 'archived', id:model['id']);}, icon: Icon(Icons.archive,color: Colors.black45,))
  
  
  
        ],
  
  
  
        ),
  
  ),
  onDismissed: (direction){AppCubit.get(context).deleteData(id: model['id']);},
);
Widget tasksBuilder ({required List<Map>tasks,})=>ConditionalBuilder(
  condition: tasks.length>0,
  builder: (context)=>ListView.separated(
    itemBuilder: (context, index) => buildTaskItem(tasks[index],context),
    separatorBuilder: (context, index) =>
        Padding(padding: EdgeInsetsDirectional.only(start: 20),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],


          ),
        ),

    itemCount: tasks.length,),
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.warning_amber,size: 100,color: Colors.black45,),
        Text('No Tasks Yet , Please add some tasks',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45 ),),
      ],),
  ),
);
Widget drawer()=>Drawer(
child: Padding(
padding: const EdgeInsets.only(top: 50.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
children: [
CircleAvatar(radius: 40,child: Image(image: AssetImage("assets/Man1.png",),fit: BoxFit.fill,),),
SizedBox(height: 30,),
Row(
children: [
Padding(
padding: const EdgeInsets.only(left: 8.0),
child: Icon(Icons.task,color: Colors.amber[800],),
),
TextButton(onPressed: (){

}, child: Text("Tasks",style: TextStyle(fontSize: 20,color: Colors.black),)),
],
),
SizedBox(height: 30,),
Row(
children: [
Padding(
padding: const EdgeInsets.only(left: 8.0),
child: Icon(Icons.done_all,color: Colors.amber[800],),
),
TextButton(onPressed: (){

}, child: Text("Done Tasks",style: TextStyle(fontSize: 20,color: Colors.black),)),
],
),
SizedBox(height: 30,),
Row(
children: [
Padding(
padding: const EdgeInsets.only(left: 8.0),
child: Icon(Icons.archive,color: Colors.amber[800],),
),
TextButton(onPressed: (){

}, child: Text("Archived Tasks",style: TextStyle(fontSize: 20,color: Colors.black),)),
],
),
],
),
),
);