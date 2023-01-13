
import 'package:epi_app/models/panier.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:epi_app/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PanierRepo {

  PasseCmD(Panier panier)async
  {
    var pref= await SharedPreferences.getInstance();
    String token=pref.getString('token');

    var res= await http.post(url+'commande/ajouter/',
        headers: {'Authorization':'Bearer '+token,'Content-Type':'application/json'},
        body: json.encode(panier.toJson()));
    final data= json.decode(res.body);
    if(data['totalHT']!=''){
      return data;

    }else{
      return data['detail'];
    }

  }
  GetCMD(String c)async{
    var pref= await SharedPreferences.getInstance();
    String token=pref.getString('token');
    List<Commande> commandes = [];
    var response = await http.get(
        url+'commande/mescommandes'+c+'/',headers: {'Authorization':'Bearer '+token,'Content-Type':'application/json'});
    var data = json.decode(response.body);
    try{
      if (response.statusCode == 200) {
        data.map((pan) => commandes.add(Commande.fromJson(pan))).toList();
        return commandes;
      }}catch(e){
      return  e ;
    }
  }
}