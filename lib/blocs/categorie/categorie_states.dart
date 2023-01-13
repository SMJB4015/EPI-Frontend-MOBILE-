import 'package:equatable/equatable.dart';
import 'package:epi_app/models/categorie.dart';

class CategorieStates extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class InitiaState extends CategorieStates{}

class LoadingCat extends CategorieStates{}

class SuccessCatP extends CategorieStates{
  List<CategorieP> catsP ;
  SuccessCatP({this.catsP}) ;
}
class SuccessCatF extends CategorieStates{
  List<CategorieF> catsF ;
  SuccessCatF({this.catsF}) ;
}
class ErrorCat extends CategorieStates{
  String message ;
  ErrorCat({this.message});
}