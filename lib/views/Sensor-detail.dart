import 'package:flutter/material.dart';
import 'package:mini_projet/models/ApiResponse.dart';
import 'package:mini_projet/models/Devices.dart';
import 'package:mini_projet/models/Reference.dart';
import 'package:mini_projet/models/SensorsList.dart';
import 'package:mini_projet/service/DevicesService.dart';
import 'package:mini_projet/service/ReferenceService.dart';
import 'package:mini_projet/views/DeviceDetail.dart';
import 'package:mini_projet/views/Sensor-upate.dart';
import 'package:mini_projet/views/Sensors-list.dart';

class SensorDetail extends StatefulWidget {
  Sensors sensors;
  SensorDetail(this.sensors);

  @override
  State<SensorDetail> createState() => _SensorDetailState();
}

class _SensorDetailState extends State<SensorDetail> {
  final serviceDevive = DevicesService();
  final serviceRef =ReferenceService();
  ApiResopnse<Reference> referenceService =ApiResopnse(data: new Reference(ID_Ref: "", Code: "", label: "", ParentID: ""), err: true, status: "Errer");
   ApiResopnse<Devices> apiResopnse = ApiResopnse(data: new Devices(ID_Device: "", Photo: "", Brand: "", Memory: 0, Ram: 0, IsActivated: false, lastEditTime: DateTime.now()), err: true, status: "Errer");
   String formatDateTime(DateTime time){
    return '${time.day}/${time.month}/${time.year}';
  }
  @override
  void initState() {
    super.initState();
    _getDevice(widget.sensors.id_Device);
    _getRef(widget.sensors.id_Ref);
  }
  _getDevice(String id) async {
    this.apiResopnse =await serviceDevive.findDevicesById(id);
  }
  _getRef(String id) async {
    this.referenceService=await serviceRef.findReferenceById(id);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sensors.id_Sensor),
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
                    image: NetworkImage(widget.sensors.photo),
                  )
              ),
            ),
            Card(
              child: ListTile(
                title: Text("ID_Device :  ${apiResopnse.data.ID_Device}"),
                subtitle: Text(formatDateTime(apiResopnse.data.lastEditTime)),
                leading:Image.network(apiResopnse.data.Photo) ,
                trailing: Icon(Icons.circle,color:apiResopnse.data.IsActivated? Colors.green :Colors.red ,size: 15,),
                onTap:(){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => DeviceDetail(apiResopnse.data)));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("ID_Reference :  ${referenceService.data.ID_Ref.toString()}"),
                subtitle: Column(
                  children: [
                    Text("Code : ${referenceService.data.Code}"),
                    Text("label : ${referenceService.data.label} ")
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Last update :  ${formatDateTime(widget.sensors.lastEditTime)}")
              ),
            ),
            Container(height: 30),
            SizedBox(
              height: 35,
              child: RaisedButton(
                child: Text('Update', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => Sensorupate(widget.sensors.id_Sensor)));
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


