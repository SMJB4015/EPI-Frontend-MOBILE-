import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class AuthEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class StartEvent extends AuthEvents{}
class LoginButtonPressed extends AuthEvents{
  final String email ;
  final String password ;

  LoginButtonPressed({this.email, this.password});
}
class RegisterButtonPressed extends AuthEvents {
  final String email ;
  final String password ;
  final String tel ;
  final String infos_liv;
  final String nom;

  RegisterButtonPressed(
      {this.email, this.password, this.tel, this.infos_liv, this.nom});
}

class UpdateButtonPressed extends AuthEvents {
  final String email ;
  final String password ;
  final String tel ;
  final String infos_liv;
  final String nom;

  UpdateButtonPressed(
      {this.email, this.password, this.tel, this.infos_liv, this.nom});
}
class DecoButtonPressed extends AuthEvents{}
