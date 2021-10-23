import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_projet/models/ApiResponse.dart';
import 'package:mini_projet/models/Devices.dart';
import 'package:mini_projet/models/SensorsList.dart';
import 'package:mini_projet/service/DevicesService.dart';
import 'package:mini_projet/views/DeviceDetail.dart';
import 'package:mini_projet/views/DeviceUpdate.dart';
import 'package:mini_projet/views/Sensor-detail.dart';
import 'package:mini_projet/views/Sensor-upate.dart';
import 'package:mini_projet/views/Sensors-list.dart';
import 'package:mini_projet/views/deletDevice.dart';

class DevicesList extends StatefulWidget {
  @override
  State<DevicesList> createState() => _DevicesListState();
}


class _DevicesListState extends State<DevicesList> {
  final serviceDevive = DevicesService();
  bool isLoading =false;
  late ApiResopnse<List<Devices>> devicesListApi = ApiResopnse(data: [], err: false, status: "status");
  String formatDateTime(DateTime time){
    return '${time.day}/${time.month}/${time.year}';
  }
  @override
  void initState() {
    _fetchDevices();
    super.initState();
  }
  _fetchDevices() async {
    setState(() {
      isLoading = true;
    });
     devicesListApi = await serviceDevive.getAllDevices();

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
      appBar:AppBar(title: Text("list of the Devices")),
      floatingActionButton:FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => DevideUpdate("")));
      }, child: Icon(Icons.add)
      ),
      body:Builder(
        builder: (_){
          if(this.isLoading){
            return  Center(child: CircularProgressIndicator());
          }
          if(devicesListApi.err){
            return Center(child: Text(devicesListApi.status));
          }
          return ListView.builder(itemCount:devicesListApi.data.length,itemBuilder:(context,index){
            Devices device=devicesListApi.data[index];
            return Dismissible(
              key: ValueKey(device.ID_Device),
              direction: DismissDirection.startToEnd,
              onDismissed:(direction){

              },
              confirmDismiss:(direction) async {
                final result = await showDialog(context: context, builder: (_)=>DeletDevice(device.ID_Device));
                return result;
              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 16),
                child: Align(child: Icon(Icons.delete, color: Colors.white), alignment: Alignment.centerLeft,),
              ),
              child:  Card(
                child: ListTile(
                  title: Text(device.ID_Device.toString()),
                  subtitle: Text(formatDateTime(device.lastEditTime)),
                  leading:Image.network(device.Photo,

                  ) ,
                  trailing: Icon(Icons.circle,color:device.IsActivated? Colors.green :Colors.red ,size: 15,),
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  DeviceDetail(device)));
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
