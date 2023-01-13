import 'package:equatable/equatable.dart';


class CategorieEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class init extends CategorieEvents{}

class GetCatP extends CategorieEvents{}

class GetCatF extends CategorieEvents{
  final int id ;

  GetCatF({this.id});
}