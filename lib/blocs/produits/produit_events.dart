import 'package:equatable/equatable.dart';


class ProduitEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class GetNv extends ProduitEvents{}
class GetPdt extends ProduitEvents{
  int id ;

  GetPdt({this.id});
}
class GetPromo extends ProduitEvents{}