import 'package:epi_app/blocs/auth/auth_events.dart';
import 'package:epi_app/blocs/auth/auth_states.dart';
import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:epi_app/blocs/panier/panier_events.dart';
import 'package:epi_app/blocs/panier/panier_states.dart';
import 'package:epi_app/screens/panier_screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:epi_app/blocs/categorie/categorie_bloc.dart';
import 'package:epi_app/blocs/categorie/categorie_states.dart';
import 'package:epi_app/blocs/categorie/categorie_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:epi_app/blocs/produits/produit_bloc.dart';
import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:epi_app/screens/login_screen.dart';
import 'package:epi_app/composants/Cat_List.dart';


class CatFilsList extends StatefulWidget{
 final int idd ;


 const CatFilsList({Key key, this.idd}) : super(key: key);

  @override
  _CatFilsList createState() => _CatFilsList() ;

}
class _CatFilsList extends State<CatFilsList>{
 CatBloc blocCat ;
 AuthBloc blocA;
 PanierBloc blocPan ;
 @override
  void initState() {
  blocCat=BlocProvider.of<CatBloc>(context) ;
  blocPan=BlocProvider.of<PanierBloc>(context);
  blocA=BlocProvider.of<AuthBloc>(context) ;
  blocCat.add(GetCatF(id: widget.idd));
  super.initState();
  }
  @override
  void dispose() {
    blocCat.add(GetCatP());
    blocCat.close();
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
            child: new Text('Sous-Categroies',style: TextStyle(fontSize: 50,backgroundColor: Colors.deepOrangeAccent),)),),
      listCat
    ],),);
  }

}
Widget listCat=BlocBuilder<CatBloc,CategorieStates>(builder: (context,state){
  if(state is InitiaState){
    return CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,);
  }else if (state is LoadingCat){
    return CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,);
  }else if (state is SuccessCatF){
    if(state.catsF.length>0) {
      return Row(

          children: <Widget>[Expanded(child: SizedBox
            (height: 200, child:
          GridView.builder(itemCount: state.catsF.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return CatFView(cat: state.catsF[index]);
              }
          )
          )
          )
          ]

      );
    }else{
      return Padding(padding:  EdgeInsets.only(top:150.0),
        child: Container(
            alignment: Alignment.topCenter,
            child: new Text("Il n'y a pas des Sous-Categroies",style: TextStyle(fontSize: 20,),)),);
    }
  }else if (state is ErrorCat){
    return (Text(state.message));

  }

}
);
