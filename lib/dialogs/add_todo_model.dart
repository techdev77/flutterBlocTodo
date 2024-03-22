import 'package:flutter/material.dart';

class FlutterDialog {
  BuildContext context;
  String title;
  Function(TextEditingController textEditingController) callback;
  TextEditingController textEditController=TextEditingController();
   FlutterDialog({required this.context,required this.title,required this.callback});

  void show(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextField(
                    controller: textEditController,
                    decoration:  InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText:title,
                      // label: Text(title),

                    ),
                  ),
                ),
                const SizedBox(height: 20,),
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
                                  side: BorderSide(color: Colors.grey)
                              )),
                        ),
                        child: const Text("Cancel",style: TextStyle(color: Colors.black),
                        )),
                    const SizedBox(width: 10,),
                    TextButton(onPressed:() {
                      Navigator.pop(context);
                      callback(textEditController);
                    },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(color: Colors.grey)
                              )),
                        ),
                        child: const Text("Add",style: TextStyle(color: Colors.black),
                        )),
                  ],
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
