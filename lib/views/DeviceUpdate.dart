import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_projet/models/Devices.dart';
import 'package:mini_projet/models/SaveDevice.dart';
import 'package:mini_projet/service/DevicesService.dart';
import 'package:mini_projet/views/DevicesList.dart';

class DevideUpdate extends StatefulWidget {
  final String idDevice;
  DevideUpdate(this.idDevice);


  @override
  _DevideUpdateState createState() => _DevideUpdateState(idDevice);
}

class _DevideUpdateState extends State<DevideUpdate> {
  _DevideUpdateState(id);
  bool get isEditing =>widget.idDevice!="";
  bool chek=true;
  final deviceServise = DevicesService();
  TextEditingController UrlController =TextEditingController();
  TextEditingController BrandController =TextEditingController();
  TextEditingController MemoryController =TextEditingController();
  TextEditingController RamController =TextEditingController();
  late Devices d;
@override
  void initState() {
  super.initState();
  if(this.isEditing){

    this.deviceServise.findDevicesById(widget.idDevice).then((value) {
       setState(() {
         d=value.data;
         UrlController.text=d.Photo;
         BrandController.text=d.Brand;
         MemoryController.text=d.Memory.toString();
         RamController.text=d.Ram.toString();
         chek=d.IsActivated;
       });
     });
  }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.isEditing?"Update Device":"Create Device")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            children: <Widget>[
              TextField(
                controller: UrlController,
                decoration: InputDecoration(
                    hintText: 'URL Image'
                ),
              ),
              Container(height: 8),
              TextField(
                controller: BrandController,
                decoration: InputDecoration(
                    hintText: 'Brand'
                ),
              ),
              Container(height: 16),
              TextField(
                controller: MemoryController,
                decoration: InputDecoration(
                    hintText: 'Memory'
                ),
              ),
              Container(height: 24),
              TextField(
                controller: RamController,
                decoration: InputDecoration(
                    hintText: 'Ram'
                ),
              ),
              Container(height: 32),
              Row(
                children: [

                  Text("Is Activated",style: TextStyle(fontSize: 15),),
                  SizedBox(height: 10),
                  Checkbox(value: chek, onChanged: (_){
                    setState(() {
                      chek = (!chek);
                    });
                  })
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 35,
                child: RaisedButton(
                  child: Text(this.isEditing?'Update':'Create', style: TextStyle(color: Colors.white)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if(isEditing) {
                      SaveDevice device =SaveDevice(Photo: UrlController.text, Brand: BrandController.text, Memory: MemoryController.text, Ram: RamController.text, IsActivated: chek);
                      final result =await deviceServise.updateDevice(device, widget.idDevice);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DevicesList()));

                    }
                    else{
                      SaveDevice device =SaveDevice(Photo: UrlController.text, Brand: BrandController.text, Memory: MemoryController.text, Ram: RamController.text, IsActivated: chek);
                      final reselt =await deviceServise.createDevice(device);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DevicesList()));
                    }
                  },
                ),
              )
            ]
        ),

      ),

    );
  }
}

