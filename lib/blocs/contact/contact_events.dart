
import 'package:epi_app/models/contact.dart';
import 'package:equatable/equatable.dart';

class ContactEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class Envoi extends ContactEvents{
  String message ;
  String sujet ;
  String email ;
  String tel ;
  int recp ;
  String nom ;

  Envoi({this.message, this.sujet, this.email, this.tel, this.nom,this.recp});

}

class Reception extends ContactEvents{

}