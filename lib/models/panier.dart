// To parse this JSON data, do
//
//     final panier = panierFromJson(jsonString);

import 'dart:convert';

import 'package:epi_app/models/produit.dart';

Panier panierFromJson(String str) => Panier.fromJson(json.decode(str));

String panierToJson(Panier data) => json.encode(data.toJson());

class Panier {
  Panier({
    this.id,
    this.lignecmds,
    this.infosLiv,
    this.totalHt,
    this.totaltTtc,
  });

  int id;
  List<Lignecmd> lignecmds;
  String infosLiv;
  double totalHt;
  double totaltTtc;

  factory Panier.fromJson(Map<String, dynamic> json) => Panier(
    id: json["id"],
    lignecmds: List<Lignecmd>.from(json["lignecmds"].map((x) => Lignecmd.fromJson(x))),
    infosLiv: json["infos_liv"],
    totalHt: json["totalHT"],
    totaltTtc: json["totaltTTC"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lignesPan": List<dynamic>.from(lignecmds.map((x) => x.toJson())),
    "infos_liv": infosLiv,
    "totalHT": totalHt,
    "totalTTC": totaltTtc,
  };
}
class Commande {
  Commande({
    this.id,
    this.lignecmds,
    this.dateCreation,
    this.etat,
    this.modification,
    this.dateModi,
    this.infosLiv,
    this.totalHt,
    this.totaltTtc,
    this.client,
  });

  int id;
  List<Lignecmd> lignecmds;
  DateTime dateCreation;
  String etat;
  bool modification;
  dynamic dateModi;
  String infosLiv;
  String totalHt;
  String totaltTtc;
  int client;

  factory Commande.fromJson(Map<String, dynamic> json) =>
      Commande(
        id: json["id"],
        lignecmds: List<Lignecmd>.from(json["lignecmds"].map((x) => Lignecmd.fromJson(x))),
        dateCreation: DateTime.parse(json["date_creation"]),
        etat: json["etat"],
        modification: json["modification"],
        dateModi: json["date_modi"],
        infosLiv: json["infos_liv"],
        totalHt: json["totalHT"],
        totaltTtc: json["totaltTTC"],
        client: json["client"],
      );
}
class Lignecmd {
  Lignecmd({
    this.id,
    this.qte,
    this.produit,
  });

  int id;
  int qte;
  Produit produit;

  factory Lignecmd.fromJson(Map<String, dynamic> json) => Lignecmd(
    id: json["produit"],
    qte: json["qte"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "qte": qte,
    "produit": produit.id,
  };
}
