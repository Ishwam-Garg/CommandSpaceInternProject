import 'package:commandspace_internproject/Views/MoviesList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YearSelectScreen extends StatefulWidget {

  @override
  _YearSelectScreenState createState() => _YearSelectScreenState();
}

class _YearSelectScreenState extends State<YearSelectScreen> {

  final _formkey = GlobalKey<FormState>();

  String year;

  @override
  Widget build(BuildContext context) {

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDate = formatter.format(now);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.2),
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(),
                        disabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        labelText: 'Enter Year',
                        labelStyle: TextStyle(fontSize: 18),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        alignLabelWithHint: true,
                      ),
                    onSaved: (value){
                        year = value;
                    },
                    onChanged: (value){
                        year = value;
                    },
                    validator: (value) {

                        if(int.parse(value.toString()) <= 0)
                          {
                            return 'Enter A Valid Year';
                          }
                        else if(int.parse(value.toString()) > int.parse(formattedDate))
                          {
                            return 'Enter A Valid Year';
                          }

                    },
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    if(_formkey.currentState.validate())
                      {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MoviesList(year)));
                      }
                    else{

                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.shade500
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.movie_outlined,color: Colors.white,),
                          SizedBox(width: 20,),
                          Text('Get Movies',style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
