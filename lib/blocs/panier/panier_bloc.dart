import 'package:epi_app/models/panier.dart';
import 'package:epi_app/repo/panier_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:epi_app/blocs/panier/panier_events.dart';
import 'package:epi_app/blocs/panier/panier_states.dart';
import 'package:epi_app/models/produit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PanierBloc extends Bloc<PanierEvents,PanierStates>{
  PanierRepo repo ;

  PanierBloc(PanierStates initialState,this.repo) : super(initialState);

  @override
  Stream<PanierStates> mapEventToState(PanierEvents event) async* {
    var pref= await SharedPreferences.getInstance();
    String inf;
    if(pref.containsKey('infos')){
      inf=pref.getString('infos');
    }else{
      inf='default';
    }
    if(event is IniPan){
      yield LoadingPan();
      List<Lignecmd> LignesCmds=[] ;
      int tt=0;
      Panier panier=Panier(id: 0,lignecmds: LignesCmds,infosLiv: inf,totalHt: 0,totaltTtc: 0);
      yield IniState(panier: panier,tt: tt);
    }else if(event is AddLignePan){
     Lignecmd lignePan= Lignecmd(id: event.produit.id,produit: event.produit,qte: event.qte);
     Panier pan= event.panier;
     int ttt =event.tt+event.qte;
     pan.lignecmds.add(lignePan) ;
     double prix ;
     if(event.produit.promotion==true){
       prix= (double.parse(event.produit.prixpromo))*event.qte;
     }else{
       prix=(double.parse(event.produit.prix))*event.qte;
     }
     pan.totalHt=pan.totalHt+prix ;
     prix=prix+(((prix/100)*double.parse(event.produit.tva))*event.qte);
     pan.totaltTtc=pan.totaltTtc+prix;
     yield IniState(panier: pan,tt: ttt);
     yield ExistPan(panier:pan, tt: ttt);

    }else if(event is SuppLignePan){
      Panier pan=event.panier;
      int ttt=event.tt;
      Lignecmd lignePan=pan.lignecmds.firstWhere((e) => e.produit==event.produit );
      ttt=ttt-lignePan.qte;
      if(ttt<0){ttt=0;}
      pan.lignecmds.removeWhere((element) => element.produit==event.produit);
      double prix ;
      if(event.produit.promotion==true){
        prix= (double.parse(event.produit.prixpromo))*lignePan.qte;
      }else{
        prix=(double.parse(event.produit.prix))*lignePan.qte;
      }
      pan.totalHt=pan.totalHt-prix ;
      prix=prix+(((prix/100)*double.parse(event.produit.tva))*lignePan.qte);
      pan.totaltTtc=pan.totaltTtc-prix;

      yield IniState(panier: pan,tt: ttt);
      yield ExistPan(panier:pan, tt: ttt);

    }else if(event is PassCMD){
      yield LoadingPan();
      var data= await repo.PasseCmD(event.panier);
      if(data['etat']=='N'||data['etat']=='V'||data['etat']=='E'){
        yield SuccessEnvoi();
      }
      else{
        yield ErrorPan(message: data['detail']);
      }
    }else if(event is GETCMD){
      yield LoadingPan();
      try{
      var commandes= await repo.GetCMD(event.char);
      yield ErrorPan(message: commandes.toString());
      if(event.char=='V')
      {if(commandes!=null)
      {
        yield SuccessRecuV(commandes: commandes);
      }
      else{
        yield ErrorPan(message: 'Il n y a Pas des Commandes verifiées ');
      }
      }else
        {
          if(commandes!=null){
        yield SuccessRecuE(commandes: commandes);
      }
      else{
        yield ErrorPan(message: 'Il y a Pas de Commandes En Attente');
      }}

    }catch(e){
        yield ErrorPan(message: e.toString());

      }}
  }

}