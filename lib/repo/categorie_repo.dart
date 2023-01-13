import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:epi_app/constantes.dart';
import 'package:epi_app/models/categorie.dart';
class CatRepo {
  Future<List<CategorieP>> fetchCatP() async {
    List<CategorieP> catsP = [];
    var response = await http.get(url + 'categorie/');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data.map((cat) => catsP.add(CategorieP.fromJson(cat))).toList();
      return catsP;
    }
  }

  Future<List<CategorieF>> fetchCatF(int id) async {
    List<CategorieF> catsF = [];
    var response = await http.get(url + 'categorie/'+id.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data.map((cat) => catsF.add(CategorieF.fromJson(cat))).toList();
      return catsF;
    }
  }
}