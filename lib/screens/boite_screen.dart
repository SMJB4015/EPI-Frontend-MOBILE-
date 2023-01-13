
import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:epi_app/blocs/contact/contact_bloc.dart';
import 'package:epi_app/blocs/contact/contact_events.dart';
import 'package:epi_app/blocs/contact/contact_states.dart';
import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Boite extends StatefulWidget{
  @override
  _Boite createState() => _Boite();
}

class _Boite extends State<Boite>{


  AuthBloc blocA ;
  ContactBloc blocC;
  @override
  void initState(){
    blocA=BlocProvider.of<AuthBloc>(context);
    blocC=BlocProvider.of<ContactBloc>(context);
    blocC.add(Reception()) ;
    super.initState() ;
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(body: BlocBuilder<ContactBloc,ContactStates>(builder:(context,state){
      if(state is ReceptionState){

        return Row(

            children:<Widget>[Expanded(child: SizedBox
              (height: 200,child:
            ListView.builder(itemCount: state.messages.length,scrollDirection: Axis.vertical ,itemBuilder: (context,index){

              return Card(child: ListTile(tileColor: Colors.deepOrangeAccent,leading: Text(state.messages[index].sujet,),subtitle: Text(state.messages[index].message),),)
              ;}
            )
            )
            )
            ]

        );
      }else if(state is LoadingC){
        return Padding(
          padding: const EdgeInsets.all(180.0),
          child: CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,),
        );
      }else if(state is ContactErrorState){
        return Column(
          children: [SizedBox(height: 180,),
            Card(
              child: InkWell(
                onTap: (){},
                child: ListTile(
                  tileColor: Colors.grey,
                  title: Text(state.message),
                  leading: Icon(Icons.close),
                ),
              ),
            ),
          ],
        );
      }
    }
    ));
  }
}