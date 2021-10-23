import 'dart:convert';

import 'package:mini_projet/models/ApiResponse.dart';
import 'package:mini_projet/models/Devices.dart';
import 'package:mini_projet/models/Reference.dart';
import 'package:http/http.dart' as http;

class ReferenceService{

  String url ="http://192.168.43.249:8000/api/reference/";

  //Get All References

  Future<ApiResopnse<List<Reference>>> getAllReferences(){
     return http.get(url)
         .then((data) {
           if(data.statusCode == 200){
             final jsonData=json.decode(data.body);
             final references =<Reference>[];
             for(var item in jsonData){
               final ref =Reference(
                   ID_Ref: item['id'].toString(),
                   Code: item['code'],
                   label: item['label'],
                   ParentID: item['parent_id'].toString());
               references.add(ref);
             }
             return ApiResopnse(data: references, err: false, status: "All References");
           }
           return ApiResopnse(data: [], err: true, status: "Erreur");
     });
  }
  //Get Reference By Id

  Future<ApiResopnse<Reference>> findReferenceById(String refID){
    return http.get(url+refID)
        .then((data){
      if(data.statusCode ==200){
        final jsonData = json.decode(data.body);
        final reference=Reference(
            ID_Ref: jsonData['id'].toString(),
            Code: jsonData['code'],
            label: jsonData['label'],
            ParentID: jsonData['parent_id'].toString());
        return ApiResopnse(data:reference, err: false, status: "get Reference By ID:");
      }
      return ApiResopnse(data: new Reference(ID_Ref: "", Code: "", label: "", ParentID: ""), err: true, status: "Errer");
    });
  }

}