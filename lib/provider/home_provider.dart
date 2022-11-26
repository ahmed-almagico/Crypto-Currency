import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/home_model.dart';
import '../network/coin_api.dart';
import '../network/dio_exceptions.dart';

class HomeProvider extends ChangeNotifier{
  List<HomeModel> homeList = [];
  HomeProvider(){
    getAllCoinsList();
  }
  Future getAllCoinsList() async{
    try{
     await CoinApi().getHomeUrl().then((value) {
      homeList = value ;
      notifyListeners();
     }
     ) ;

    }
    on DioError catch (e) {
      String error =  DioExceptions.fromDioError(e).toString();
      print(error);
      Get.dialog(AlertDialog(
        backgroundColor: Colors.grey,
        title: Text("Error"),
        content: Text(error),
        actions: [
          TextButton(onPressed:(){
            getAllCoinsList();
            Get.back();
          }, child: Text("Ok",style: TextStyle(color: Colors.black),))
        ],
      ));
    }

  }
}