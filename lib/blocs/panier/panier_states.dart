import 'package:equatable/equatable.dart';
import 'package:epi_app/models/panier.dart';

class PanierStates extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class IniState extends PanierStates{
  Panier panier ;
  int tt;

  IniState({this.panier,this.tt}) ;
}
class LoadingPan extends PanierStates{}


class ExistPan extends PanierStates {
  Panier panier;
  int tt;

  ExistPan({this.panier,this.tt});
}
class SuccessEnvoi extends PanierStates{}

class SuccessRecuV extends PanierStates{
  List<Commande> commandes ;

  SuccessRecuV({this.commandes});
}
class SuccessRecuE extends PanierStates{
  List<Commande> commandes ;

  SuccessRecuE({this.commandes});
}

class ErrorPan extends PanierStates {
  String message ;
  ErrorPan({this.message});
}