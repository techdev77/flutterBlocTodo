import 'package:flutter/material.dart';

class MyAlertDialog {
  BuildContext context;
  String title;
  Function() callback;
  MyAlertDialog({required this.context,required this.title,required this.callback});

  void show(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          backgroundColor: Colors.white,
          title:Text(title,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: const BorderSide(color: Colors.grey)
                            )),
                      ),
                      child: const Text("No",style: TextStyle(color: Colors.black),
                      )),
                  const SizedBox(width: 10,),
                  TextButton(onPressed:() {
                    Navigator.pop(context);
                    callback();
                  },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: const BorderSide(color: Colors.grey)
                            )),
                      ),
                      child: const Text("Yes",style: TextStyle(color: Colors.black),
                      )),
                ],
              )
            ],
          ),


        );
      },
    );
  }
}
