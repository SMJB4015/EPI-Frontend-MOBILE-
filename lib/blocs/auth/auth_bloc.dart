import 'package:epi_app/blocs/auth/auth_events.dart';
import 'package:epi_app/blocs/auth/auth_states.dart';
import 'package:epi_app/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents,AuthStates>{
  AuthRepo repo;
  AuthBloc(AuthStates initialState,this.repo) : super(initialState);

  @override
  Stream<AuthStates> mapEventToState(AuthEvents event) async*{
    var pref= await SharedPreferences.getInstance();
    if(event is StartEvent){
      if((pref.getString('nom')!='Visiteur') && (pref.getString('nom')!=null)){
        yield UserInState(nom: pref.getString('nom'),token:pref.getString('token') ) ;
      }else{
        if((pref.getString('nom')==null)){
          pref.setString('nom', 'Visiteur');
          pref.setString('token', 'Visiteur' );
          pref.setInt('id', 0);
          pref.setString('email', 'Visiteur');
        }
        yield VisiteurState() ;
      }
    }else if (event is LoginButtonPressed){
      yield LoginLoadingState();
      var data = await repo.login(event.email,event.password);
      if(data['isAdmin']==true || data['isAdmin']==false ){
        pref.setString('nom', data['name']);
        pref.setString('token', data['token']);
        pref.setInt('id', data['id']);
        pref.setString('infos', data['infosliv']);
        pref.setString('email', data['username']);
        yield UserInState(nom: data['name'],token: data['token']);
      }else{
        yield LoginErrorState(message: data['detail']);
      }


    }
    else if (event is RegisterButtonPressed){
      yield LoginLoadingState();
      var data = await repo.register(event.email,event.password,event.infos_liv,event.tel,event.nom);
      if(data['isAdmin']==true || data['isAdmin']==false ){
        yield UserRegisterSuccessState();
      }else{
        yield LoginErrorState(message: data['detail']);
      }


    }   else if (event is UpdateButtonPressed){
      yield LoginLoadingState();
      var data = await repo.update(event.email,event.password,event.infos_liv,event.tel,event.nom);
      if(data['isAdmin']==true || data['isAdmin']==false ){
        yield UserUpdateSuccessState();
      }else{
        yield LoginErrorState(message: data['detail']);
      }


    }
    else if(event is DecoButtonPressed){
      pref.setString('nom', 'Visiteur');
      pref.setString('token', 'Visiteur' );
      pref.setInt('id', 0);
      pref.setString('infos', 'default');
      pref.setString('email', 'Visiteur');
      yield VisiteurState() ;
    }

  }

  }


