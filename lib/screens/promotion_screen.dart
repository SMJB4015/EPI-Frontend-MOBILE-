import 'package:epi_app/blocs/auth/auth_events.dart';
import 'package:epi_app/blocs/auth/auth_states.dart';
import 'package:epi_app/blocs/contact/contact_bloc.dart';
import 'package:epi_app/blocs/contact/contact_states.dart';
import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:epi_app/blocs/panier/panier_events.dart';
import 'package:epi_app/blocs/panier/panier_states.dart';
import 'package:epi_app/composants/Produit_List.dart';
import 'package:epi_app/repo/auth_repo.dart';
import 'package:epi_app/repo/categorie_repo.dart';
import 'package:epi_app/repo/contact_repo.dart';
import 'package:epi_app/repo/panier_repo.dart';
import 'package:epi_app/repo/produit_repo.dart';
import 'package:epi_app/screens/contact_Screen.dart';
import 'package:epi_app/screens/panier_screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:epi_app/blocs/categorie/categorie_bloc.dart';
import 'package:epi_app/blocs/categorie/categorie_states.dart';
import 'package:epi_app/blocs/categorie/categorie_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:epi_app/blocs/produits/produit_bloc.dart';
import 'package:epi_app/blocs/produits/produit_states.dart';
import 'package:epi_app/blocs/produits/produit_events.dart';
import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:epi_app/screens/login_screen.dart';
import 'package:epi_app/composants/Cat_List.dart';

import 'homeScreen.dart';
import 'menu_Screen.dart';


class ProdPromoList extends StatefulWidget{


  const ProdPromoList({Key key}) : super(key: key);

  @override
  _ProdPromoList createState() => _ProdPromoList() ;

}
class _ProdPromoList extends State<ProdPromoList>{
  ProduitBloc blocP ;
  PanierBloc blocPan ;
  AuthBloc blocA;
  @override
  void initState() {
    blocPan=BlocProvider.of<PanierBloc>(context);
    blocA=BlocProvider.of<AuthBloc>(context) ;
    blocP=BlocProvider.of<ProduitBloc>(context) ;
    blocP.add(GetPromo());
    super.initState();
  }
  @override
  void dispose() {
    blocP.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text('EPI STORE',style: TextStyle(color: Colors.white),),
        elevation: 0,
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: IconThemeData(color: Colors.white54),
        actions:<Widget>[Row(
          children: [
            BlocBuilder<AuthBloc,AuthStates>(builder: (context,state){
              if(state is VisiteurState){
                return IconButton(padding: EdgeInsets.only(left: 20),icon: Icon(Icons.person),color: Colors.white70,onPressed: (){
                  Navigator.push(context, MaterialPageRoute<Login>(builder: (_)=>
                      MultiBlocProvider(providers: [
                        BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Login())));
                });
              }else if(state is UserInState){
                return IconButton(padding: EdgeInsets.only(left: 20),icon: Icon(Icons.logout),color: Colors.white70,onPressed: (){
                  blocA.add(DecoButtonPressed());
                  Flushbar(
                    title:  "Deconnecté",
                    message:  "Au Revoir Cher Client ",
                    duration:  Duration(seconds: 2),
                    backgroundColor: Colors.black,
                    icon: Icon(Icons.check,color: Colors.green,),
                  )..show(context);
                }) ;
              }
            }) ,BlocBuilder<PanierBloc,PanierStates>(builder:(context,state){
              if(state is IniState){
                return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                  IconButton(padding: EdgeInsets.only(left: 20),icon: Icon(Icons.shopping_cart),color: Colors.white,onPressed: (){
                    Navigator.push(context, MaterialPageRoute<PanierSC>(builder: (_)=>
                        MultiBlocProvider(providers: [BlocProvider.value(value: BlocProvider.of<ProduitBloc>(context)),
                          BlocProvider.value(value: BlocProvider.of<PanierBloc>(context))
                          ,BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: PanierSC())));
                  }),Container(
                    margin : EdgeInsets.only(right:0),
                    child: Text('0',style: TextStyle(color: Colors.black),) ,
                    padding: EdgeInsets.only(bottom: 10,right: 10),
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(80)
                    ),
                  ),
                ],);
              }else if (state is ExistPan){
                return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                  IconButton(padding: EdgeInsets.only(left: 20),icon: Icon(Icons.shopping_cart),color: Colors.white,onPressed: (){
                    Navigator.push(context, MaterialPageRoute<PanierSC>(builder: (_)=>
                        MultiBlocProvider(providers: [BlocProvider.value(value: BlocProvider.of<ProduitBloc>(context)),
                          BlocProvider.value(value: BlocProvider.of<PanierBloc>(context))
                          ,BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: PanierSC())));
                  }),Container(
                    margin : EdgeInsets.only(right:0),
                    child: Text(state.tt.toString(),style: TextStyle(color: Colors.black),) ,
                    padding: EdgeInsets.only(bottom: 10,right: 10),
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(80)
                    ),
                  ),
                ],);
              }else if( state is SuccessEnvoi ){
                blocPan.add(IniPan());
              }
            } ),
          ]
          ,)]
    ),
      body: ListView(children: [
        Padding(padding:  EdgeInsets.only(top:10.0),
          child: Container(
              alignment: Alignment.center,
              child: new Text('Promotions',style: TextStyle(fontSize: 50,backgroundColor: Colors.deepOrangeAccent),)),),
        ListPdC
      ],),);
  }

}Widget ListPdC = BlocBuilder<ProduitBloc,ProduitStates>(
    builder: (context,state){
      if(state is InitialState){
        return CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,);
      }else if (state is Loading){
        return CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,);
      }else if (state is SuccessPromo){
        if(state.produits.length>0){return Row(

            children:<Widget>[Expanded(child: SizedBox
              (height: 500,child:
            GridView.builder(itemCount: state.produits.length,scrollDirection: Axis.vertical ,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemBuilder: (context,index){

              return ProdView(produit: state.produits[index] )
              ;}
            )
            )
            )
            ]

        );}else{
          return Padding(padding:  EdgeInsets.only(top:150.0),
            child: Container(
                alignment: Alignment.topCenter,
                child: new Text("Il n'y a pas de produits En Promotions",style: TextStyle(fontSize: 20,),)),);
        }



      }else if (state is Error){
        return (Text(state.message));

      }

    }
);