import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graduation_project/view/design/details.dart';
import '../models/details_model.dart';
import '../models/home_model.dart';
import '../network/coin_api.dart';
import '../network/dio_exceptions.dart';

class DetailsProvider extends ChangeNotifier{
  DetailsModel? detailslist = DetailsModel(id: '', name: '', symbol: '', description: '', image: '', market_cap_rank: 0, currentPrice: 0, percentChange_24h: 0, percentChange_7d: 0, percentChange_14: 0, percentChange_30: 0, percentChange_60: 0, percentChange_200: 0, percentChange_1y: 0);


  Future getAllDetailsList(String value) async{

    try{
      await CoinApi().getDetailsUrl(value).then((value){
        detailslist = value ;
        Get.to(Details()) ;
      }
      ) ;

    }
    on DioError catch (e) {
      String error =  DioExceptions.fromDioError(e).toString();
      print(error);

    }

  }
}