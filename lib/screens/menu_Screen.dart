import 'package:epi_app/blocs/contact/contact_bloc.dart';
import 'package:epi_app/blocs/contact/contact_states.dart';
import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:epi_app/blocs/panier/panier_states.dart';
import 'package:epi_app/repo/contact_repo.dart';
import 'package:epi_app/repo/panier_repo.dart';
import 'package:epi_app/screens/boite_screen.dart';
import 'package:epi_app/screens/commandes_screen.dart';
import 'package:epi_app/screens/update_Screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:epi_app/blocs/auth/auth_events.dart';
import 'package:epi_app/blocs/auth/auth_states.dart';
import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';






class Menu extends StatefulWidget {
  @override
  _Menu createState() => _Menu() ;

}
class _Menu extends State<Menu>{
  AuthBloc blocA ;
  @override
  void initState() {
    blocA=BlocProvider.of<AuthBloc>(context);
    blocA.add(StartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthStates>(builder: (context,state){
      if(state is UserInState){
        return Scaffold(
            backgroundColor: Colors.white70,
            body:ListView(children: [

              Column(children: [Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    print("CLICKED");
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(35))),
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.all(
                              Radius.circular(35))),
                      child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(children: [Icon(
                              Icons.person,size: 30,
                              color: Colors.white,),
                              SizedBox(height: 10,),
                              Text(state.nom,style:TextStyle(fontWeight: FontWeight.bold))],

                            ),
                          )),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute<Commandes>(builder: (_)=>
                          MultiBlocProvider(providers: [BlocProvider(create: (context) => PanierBloc(IniState(), PanierRepo())),
                            BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Commandes(Char: 'V',))));
                    },
                    child: ListTile(
                      tileColor: Colors.deepOrangeAccent,
                      title: Text('Mes Commandes vérifiées'),
                      leading: Icon(Icons.all_inbox),
                    ),
                  ),
                )
                ,
                Card(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute<Commandes>(builder: (_)=>
                          MultiBlocProvider(providers: [BlocProvider(create: (context) => PanierBloc(IniState(), PanierRepo())),
                            BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Commandes(Char: 'E',))));
                    },
                    child: ListTile(
                      tileColor: Colors.deepOrangeAccent,
                      title: Text('Mes Commandes en attente'),
                      leading: Icon(Icons.all_inbox_outlined),
                    ),
                  ),
                )],),
              Card(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute<Boite>(builder: (_)=>
                        MultiBlocProvider(providers: [BlocProvider(create: (context) => ContactBloc(Begin(), ContactRepo())),
                          BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Boite())));
                  },
                  child: ListTile(
                    tileColor: Colors.deepOrangeAccent,
                    title: Text('Mes Messages'),
                    leading: Icon(Icons.email),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute<Update>(builder: (_)=>
                        MultiBlocProvider(providers: [
                          BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Update())));
                  },
                  child: ListTile(
                    tileColor: Colors.deepOrangeAccent,
                    title: Text('Modifier Mes infos'),
                    leading: Icon(Icons.edit),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    blocA.add(DecoButtonPressed());
                    return Flushbar(
                      title:  "Deconnecté",
                      message:  "Au Revoir Cher Client ",
                      duration:  Duration(seconds: 1),
                      backgroundColor: Colors.black,
                      icon: Icon(Icons.check,color: Colors.green,),
                    )..show(context).then((value) => Navigator.pop(context));
                  },
                  child: Container(margin: EdgeInsets.only(left: 60,right: 60),
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.all(
                            Radius.circular(35))),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 50,right: 50),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(children: [Icon(
                            Icons.logout,size: 30,
                          ),
                            Text('Deconnexion',style:TextStyle(fontWeight: FontWeight.bold))],

                          ),
                        )),
                  ),
                ),
              ),
            ],)
        );
      }
      else if(state is VisiteurState){
        return Scaffold(
            backgroundColor: Colors.white70,
            body:ListView(children: [

              Column(children: [Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(35))),
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.all(
                              Radius.circular(35))),
                      child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(children: [Icon(
                              Icons.person,size: 30,
                              color: Colors.white,),
                              SizedBox(height: 10,),
                              Text('Visiteur',style:TextStyle(fontWeight: FontWeight.bold))],

                            ),
                          )),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: (){},
                    child: ListTile(
                      tileColor: Colors.deepOrangeAccent,
                      title: Text('Contact Administration'),
                      leading: Icon(Icons.all_inbox),
                    ),
                  ),
                )
                ,
                ],),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute<Login>(builder: (_)=>
                        MultiBlocProvider(providers: [
                          BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Login())));
                  },
                  child: Container(margin: EdgeInsets.only(left: 60,right: 60),
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.all(
                            Radius.circular(35))),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 50,right: 50),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(children: [Icon(
                            Icons.login,size: 30,
                          ),
                            Text('Connexion',style:TextStyle(fontWeight: FontWeight.bold))],

                          ),
                        )),
                  ),
                ),
              ),
            ],)
        );
      }else{return Container();}
    }) ;


  }

}