
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/todoModel.dart';

 class TodoState extends Equatable{
   String status;
   List<TodoModel>? todoList=<TodoModel>[];
   TodoState({this.todoList,this.status="NORMAL"});

   TodoState copyWith({bool? isChecked,List<TodoModel>? todoList,String? status}){
     return TodoState(
       todoList: todoList??this.todoList,
       status: status??this.status,
     );
   }

   @override
   List<Object?> get props => [todoList,status];

}

