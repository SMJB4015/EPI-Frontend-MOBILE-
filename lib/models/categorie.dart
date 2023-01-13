class CategorieP {
  int id ;
  String name;
  bool parent ;

  CategorieP({this.id, this.name, this.parent});

  CategorieP.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    parent=json['parent'];
  }
  Map<String,dynamic>toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=id;
    data['name']=name;
    data['parent']=parent;
  }
}
class CategorieF{
  int id ;
  String name;
  int parent ;


  CategorieF(this.id, this.name, this.parent);

  CategorieF.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    parent=json['parent'];
  }
  Map<String,dynamic>toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=id;
    data['name']=name;
    data['parent']=parent;
  }
}

