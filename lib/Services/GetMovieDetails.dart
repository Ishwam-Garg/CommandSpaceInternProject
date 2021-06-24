import 'package:commandspace_internproject/Models/MovieModel.dart';
import 'package:http/http.dart' as http;
import 'package:commandspace_internproject/Constants/Strings/Strings.dart';
class apiCall{

  Future<MovieModel> getMovie(String year) async{

    var url = Uri.parse(Strings().movieApi);

    var client = http.Client();

    try{
        var response = await client.get(url);

        if(response.statusCode == 200)
          {

            var jsonString = response.body;

            //print(response.body);

            final movieModel = movieModelFromJson(jsonString);

            return movieModel;
          }
        else
          return null;

    }
    catch(e)
    {
          print('Error is :' + e.toString());
    }

  }



}