import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:epi_app/blocs/categorie/categorie_events.dart';
import 'package:epi_app/blocs/categorie/categorie_states.dart';
import 'package:epi_app/repo/categorie_repo.dart';

class CatBloc extends Bloc<CategorieEvents,CategorieStates>{
  CatRepo repo ;
  CatBloc(CategorieStates initialState,this.repo) : super(initialState);

  @override
  Stream<CategorieStates> mapEventToState(CategorieEvents event) async* {
    if(event is init){
     yield LoadingCat();

    }else if (event is GetCatP){
      yield LoadingCat();
      try{
        var cats= await repo.fetchCatP();
        if(cats!=null){
          yield SuccessCatP(catsP: cats);}
        else{
          yield LoadingCat();
        };

      }catch(e){
        yield ErrorCat(message: e.toString()) ;
      }

    }
    else if (event is GetCatF){
      yield LoadingCat();
      try{
        var cats= await repo.fetchCatF(event.id);
        if(cats!=null){
          yield SuccessCatF(catsF: cats);}
        else{
          yield LoadingCat();
        };

      }catch(e){
        yield ErrorCat(message: e.toString()) ;
      }

    }
  }

}