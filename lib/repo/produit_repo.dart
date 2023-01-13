import 'package:epi_app/models/produit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:epi_app/constantes.dart';
class ProduitRepo {
  Future<List<Produit>> fetchProdNv() async {
    List<Produit> produits = [];
    var response = await http.get(url + 'produit/nouveau/');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data.map((produit) => produits.add(Produit.fromJson(produit))).toList();
      return produits;
    }
  }

  Future<List<Produit>> fetchProdCat({int id}) async {
    List<Produit> produits = [];
    var response = await http.get(url + 'categorie/catFilM/' + id.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data.map((produit) => produits.add(Produit.fromJson(produit))).toList();
      return produits;
    }
  }

  Future<Produit> FetchProdDt({int id}) async {
    Produit produit;
    var response = await http.get(
        url + 'produit/detail/' + id.toString() + '/');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data.map((produit) => produit = (Produit.fromJson(produit)));
      return produit;
    }
  }
  Future<List<Produit>> fetchProdPromo() async {
    List<Produit> produits = [];
    var response = await http.get(url + 'produit/promotionM/');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data.map((produit) => produits.add(Produit.fromJson(produit))).toList();
      return produits;
    }
  }
}