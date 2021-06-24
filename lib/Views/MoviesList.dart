import 'package:commandspace_internproject/Constants/Strings/Strings.dart';
import 'package:commandspace_internproject/Models/MovieModel.dart';
import 'package:commandspace_internproject/Services/GetMovieDetails.dart';
import 'package:commandspace_internproject/Views/MovieViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoviesList extends StatefulWidget {

  final int year;
  MoviesList(this.year);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {

  Future<MovieModel> _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _model = apiCall().getMovie(widget.year.toString());
  }


  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies ' + widget.year.toString()),
        centerTitle: true,
      ),
      body: FutureBuilder<MovieModel>(
        future: _model,
        builder: (context,snapshot){
          if(snapshot.hasData)
            {
              return ListView.builder(
                  itemCount: snapshot.data.results.length,
                  itemBuilder: (context,index){
                      try{

                        var sorted = snapshot.data.results;
                        sorted.sort((a,b)=>a.popularity.compareTo(b.popularity));
                        //var data = snapshot.data.results[index];
                        var data = sorted[index];
                        int year_p = int.parse(data.releaseDate.toString().split("-")[0]);


                        if(now.isAfter(data.releaseDate))
                        {
                          print(true);
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieData(data)));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.3,
                              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey,

                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(Strings().imageUrl + data.posterPath),
                                  fit: BoxFit.fill,
                                ),

                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black12,
                                      Colors.black,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(data.originalTitle,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),)),
                                    Text(
                                      data.overview,
                                      style: TextStyle(color: Colors.white),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(data.voteCount.toString(),style: TextStyle(color: Colors.white),),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(data.voteAverage.toString(),style: TextStyle(color: Colors.white),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        else
                        {
                          return Container();
                        }
                      }
                      catch(e)
                    {
                      print(e.toString());
                      return Container();
                    }


                  });
            }
          else if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator());
          }
          else
            {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('No Movies Found'),
                  ),
                ],
              );
            }
        },
      )
    );
  }
}
