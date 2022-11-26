import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/serach_model.dart';
import '../network/coin_api.dart';
import '../network/dio_exceptions.dart';

class SearchProvider extends ChangeNotifier{
  List<SearchModel> search = [];

  Future getAllSearchList (String x) async {
    try{
      await CoinApi().getAllSearchResult(x).then((value) {
        search = value;
        notifyListeners();
      });
    }
    on DioError catch(e){
      String error = DioExceptions.fromDioError(e).toString();
      print(error);
    }
  }
  }
