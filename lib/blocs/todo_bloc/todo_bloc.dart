import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_todo/blocs/todo_bloc/todo_event.dart';
import 'package:flutter_bloc_todo/blocs/todo_bloc/todo_state.dart';
import 'package:flutter_bloc_todo/models/todoModel.dart';
import '../../db/db_helper.dart';

class TodoBloc extends Bloc<TodoEvent,TodoState> {
  DatabaseHelper dbHelper=DatabaseHelper();
  TodoBloc() : super(TodoState()) {
    on<AddTodoEvent>(_addTodoEvent);
    on<GetTodoList>(_getTodoList);
    on<DeleteTodoEvent>(_deleteTodoList);
    on<CompletedTask>(_completedTask);
  }

  FutureOr<void> _addTodoEvent(AddTodoEvent event, Emitter<TodoState> emit) async{
    await dbHelper.insertTodo(TodoModel(
      title:event.addTodoController.text,
      isCompleted: 0,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString()
    ));

     add(GetTodoList());
  }


  FutureOr<void> _getTodoList(GetTodoList event, Emitter<TodoState> emit) async{
   emit(state.copyWith(status: "PROGRESS"));
   try {
     final todos = await dbHelper.getTodos();
    emit(state.copyWith(todoList: todos));
     emit(state.copyWith(status: "NORMAL"));
   }
   catch(e){
     emit(state.copyWith(status: "NORMAL"));
   }
  }

  FutureOr<void> _deleteTodoList(DeleteTodoEvent event, Emitter<TodoState> emit) async{
    emit(state.copyWith(status: "PROGRESS"));
    try {
      final todos = await dbHelper.deleteTodo(event.id);
      add(GetTodoList());
      emit(state.copyWith(status: "NORMAL"));
    }
    catch(e){
      emit(state.copyWith(status: "NORMAL"));
    }
  }

  FutureOr<void> _completedTask(CompletedTask event, Emitter<TodoState> emit) async{
       await dbHelper.taskStatus(event.id,event.isCompleted);
       add(GetTodoList());
  }
}
