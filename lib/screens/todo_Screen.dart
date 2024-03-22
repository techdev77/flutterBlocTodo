import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/blocs/todo_bloc/todo_bloc.dart';
import 'package:flutter_bloc_todo/blocs/todo_bloc/todo_event.dart';
import 'package:flutter_bloc_todo/blocs/todo_bloc/todo_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../dialogs/add_todo_model.dart';
import '../dialogs/alert_dialog.dart';
import 'components/todo_items.dart';

class TodoScreen extends StatefulWidget {
   const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetTodoList());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:ListView(
          children: [
            AppBar(title: const Text("Todo List",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 18),)),
            BlocBuilder<TodoBloc, TodoState>(
             builder: (context, state) {
                  if(state.status=="PROGRESS"){
                    return const Center(child: CircularProgressIndicator());
                  }
                  if(state.todoList?.isEmpty??false || state.todoList==null){
                     return const Center(child: Text("Todo List Not Available.",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),));
                  }
              return ListView.builder(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              itemCount: state.todoList?.length??1,
             itemBuilder:(_,index)=>todoItems(_,index,(){
               MyAlertDialog(title: "Do you want to Delete this Todo?",callback: (){
               context.read<TodoBloc>().add(DeleteTodoEvent(id: state.todoList![index].id!));

               },context: context).show();
             },state.todoList??[])
            );
            },
          )
          ],
        ),
      ),
      floatingActionButton:BlocBuilder<TodoBloc, TodoState>(
  builder: (context, state) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30,right: 5),
        child: FloatingActionButton(onPressed: (){
          FlutterDialog(context: context,title: "Add Todo",callback: (addTodoController){
            if(addTodoController.text.isEmpty){
              return Fluttertoast.showToast(msg: "Please enter your task",gravity:ToastGravity.CENTER );
            }
            context.read<TodoBloc>().add(AddTodoEvent(addTodoController: addTodoController));
        },).show();},child: const Icon(Icons.add),),
      );
  },
),
    );
  }
}
