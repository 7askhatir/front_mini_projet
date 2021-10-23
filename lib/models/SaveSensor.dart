 class SaveSensor{
   String id_Ref;
   String id_Device;
   DateTime lastEditTime;
   String photo;

   SaveSensor({required this.id_Ref,required this.id_Device,required this.photo,required this.lastEditTime});
   Map<String, dynamic> SaveSensortoJson() =>
       {
          'photo': this.photo,
          'reference_id': this.id_Device,
          'device_id':this.id_Ref,
       };
   }