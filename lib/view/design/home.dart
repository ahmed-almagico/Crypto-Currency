import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graduation_project/models/language_constant.dart';
import 'package:graduation_project/provider/details_provider.dart';
import 'package:graduation_project/provider/prof_provider.dart';
import 'package:graduation_project/view/design/details.dart';
import 'package:graduation_project/view/design/profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/theme.dart';
import '../../provider/home_provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   var prov = Provider.of<DetailsProvider>(context);
   Provider.of<ProfileProvider>(context , listen: false).GetUser();
    return Consumer<HomeProvider>(builder: (context , provider , child){
      return Scaffold(
          appBar: AppBar(
            title: Text(translation(context).crypto_currency,),
          ),
          body: ListView.builder(
              itemCount: provider.homeList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    prov.getAllDetailsList(provider.homeList[index].id) ;
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .02),
                    child: Column(
                      children: [
                        SizedBox( height: MediaQuery.of(context).size.height * .015,),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Themes.isDarkMode(context) ?  Color(0xff151f2c) : Colors.blueGrey,),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            children: [
                              SizedBox(width: MediaQuery.of(context).size.width * .03,),
                              Text(provider.homeList[index].rank.toString() ,),
                              SizedBox(width: MediaQuery.of(context).size.width * .023,),
                              CircleAvatar(
                                backgroundImage:NetworkImage(provider
                                    .homeList[index].imageUrl ==
                                    ""
                                    ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png"
                                    : provider.homeList[index].imageUrl),
                                radius: 20,
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * .02,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider.homeList[index].name ),
                                    Text(provider.homeList[index].symbol ),
                                  ],

                                ),
                              ),

                              SizedBox(width: MediaQuery.of(context).size.width * .37,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text( provider.homeList[index].currentPrice.toString() , ),
                                    Text(provider.homeList[index].priceChange24h .toStringAsFixed(3), style: TextStyle( color: provider.homeList[index].priceChange24h > 0 ? Colors.green : Colors.red),),
                                    Text( '${provider.homeList[index].priceChangePercentage24h.toStringAsFixed(3)}%', style: TextStyle(color: provider.homeList[index].priceChangePercentage24h > 0 ? Colors.green : Colors.red),),
                                  ],),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

        );

    });
  }
}
