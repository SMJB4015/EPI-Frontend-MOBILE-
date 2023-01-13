import 'package:equatable/equatable.dart';
import 'package:epi_app/models/produit.dart';

class ProduitStates extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class InitialState extends ProduitStates{}
class Loading extends ProduitStates{}

class SuccessNv extends ProduitStates{
  List<Produit> produits ;
  SuccessNv({this.produits}) ;
}
class SuccessPdt extends ProduitStates {
  List<Produit> produits;

  SuccessPdt({this.produits});
}
class SuccessPromo extends ProduitStates{
  List<Produit> produits ;
  SuccessPromo({this.produits}) ;
}
class Error extends ProduitStates {
  String message ;
  Error({this.message});
}