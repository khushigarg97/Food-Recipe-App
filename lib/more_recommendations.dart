import 'package:flutter/material.dart';
import 'package:food_mania/search.dart';

class MoreRecommnedations extends StatefulWidget {
  const MoreRecommnedations({Key? key}) : super(key: key);

  @override
  State<MoreRecommnedations> createState() => _MoreRecommnedationsState();
}

class _MoreRecommnedationsState extends State<MoreRecommnedations> {
  List recommendationsList = [
    {"heading": "Special prawn pasta"},
    {"heading": "Thai Fruit Skewers"},
    {"heading": "Tahini Date Cardamom Cookies"},
    {"heading": "Spiced Blueberry Soup"},
    {"heading": "Zucchini-Chocolate Chip Muffins"},
    {"heading": "Potatoes with Sesame Seeds"},
    {"heading": "Milo Brownies"},
    {"heading": "Blueberry Butterfly Cakes"},
    {"heading": "Chocolate Pudding Pie"},
    {"heading": "Mexican Street Corn Cups"},
    {"heading": "Quick Tropical Fruit Salad"},
    {"heading": "Rum Bundt Cake"},
    {"heading": "Fruit Pizza"},
    {"heading": "Pav Bhaji"},
    {"heading": "Blackberry Pineapple Mojito"},
    {"heading": "Thai Noodle Bowl"},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff213A50),
                  Color(0xff071938),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                      child:Card(
                        margin: EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.asset(
                             "assets/images/card_img.jpg",
                              fit: BoxFit.cover,
                              width: 400,
                            ),
                          ),
                          Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                    child:const Center(
                                      child: Text(
                                          "Discover all the recipes you needed",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                    ),
                              )),
                        ]),
                          )),

                  Container(
                      child:
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: recommendationsList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Search(recommendationsList[index]["heading"])));
                                  },
                                  child:
                                  Card(
                                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    elevation: 0.0,
                                    child: Container(
                                      height: 50,
                                       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                              decoration: const BoxDecoration(
                                                color: Colors.black45,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:300,
                                                    child: Text(
                                                      recommendationsList[index]["heading"],
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          ),
                                                    ),
                                                  ),
                                                  Icon(Icons.arrow_circle_right_rounded,
                                                      color: Colors.white)
                                                ],
                                              )

                                    ),
                                  ),
                                );
                              }),


                ),
    ],
              ))
        ]));
  }
}