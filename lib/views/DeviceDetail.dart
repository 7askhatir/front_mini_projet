import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_projet/models/Devices.dart';
import 'package:mini_projet/models/SensorsList.dart';
import 'package:mini_projet/views/DeviceUpdate.dart';
import 'package:mini_projet/views/Sensors-list.dart';

class DeviceDetail extends StatelessWidget {
  String formatDateTime(DateTime time){
    return '${time.day}/${time.month}/${time.year}';
  }
  Devices devices;
  DeviceDetail(this.devices);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(devices.ID_Device.toString()),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent,width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(devices.Photo),
                  )
              ),
            ),
            Column(
              children: [
                Text("Brand : ${devices.Brand}",style: TextStyle(fontSize: 20),),
                Text("Memory : ${devices.Memory} GB" ,style: TextStyle(fontSize: 20)),
                Text("Ram :${devices.Ram } GB" ,style: TextStyle(fontSize: 20)),
                Text("IsActivated :" +(devices.IsActivated == true ? "Active" : "Desactiver" ),style: TextStyle(fontSize: 20))


              ],
            ),
            Card(
              child: ListTile(
                  title: Text("Last update :  ${formatDateTime(devices.lastEditTime)}")
              ),
            ),
            Container(height: 30),
            SizedBox(
              height: 35,
              child: RaisedButton(
                child: Text('Update', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => DevideUpdate(devices.ID_Device.toString())));
                },
              ),
            ),
            Text("")
          ],
        ),
      ),

    );
  }
}


