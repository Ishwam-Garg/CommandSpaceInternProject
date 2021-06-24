
import 'package:commandspace_internproject/Constants/Strings/Strings.dart';
import 'package:commandspace_internproject/Models/MovieModel.dart';
import 'package:commandspace_internproject/Services/GetMovieDetails.dart';
import 'package:flutter/material.dart';

class MovieData extends StatefulWidget {

  final Result data;

  MovieData(this.data);

  @override
  _MovieDataState createState() => _MovieDataState();
}

class _MovieDataState extends State<MovieData> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerScrollBox){
          return <Widget>[
            SliverAppBar(
              //title: Text(widget.data.originalTitle,style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),),
              centerTitle: true,
              floating: true,
              expandedHeight: 300,
              flexibleSpace: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(Strings().imageUrl + widget.data.posterPath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            ),
          ];
        },
        body: Container(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(widget.data.originalTitle,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 34),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,),
                    ),
                    SizedBox(height: 20,),
                    Header('Release Date'),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(widget.data.releaseDate.toString().split(" ")[0],
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,),
                    ),
                    SizedBox(height: 20,),
                    Header('Description'),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(widget.data.overview,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,),
                    ),
                    SizedBox(height: 20,),
                    Header('Popularity'),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(widget.data.popularity.toString(),
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,),
                    ),
                    SizedBox(height: 20,),
                    Header('Vote Count & Votes'),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(widget.data.voteCount.toString() + ' / ' + widget.data.voteAverage.toString(),
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,),
                    ),
                  ],
                ),
              ),
            ),
        ),
      ),
      );
  }

  Widget Header(String text)
  {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(text,
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,),
    );
  }


}
