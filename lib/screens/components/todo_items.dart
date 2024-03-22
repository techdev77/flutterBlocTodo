import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/blocs/todo_bloc/todo_bloc.dart';
import 'package:flutter_bloc_todo/blocs/todo_bloc/todo_event.dart';
import 'package:flutter_bloc_todo/blocs/todo_bloc/todo_state.dart';
import 'package:flutter_bloc_todo/models/todoModel.dart';

Widget todoItems(BuildContext context, int index, void Function() callback,List<TodoModel> todoModel) {
  TodoModel data=todoModel[index];
  return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                return CheckboxListTile(
                  title:  Text(data.title),
                  value: data.isCompleted==0?false:true, onChanged: (isChecked) {
                  context.read<TodoBloc>().add(CompletedTask(id: data.id??0, isCompleted:isChecked!?1:0));
                },
                  activeColor: Colors.blue,

                  controlAffinity: ListTileControlAffinity.leading,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(onPressed: callback,
                icon: const Icon(Icons.delete, color: Colors.red,)),
          )
        ],
      )
  );
}

