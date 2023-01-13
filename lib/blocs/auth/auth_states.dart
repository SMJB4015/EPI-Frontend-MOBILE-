import 'package:equatable/equatable.dart';

class AuthStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class LoginInitState extends AuthStates{}

class LoginLoadingState extends AuthStates{}

class UserInState extends AuthStates{
  final String nom ;
  final String token ;

  UserInState({this.nom, this.token});
}
class VisiteurState extends AuthStates{}

class UserRegisterSuccessState extends AuthStates{}

class UserUpdateSuccessState extends AuthStates{}

class UserLoginSuccessState extends AuthStates{}


class LoginErrorState extends AuthStates{
  final String message ;

  LoginErrorState({this.message});
}

