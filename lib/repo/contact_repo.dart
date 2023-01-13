
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:epi_app/constantes.dart';
import 'package:epi_app/models/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ContactRepo {

  envoi(String email,String nom,String tel,String message,String sujet,int recp) async{
    var pref= await SharedPreferences.getInstance();
    String token=pref.getString('token');
    var res ;
    if(token!='Visiteur'){
       res= await http.post(url+'contact/creation/',
        headers: {'Authorization':'Bearer '+token,'Content-Type':'application/json'},
        body: jsonEncode({"sujet":sujet,"email":email,"message":message,"tel":tel,"nom":nom,"prenom":nom,'recp':recp}));}
    else{
       res= await http.post(url+'contact/creation/',
        headers: {'Content-Type':'application/json'},
        body: jsonEncode({"sujet":sujet,"email":email,"message":message,"tel":tel,"nom":nom,"prenom":nom,'recp':recp}));

      }

    final data= json.decode(res.body);
     bool verif=true ;
    if(res.statusCode==200){
      return verif;

    }else{
      verif=false;
      return verif ;
    }


  }
     recept() async {
    var pref= await SharedPreferences.getInstance();
    String token=pref.getString('token');
    List<Contact> contacts = [];
    var response = await http.get(
        url+'contact/boite/',headers: {'Authorization':'Bearer '+token,'Content-Type':'application/json'});
    var data = json.decode(response.body);
    try{
    if (response.statusCode == 200) {
      data.map((cont) => contacts.add(Contact.fromJson(cont))).toList();

        return contacts;


    }}catch(e){
      return  null ;
    }
  }

  }

