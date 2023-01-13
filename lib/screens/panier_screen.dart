import 'dart:async';
import 'dart:math';

import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:epi_app/blocs/auth/auth_events.dart';
import 'package:epi_app/blocs/auth/auth_states.dart';
import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:epi_app/blocs/panier/panier_events.dart';
import 'package:epi_app/blocs/panier/panier_states.dart';
import 'package:epi_app/composants/Produit_List.dart';
import 'package:epi_app/models/panier.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';


class PanierSC extends StatefulWidget {
  @override
  _PanierSC createState() => _PanierSC();
}
class _PanierSC extends State<PanierSC>{
  final _formKey = GlobalKey<FormState>();
  PanierBloc blocPan ;
  AuthBloc blocA;
  TextEditingController infos=TextEditingController();

  @override
  void initState() {
  blocPan=BlocProvider.of<PanierBloc>(context) ;
  blocA=BlocProvider.of<AuthBloc>(context) ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final info = TextFormField(controller: infos,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(prefixIcon: Icon(Icons.home_filled,color: Colors.deepOrangeAccent,),

          filled: true,
          hintStyle: TextStyle(color: Colors.black54),
          hintText:'Infos Livraion',
          focusColor: Colors.white,
          fillColor: Colors.grey),
      validator: (value) {
        if (value!='') {
          return null ;
        }else{
          return('Enter Infos Livraison');

        }
      },
    );

  return Scaffold(
    appBar: AppBar(
        title:Text('Panier',style: TextStyle(color: Colors.white),),
        elevation: 0,
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: IconThemeData(color: Colors.white54),
        actions:<Widget>[Row(
          children: [
            BlocBuilder<AuthBloc,AuthStates>(builder: (context,state){
              if(state is VisiteurState){
                return IconButton(icon: Icon(Icons.person),color: Colors.white70,onPressed: (){
                  Navigator.push(context, MaterialPageRoute<Login>(builder: (_)=>
                      MultiBlocProvider(providers: [
                        BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Login())));
                });
              }else if(state is UserInState){
                return IconButton(icon: Icon(Icons.logout),color: Colors.white70,onPressed: (){
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
            })]
          ,)]
    ),
    body: BlocListener<PanierBloc,PanierStates>(listener: (context,state){
      if (state is SuccessEnvoi){
      return  Flushbar(
      title: "Commande",
      message: "Commande est Passé ",
      duration: Duration(seconds: 4),
      backgroundColor: Colors.black,
      icon: Icon(Icons.check, color: Colors.green,),
      )
      ..show(context).then((value) => Navigator.pop(context));


      }
    },
      child: BlocBuilder<PanierBloc,PanierStates>(builder: (context,state){
      if (state is IniState){
        return Column(
          children: [SizedBox(height: 180,),
            Card(
              child: InkWell(
                onTap: (){},
                child: ListTile(
                  tileColor: Colors.deepOrangeAccent,
                  title: Text("Il n' y a pas des Lignes Commandes "),
                  leading: Icon(Icons.close),
                ),
              ),
            ),
          ],
        );

      }else if (state is ExistPan){

        Panier p =state.panier;
        double ttc=p.totaltTtc;
        double tth=p.totalHt;
        return ListView(children: [Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
            },
            child: Row(
              children: [
                Container(margin: EdgeInsets.only(top: 15,left: 20,right: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                          Radius.circular(35))),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(children: [
                          Text('TotalHT:   ',style:TextStyle(fontWeight: FontWeight.bold)),
                          Text(tth.toString(),style:TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold)),
                          Text('   TotalTTC:   ',style:TextStyle(fontWeight: FontWeight.bold)),
                          Text(ttc.toString(),style:TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold)),
                        ],


                        ),
                      )),
                ),IconButton(icon: Icon(Icons.delete_forever,size: 40,),onPressed: (){
                  blocPan.add(IniPan());
                },)
              ],
            ),
          ),
        ), SizedBox(height: 20),
          Column(
            children: [
              SizedBox(height: 400,
                child: ListView.builder(itemCount: state.panier.lignecmds.length,scrollDirection: Axis.vertical ,itemBuilder: (context,index) {
                  return Dismissible(key:Key(state.panier.lignecmds[index].produit.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Spacer(),
                            Icon(Icons.delete),
                          ],
                        ),
                      ),
                    onDismissed: (direction){
                    if(index<1){
                      blocPan.add(IniPan());
                    }else {
                      blocPan.add(SuppLignePan(panier: state.panier,produit: state.panier.lignecmds[index].produit,tt: state.tt));

                      return Flushbar(
                        title: "Supprimé",
                        message: "Produit a etait supprimé du Panier",
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.black,
                        icon: Icon(Icons.delete, color: Colors.red,),
                      )
                        ..show(context);
                    }},
                    child: ProdPan(LignePan: state.panier.lignecmds[index]),
                  );
                }),
              )
            ],
          ),Form(key:_formKey,child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 24.0,right: 24.0),
                child: info,
              ),
              BlocBuilder<AuthBloc,AuthStates>(builder: (context,state){
                if(state is UserInState){

                  return Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              setState(() {
                            p=Panier(id: p.id,lignecmds: p.lignecmds,infosLiv: infos.text,totalHt: p.totalHt,totaltTtc: p.totaltTtc);

                          });
                          }
                            blocPan.add(PassCMD(panier:p));
                          },
                          padding: EdgeInsets.all(12),
                          color: Colors.deepOrangeAccent,
                          child: Row(
                              children: [Icon(Icons.arrow_forward_ios),
                                Text('Passer La commande',style: TextStyle(color: Colors.black),)])
                      )
                  );
                }else if(state is VisiteurState){
                  return Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute<Login>(builder: (_)=>
                                MultiBlocProvider(providers: [
                                  BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Login())));
                          },
                          padding: EdgeInsets.all(12),
                          color: Colors.deepOrangeAccent,
                          child: Row(
                              children: [Icon(Icons.arrow_forward_ios),
                                Text('Passer La commande',style: TextStyle(color: Colors.black),)])
                      )
                  );
                }
              }),
            ],
          )),

        ],);




      }else if (state is LoadingPan){
        return Padding(
          padding: const EdgeInsets.all(180.0),
          child: CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,),
        );
      }else if(state is ErrorPan){
        return Text(state.message);
      }else if(state is SuccessEnvoi){
        return Container();
      }

      }),
    ));

}
}
