import 'dart:convert';

import 'package:mini_projet/models/ApiResponse.dart';
import 'package:mini_projet/models/SaveSensor.dart';
import 'package:mini_projet/models/SensorsList.dart';
import 'package:http/http.dart' as http;
class SensorService {

  String url ="http://192.168.43.249:8000/api/sensors/";

  //Get All Sensours

  Future<ApiResopnse<List<Sensors>>> getAllSensors(){
    return http.get(Uri.parse(url))
        .then((data){
      if(data.statusCode == 200){
            final jsonData=json.decode(data.body);
            final sensors=<Sensors>[];
            for(var item in jsonData){
             final sensor=Sensors(
                 id_Sensor: item['id'].toString(),
                 id_Ref: item['reference_id'].toString(),
                 id_Device: item['device_id'].toString() ,
                 lastEditTime: item['updated_at'] != null ? DateTime.parse(item['updated_at']) :DateTime.now(),
                 photo: item['photo']);
             sensors.add(sensor);
        };
            return ApiResopnse(data: sensors, err: false, status: "All Sensor");
        }
      print(data.statusCode);
          return ApiResopnse(data: [], err: true, status: "Erreur "+data.statusCode.toString());
    });
  }

  //Get Sensor By Id


  Future<ApiResopnse<Sensors>> getSencerById(String SensirID){
    return http.get(url+SensirID)
        .then((data){
          if(data.statusCode == 200){
            final jsonData = json.decode(data.body);
            final sensor =Sensors(
                id_Sensor: jsonData['id'].toString(),
                id_Ref: jsonData['reference_id'].toString(),
                id_Device: jsonData['device_id'].toString(),
                lastEditTime: jsonData['updated_at'] != null ? DateTime.parse(jsonData['updated_at']) :DateTime.now(),
                photo: jsonData['photo']);
          return ApiResopnse(data:sensor, err: false, status: "Sensor ID:");
          }
          return ApiResopnse(data: new Sensors(id_Sensor: "", id_Ref: "", id_Device: "", lastEditTime: DateTime.now(), photo: ""), err: true, status: "Errer");
    });
  }

  //Create Sensor

  Future<ApiResopnse<bool>> createSensor(SaveSensor sensor){
    return http.post(url,body:sensor.SaveSensortoJson())
        .then((value){
          if(value.statusCode == 200) return ApiResopnse(data: true, err: false, status: "Sensor Created");
          return ApiResopnse(data: false, err: true, status: "erreur");
    });
  }

  //Update Sensor

  Future<ApiResopnse<bool>> updateSensor(SaveSensor sensor,String sensorID){
    return http.put(url+sensorID,body: sensor.SaveSensortoJson())
        .then((value){
      if(value.statusCode == 204) return ApiResopnse(data: true, err: false, status: "Sensor Updute");
      return ApiResopnse(data: false, err: true, status: "erreur");
    });
  }
  //Delet Sensor

  Future<ApiResopnse<bool>> deleteSensor(String SensorID) {
    return http.delete(url+SensorID).then((data) {
      if (data.statusCode == 204) {
          return ApiResopnse(data: true, err: false, status: "Sensor is delet");
      }
      return ApiResopnse(data: false, err: true, status: "status");
    });
  }
}