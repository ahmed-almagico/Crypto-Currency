import 'package:dio/dio.dart';
import 'package:graduation_project/models/details_model.dart';
import 'package:graduation_project/models/serach_model.dart';

import '../core/constant.dart';
import '../models/home_model.dart';


class CoinApi {

  Future<List<HomeModel>> getHomeUrl() async {
    try {
      var response = await Dio().get(baseUrl + homeUrl);
      return List<HomeModel>.from(
          response.data.map((x) => HomeModel.fromJson(x)));

    }

    catch (e) {
      rethrow;
    }
  }

  Future<List<SearchModel>> getAllSearchResult(String value) async{
    try{
      var response = await Dio().get(
          baseUrl + searchUrl + value );

      return List<SearchModel>.from(response.data["coins"].map((x) => SearchModel.formJson(x)));

    }
    catch(e){
      rethrow;
    }
  }

  Future<DetailsModel> getDetailsUrl(String y) async {
    try {
      var response = await Dio().get(baseUrl + detailsUrl + y);
      return DetailsModel.fromJson(response.data);
    }

    catch (e) {
      rethrow;
    }
  }

}