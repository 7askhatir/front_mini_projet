class SaveDevice{
  String Photo;
  String Brand;
  String Memory;
  String Ram;
  bool IsActivated;

  SaveDevice({required this.Photo,required this.Brand,required this.Memory,required this.Ram,required this.IsActivated});

  Map<String, dynamic> SaveDevicetoJson() =>
      {
        'photo': this.Photo,
        'brand': this.Brand,
        'memory':this.Memory,
        'ram':this.Ram,
        'isActivated':"1",
      };
}