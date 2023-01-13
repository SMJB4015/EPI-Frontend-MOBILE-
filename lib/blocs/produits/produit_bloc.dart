import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:epi_app/blocs/produits/produit_events.dart';
import 'package:epi_app/blocs/produits/produit_states.dart';
import 'package:epi_app/repo/produit_repo.dart';


class ProduitBloc extends Bloc<ProduitEvents,ProduitStates>{
  ProduitRepo repo ;

  ProduitBloc(ProduitStates initialState,this.repo) : super(initialState);

  @override
  Stream<ProduitStates> mapEventToState(ProduitEvents event) async* {
    if (event is GetNv){
      yield Loading();
      try{
          var produits= await repo.fetchProdNv();
          if (produits != null) {
            yield SuccessNv(produits: produits);
          }
          else{
            yield Loading() ;
          }
      } catch(e){
        yield Error(message: e.toString());
      }


    }
    if (event is GetPdt){
      yield Loading();
      try{
        var produits= await repo.fetchProdCat(id:event.id);
        if (produits != null) {
          yield SuccessPdt(produits: produits);
        }
        else{
          yield Loading() ;
        }
      } catch(e){
        yield Error(message: e.toString());
      }


    }
    if (event is GetPromo){
      yield Loading();
      try{
        var produits= await repo.fetchProdPromo();
        if (produits != null) {
          yield SuccessPromo(produits: produits);
        }
        else{
          yield Loading() ;
        }
      } catch(e){
        yield Error(message: e.toString());
      }


    }
  }
}