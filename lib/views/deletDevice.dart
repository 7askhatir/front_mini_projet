import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_projet/service/DevicesService.dart';

class DeletDevice extends StatelessWidget {
  String idDevice;
  DeletDevice(this.idDevice);

  @override
  Widget build(BuildContext context) {
    final deviceServise = DevicesService();
    return AlertDialog(
      title: Text("Warning"),
      content: Text("are you sure you want delete"),
      actions: <Widget>[
        FlatButton(onPressed: () async{
          await deviceServise.deleteDevice(this.idDevice);
        Navigator.of(context).pop(true);
        }, child: Text("yes")),
        FlatButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, child: Text("No"))
      ],
    );
  }
}
