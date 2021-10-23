class Reference{
  String ID_Ref;
  String ParentID;
  String   Code, label;

   Reference({required this.ID_Ref,required this.Code,required this.label,required this.ParentID});
}
List<Reference> listRef =[
  Reference(ID_Ref: "1", Code: "Code", label: "label", ParentID: "0"),
  Reference(ID_Ref: "2", Code: "Code", label: "label", ParentID: "1")
];