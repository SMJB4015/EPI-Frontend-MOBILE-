import 'package:epi_app/models/produit.dart';
import 'package:epi_app/models/panier.dart';
import 'package:equatable/equatable.dart';

class PanierEvents extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => [];

}
class IniPan extends PanierEvents{}
class AddLignePan extends PanierEvents{
  int qte ;
  Produit produit ;
  Panier panier;
  int tt ;

  AddLignePan({this.panier,this.qte, this.produit,this.tt});
}
class SuppLignePan extends PanierEvents{
  Panier panier;
  Produit produit ;
  int tt ;
  SuppLignePan({this.panier,this.produit,this.tt});
}
class PassCMD extends PanierEvents{
  Panier panier;

  PassCMD({this.panier});
}
class GETCMD extends PanierEvents{
   String char;

  GETCMD({this.char});
}


