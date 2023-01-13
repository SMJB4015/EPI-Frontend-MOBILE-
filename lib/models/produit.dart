class Produit {
  int id ;
  String nom;
  String ref ;
  String description ;
  int categorie ;
  String marque ;
  String tva  ;
  bool promotion ;
  String prix ;
  String prixpromo ;
  String image ;
  String commentaire ;
  String date_creation ;

  Produit({
    this.id,
    this.nom,
    this.ref,
    this.description,
    this.categorie,
    this.marque,
    this.tva,
    this.promotion,
    this.prix,
    this.prixpromo,
    this.image,
    this.commentaire,
    this.date_creation
  });

  Produit.fromJson(Map<String,dynamic>json){
    id=json['id'];
    nom=json['nom'];
    ref=json['ref'];
    description=json['description'];
    categorie=json['categorie'];
    marque=json['marque'];
    tva=json['tva'];
    promotion=json['promotion'];
    prix=json['prix'];
    prixpromo=json['prixpromo'];
    image=json['image'];
    commentaire=json['commentaire'];
    date_creation=json['date_creation'];
  }
  Map<String,dynamic>toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=id;
    data['nom']=nom;
    data['ref']=ref;
    data['description']=description;
    data['categorie']=categorie;
    data['marque']=marque;
    data['tva']=tva;
    data['promotion']=promotion;
    data['prix']=prix;
    data['prixpromo']=prixpromo;
    data['image']=image;
    data['commentaire']=commentaire;
    data['date_creation']=date_creation;
  }
}
