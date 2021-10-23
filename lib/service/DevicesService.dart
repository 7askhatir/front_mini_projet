import 'dart:convert';

import 'package:mini_projet/models/ApiResponse.dart';
import 'package:mini_projet/models/Devices.dart';
import 'package:http/http.dart' as http;
import 'package:mini_projet/models/SaveDevice.dart';
class DevicesService {

  String url ="http://192.168.43.249:8000/api/devices/";

  //Get AllDevices in Database

  Future<ApiResopnse<List<Devices>>> getAllDevices(){
    return http.get(url)
        .then((data){
          if(data.statusCode == 200){
            final jsonData=json.decode(data.body);
            final devices=<Devices>[];
            for(var item in jsonData){
              final device=Devices(
                  ID_Device: item['id'].toString(),
                  Photo: item['photo'],
                  Brand: item['brand'],
                  Memory: item['memory'],
                  Ram: item['ram'],
                  IsActivated: item['isActivated']==0 ?true:false,
                  lastEditTime: item['updated_at'] != null ? DateTime.parse(item['updated_at']) :DateTime.now()
              );
              devices.add(device);
            }
            return ApiResopnse(data: devices, err: false, status: "All devices");
          }
          return ApiResopnse(data: [], err: true, status: "Erreur");
    });

 }

 //Get Device By ID

  Future<ApiResopnse<Devices>> findDevicesById(String deviceID){
    return  http.get(url+deviceID)
        .then((data){
          if(data.statusCode == 200){
            final jsonData = json.decode(data.body);
            final device=Devices(
                ID_Device: jsonData['id'].toString(),
                Photo: jsonData['photo'],
                Brand: jsonData['brand'],
                Memory: jsonData['memory'],
                Ram: jsonData['ram'],
                IsActivated: jsonData['isActivated'] ==1?true:false,
                lastEditTime: jsonData['updated_at'] != null ? DateTime.parse(jsonData['updated_at']) :DateTime.now());
            return ApiResopnse(data:device, err: false, status: "Sensor ID:");
          }
          return ApiResopnse(data: new Devices(ID_Device: "", Photo: "", Brand: "", Memory: 0, Ram: 0, IsActivated: false, lastEditTime: DateTime.now()), err: true, status: "Errer");
    });
  }

  //Create Device

  Future<ApiResopnse<bool>> createDevice(SaveDevice device){
    return http.post(url,body:device.SaveDevicetoJson())
        .then((value){
      if(value.statusCode == 201) return ApiResopnse(data: true, err: false, status: "Create Device");
      return ApiResopnse(data: false, err: true, status: "erreur");
    });
  }

  //Update Device

  Future<ApiResopnse<bool>> updateDevice(SaveDevice device,String deviceID){
    return http.put(url+deviceID,body: device.SaveDevicetoJson())
        .then((value){
          if(value.statusCode == 204) return ApiResopnse(data: true, err: false, status: "Update Device");
          return ApiResopnse(data: false, err: true, status: "erreur");
    });
  }

  //Delet Device

  Future<ApiResopnse<bool>> deleteDevice(String DeviceID) {
    return http.delete(url+DeviceID).then((data) {
      if (data.statusCode == 204) {
        return ApiResopnse(data: true, err: false, status: "DeviceID is delet");
      }
      return ApiResopnse(data: false, err: true, status: "status");
    });
  }


}