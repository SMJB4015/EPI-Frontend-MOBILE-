
import 'package:epi_app/blocs/contact/contact_events.dart';
import 'package:epi_app/blocs/contact/contact_states.dart';
import 'package:epi_app/repo/contact_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactBloc extends Bloc<ContactEvents,ContactStates>{
  ContactRepo repo;
  ContactBloc(ContactStates initialState,this.repo) : super(initialState);

  @override
  Stream<ContactStates> mapEventToState(ContactEvents event) async*{
    bool isNumeric(String s) {
      if(s == null) {
        return false;
      }
      return double.parse(s, (e) => null) != null;
    }
    if(event is Envoi){
      yield LoadingC() ;
      var data= await repo.envoi(event.email, event.nom, event.tel, event.message, event.sujet,1);
      if(data=false){
        yield ContactErrorState(message: 'error') ;
      }else{
        yield EnvoiState();
      }
    }else if(event is Reception){
      yield LoadingC() ;
      try{
        var messages= await repo.recept();
        if (messages!=null) {
          yield ReceptionState(messages: messages);
        }
        else{
          yield ContactErrorState(message: 'Boite messagerie est vide');
        }
      } catch(e){
        yield ContactErrorState(message: e.toString());
      }


    }
  }
}