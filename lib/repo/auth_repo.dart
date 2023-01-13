import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:epi_app/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthRepo {
  login(String email,String password) async {
  var res= await http.post(url+'client/login/',
      headers: {},
      body: {"username":email,"password":password});
  final data= json.decode(res.body);
  if(data['token']!=''){
    return data;

  }else{
    return data['detail'];
  }


  }
  register(String email,String password,String infos_liv,String tel,String name) async {
    var res= await http.post(url+'client/register/',
        headers: {},
        body: {"username":email,"email":email,"infos_liv":infos_liv,"tel":tel,"name":name,"password":password});
    final data= json.decode(res.body);
    if(data['token']!=''){
      return data;

    }else{
      return data['detail'];
    }


  }
  update(String email,String password,String infos_liv,String tel,String name) async {
    var pref= await SharedPreferences.getInstance();
    String token=pref.getString('token');
    var res= await http.put(url+'client/modifier/',
        headers: {'Authorization':'Bearer '+token,'Content-Type':'application/json'},
        body: json.encode({"email":email,"infos_liv":infos_liv,"tel":tel,"name":name,"password":password}));
    final data= json.decode(res.body);
    if(data['token']!=''){
      return data;

    }else{
      return data['detail'];
    }


  }

}