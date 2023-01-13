
import 'dart:convert';

List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
  Contact({
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.tel,
    this.sujet,
    this.message,
    this.recp,
  });

  int id;
  String nom;
  String prenom;
  String email;
  String tel;
  String sujet;
  String message;
  int recp;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"],
    nom: json["nom"],
    email: json["email"],
    tel: json["tel"],
    sujet: json["sujet"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom": nom,
    "prenom": prenom,
    "recp": recp,
    "email": email,
    "tel": tel,
    "sujet": sujet,
    "message": message,
  };
}
