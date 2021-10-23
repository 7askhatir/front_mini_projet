import 'package:flutter/cupertino.dart';

class Devices{
  String ID_Device;
  String Photo;
  String Brand;
  int Memory;
  int Ram;
  bool IsActivated;
  DateTime lastEditTime;

  Devices({required this.ID_Device,required this.Photo,required this.Brand,required this.Memory,required this.Ram,required this.IsActivated,required this.lastEditTime});
}