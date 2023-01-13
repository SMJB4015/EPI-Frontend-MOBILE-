



import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:epi_app/blocs/panier/panier_events.dart';
import 'package:epi_app/blocs/panier/panier_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Commandes extends StatefulWidget{
  final String Char;

  const Commandes({Key key, this.Char}) : super(key: key);

  @override
  _CommandesList createState() => _CommandesList();
}
class _CommandesList extends State<Commandes>{
  PanierBloc blocPan;
  @override
  void initState() {
    blocPan=BlocProvider.of<PanierBloc>(context);
    blocPan.add(GETCMD(char: widget.Char));
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return BlocBuilder<PanierBloc,PanierStates>(builder: (context,state){
      if(state is LoadingPan){
        return Padding(
          padding: const EdgeInsets.all(180.0),
          child: CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,),
        );
      }else if(state is SuccessRecuE){
        return Scaffold(
          appBar: AppBar(title: Text('Commandes en attente'),backgroundColor: Colors.deepOrangeAccent,),
          body: Row(

              children:<Widget>[Expanded(child: SizedBox
                (height: 400,child:
              ListView.builder(itemCount: state.commandes.length,scrollDirection: Axis.vertical ,itemBuilder: (context,index){
                DateTime date= state.commandes[index].dateCreation ;
                return Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Card(borderOnForeground: true,shadowColor: Colors.black,
                            child: Container(decoration: BoxDecoration(color: Colors.deepOrangeAccent,borderRadius:BorderRadius.circular(15) ),child: Expanded(
                                child: SizedBox(height: 100,width: 403,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                        Padding(padding: EdgeInsets.only(left: 10,top: 10),child: Text(
                                          'Ref: '+state.commandes[index].id.toString(),
                                          style: TextStyle(
                                              color: Colors.black87, fontWeight: FontWeight.w800,fontSize: 20),
                                        ),),Padding(padding: EdgeInsets.only(left: 20,top: 10),child:Row(
                                          children: [
                                            Text(
                                              'Date: '+date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString()+' : '+date.hour.toString()+':'+date.minute.toString()+':'+date.second.toString(),
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ],
                                        ) ,),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(padding: EdgeInsets.only(left: 20,top: 10),
                                                  child: Padding(padding: EdgeInsets.only(left: 20),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'HT: ',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 15
                                                          ),
                                                        ),Text(
                                                          state.commandes[index].totalHt,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 20
                                                          ),
                                                        ),Text(
                                                          ' TTC: ',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 15
                                                          ),
                                                        ),Text(
                                                          state.commandes[index].totaltTtc,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 20
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                      ),Padding(padding: EdgeInsets.only(right: 20),child:  RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          onPressed: (){
                                          },
                                          padding: EdgeInsets.all(12),
                                          color: Colors.grey,
                                          child: Row(
                                            children: [Icon(Icons.arrow_forward_ios),
                                              Text('Details',style: TextStyle(color: Colors.black),),
                                            ],
                                          )
                                      ))
                                    ],
                                  ),
                                ))))
                        ],
                      ),
                    ]);
                ;}
              )
              )
              )
              ]

          ),
        );
      }else if(state is SuccessRecuV){
        return Scaffold(
          appBar: AppBar(title: Text('Commandes Vérifiées'),backgroundColor: Colors.deepOrangeAccent,),
          body: Row(

              children:<Widget>[Expanded(child: SizedBox
                (height: 400,child:
              ListView.builder(itemCount: state.commandes.length,scrollDirection: Axis.vertical ,itemBuilder: (context,index){
              DateTime date= state.commandes[index].dateCreation ;
                return Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Card(borderOnForeground: true,shadowColor: Colors.black,
                            child: Container(decoration: BoxDecoration(color: Colors.deepOrangeAccent,borderRadius:BorderRadius.circular(15) ),child: Expanded(
                                child: SizedBox(height: 100,width: 403,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                        Padding(padding: EdgeInsets.only(left: 10,top: 10),child: Text(
                                          'Ref: '+state.commandes[index].id.toString(),
                                          style: TextStyle(
                                              color: Colors.black87, fontWeight: FontWeight.w800,fontSize: 20),
                                        ),),Padding(padding: EdgeInsets.only(left: 20,top: 10),child:Row(
                                          children: [
                                            Text(
                            'Date: '+date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString()+' : '+date.hour.toString()+':'+date.minute.toString()+':'+date.second.toString(),
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ],
                                        ) ,),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(padding: EdgeInsets.only(left: 20,top: 10),
                                                  child: Padding(padding: EdgeInsets.only(left: 20),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'HT: ',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 15
                                                          ),
                                                        ),Text(
                                                          state.commandes[index].totalHt,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 20
                                                          ),
                                                        ),Text(
                                                          ' TTC: ',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 15
                                                          ),
                                                        ),Text(
                                                          state.commandes[index].totaltTtc,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 20
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                      ),Column(children: [ Padding(padding: EdgeInsets.only(right: 20),child:  RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          onPressed: (){
                                          },
                                          padding: EdgeInsets.all(12),
                                          color: Colors.grey,
                                          child: Row(
                                            children: [Icon(Icons.arrow_forward_ios),
                                              Text('Details',style: TextStyle(color: Colors.black),),
                                            ],
                                          )
                                      ))],)
                                    ],
                                  ),
                                ))))
                        ],
                      ),
                    ]);
                ;}
              )
              )
              )
              ]

          ),
        );
      }else if (state is ErrorPan){
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
        }else{
        return Container();
      }
        });
  }

}