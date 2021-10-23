import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_projet/models/ApiResponse.dart';
import 'package:mini_projet/models/Devices.dart';
import 'package:mini_projet/models/Reference.dart';
import 'package:mini_projet/models/SaveSensor.dart';
import 'package:mini_projet/models/SensorsList.dart';
import 'package:mini_projet/service/DevicesService.dart';
import 'package:mini_projet/service/ReferenceService.dart';
import 'package:mini_projet/service/SensorService.dart';
import 'package:mini_projet/views/Sensors-list.dart';

class Sensorupate extends StatefulWidget{
  final String idSensor;
  Sensorupate(this.idSensor);

  @override
  State<Sensorupate> createState() => _SensorupateState();
}

class _SensorupateState extends State<Sensorupate> {
  final referenceService=ReferenceService();
  final deviceServise = DevicesService();
  final sensorService =SensorService();
  late ApiResopnse<List<Reference>> referenceResponse =ApiResopnse(data: [], err: false, status: "status") ;
  late ApiResopnse<List<Devices>> devicesResponse=ApiResopnse(data: [], err: false, status: "status") ;
  String _itemDevice = "1";
  String _itemRefe ="1";
  bool get isEditing =>widget.idSensor!="";
  late Sensors sensor;

  TextEditingController textEditingController =TextEditingController();
  @override
  void initState() {
    super.initState();


    if(this.isEditing){
      this.sensorService.getSencerById(widget.idSensor).then((value){
        setState(() {
          sensor=value.data;
          textEditingController.text=sensor.photo;
          _itemDevice=sensor.id_Device.toString();
          _itemRefe=sensor.id_Ref.toString();
        });
      });
    }
  }
  fetchReferences() async {
    referenceResponse = await referenceService.getAllReferences();
  }
  fetchDevices() async{
    devicesResponse = await deviceServise.getAllDevices();
  }






  Widget build(BuildContext context) {
    setState(() {
      fetchReferences();
      fetchDevices();
    });
    return Scaffold(
      appBar: AppBar(title: Text(this.isEditing?"Update Sensors":"Create Sensors")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: 'URL Image'
              ),
            ),
            Container(height: 8),
            Text("ID Device",style: TextStyle(fontSize: 15),),

            DropdownButton(
              isExpanded:true,
              items: devicesResponse.data.map((device) {
                return DropdownMenuItem(value:device.ID_Device,child: Text(device.ID_Device));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  this._itemDevice=value.toString();
                });
              },
              value: this._itemDevice,


            ),
            Container(height: 16),
            Text("Reference",style: TextStyle(fontSize: 15),)
            ,
            DropdownButton(
              isExpanded:true,
              items: referenceResponse.data.map((ref) {
                return DropdownMenuItem(value:ref.ID_Ref,child: Text(ref.ID_Ref));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  this._itemRefe =value.toString();
                });
              },
              value: this._itemRefe,
            ),

            Container(height: 24),

            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text(this.isEditing?'Update':'Create', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                 if(isEditing) {
                   SaveSensor sensor =SaveSensor(id_Ref: _itemRefe, id_Device: _itemDevice, photo: textEditingController.text, lastEditTime: DateTime.now());
                   final result = sensorService.updateSensor(sensor, widget.idSensor);
                   print(result);
                   Navigator.of(context).push(MaterialPageRoute(builder: (_) => SensorsList()));

                 }
                 else{
                   SaveSensor sensor =SaveSensor(id_Ref: _itemRefe, id_Device: _itemDevice, photo: textEditingController.text, lastEditTime: DateTime.now());
                   final result = await sensorService.createSensor(sensor);
                   Navigator.of(context).push(MaterialPageRoute(builder: (_) => SensorsList()));

                 }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}