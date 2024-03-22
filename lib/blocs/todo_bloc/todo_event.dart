import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TodoEvent extends Equatable{
  @override
  List<Object?> get props =>[];
}

class AddTodoEvent extends TodoEvent{
  TextEditingController addTodoController=TextEditingController();
  AddTodoEvent({required this.addTodoController});
}
class DeleteTodoEvent extends TodoEvent{
  int id;
  DeleteTodoEvent({required this.id});
}

class GetTodoList extends TodoEvent{}

class CompletedTask extends TodoEvent{
  int id;
  int isCompleted;
  CompletedTask({required this.id,required this.isCompleted});
}

