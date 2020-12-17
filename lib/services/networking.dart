import 'dart:convert';

import 'package:http/http.dart' as http;



class NetworkHelper {

  final String url;


  NetworkHelper(this.url);


  Future getData()async{
    try{
      var respnse = await http.get(url);
      String data= respnse.body;

      print(respnse.statusCode);
      //print(respnse.body);
      var  decodedData = jsonDecode(data);
      return jsonDecode(data);
    }catch(e){
      print(e);
    }


  }


}