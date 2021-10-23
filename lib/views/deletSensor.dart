import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_projet/service/DevicesService.dart';
import 'package:mini_projet/service/SensorService.dart';

class DeletSensor extends StatelessWidget
{
  String idSensor;
  DeletSensor(this.idSensor);

  @override
  Widget build(BuildContext context) {
    final sensorService=SensorService();
    return AlertDialog(
      title: Text("Warning"),
      content: Text("are you sure you want delete"),
      actions: <Widget>[
        FlatButton(onPressed: () async{
         await sensorService.deleteSensor(this.idSensor);
        Navigator.of(context).pop(true);
        }, child: Text("yes")),
        FlatButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, child: Text("No"))
      ],
    );
  }
}
