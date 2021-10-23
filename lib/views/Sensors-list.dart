import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_projet/models/ApiResponse.dart';
import 'package:mini_projet/models/SensorsList.dart';
import 'package:mini_projet/service/SensorService.dart';
import 'package:mini_projet/views/DevicesList.dart';
import 'package:mini_projet/views/Sensor-detail.dart';
import 'package:mini_projet/views/Sensor-upate.dart';
import 'package:mini_projet/views/deletDevice.dart';
import 'package:mini_projet/views/deletSensor.dart';

class SensorsList extends StatefulWidget {

  @override
  State<SensorsList> createState() => _SensorsListState();
}

class _SensorsListState extends State<SensorsList> {
  final serviceSensor=SensorService();
  bool isLoading =false;
  ApiResopnse<List<Sensors>> _SensorsListApi =ApiResopnse(data: [], err: false, status: "status");

  String formatDateTime(DateTime time){
  return '${time.day}/${time.month}/${time.year}';
}
 @override
  void initState() {
    _fetchSensors();
    super.initState();
  }
  _fetchSensors() async{
    setState(() {
      isLoading = true;
    });
    _SensorsListApi = await serviceSensor.getAllSensors();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),

              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Sensors'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SensorsList()));
              },
            ),
            ListTile(
              title: const Text('Devices'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => DevicesList()));
              },
            ),
          ],
        ),
      ),
      appBar:AppBar(title: Text("list of the Sensours")),
      floatingActionButton:FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => Sensorupate("")));
      }, child: Icon(Icons.add)
      ),
      body: Builder(
        builder: (_) {
          if(this.isLoading){
            return Center(child: CircularProgressIndicator());
          }
          if(_SensorsListApi.err){
            return Center(child: Text(_SensorsListApi.status));
          }
          return ListView.builder(itemCount:_SensorsListApi.data.length,itemBuilder:(context,index){
            Sensors sensor = _SensorsListApi.data[index];
            return Dismissible(
              key: ValueKey(sensor.id_Sensor),
              direction: DismissDirection.startToEnd,
              onDismissed:(direction){

              },
              confirmDismiss:(direction) async {
                final result = await showDialog(context: context, builder: (_)=>DeletSensor(sensor.id_Sensor));
                return result;
              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 16),
                child: Align(child: Icon(Icons.delete, color: Colors.white), alignment: Alignment.centerLeft,),
              ),
              child: Card(
                child: ListTile(
                  title: Text(sensor.id_Sensor),
                  subtitle: Text(formatDateTime(sensor.lastEditTime)),
                  leading:Image.network(sensor.photo,
                  ) ,
                  trailing: Icon(Icons.arrow_forward_rounded),
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SensorDetail(sensor)));
                  },
                ),
              ),
            );
          });

        },
      )

    );
  }
}
