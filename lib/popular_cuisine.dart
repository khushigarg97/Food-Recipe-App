import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_mania/search.dart';
import 'package:http/http.dart';

import 'model.dart';
class PopularCuisinePage extends StatefulWidget {
  const PopularCuisinePage({Key? key}) : super(key: key);

  @override
  State<PopularCuisinePage> createState() => _PopularCuisinePageState();
}

class _PopularCuisinePageState extends State<PopularCuisinePage> {

  bool isLoading = true;

  List<RecipeModel> recipeList = <RecipeModel>[];

  TextEditingController searchController = new TextEditingController();

  List popularRecipeList = [
    {"image": "assets/images/p1.jpg", "heading": "Pizzas"},
    {"image": "assets/images/p2.jpg", "heading": "Burgers"},
    {"image": "assets/images/p3.jpg", "heading": "Indian Snacks"},
    {"image": "assets/images/p4.jpg", "heading": "Chole Bhature"},
    {"image": "assets/images/p5.jpg", "heading": "Rolls"},
    {"image": "assets/images/p6.jpg", "heading": "Special Paneer"},
    {"image": "assets/images/p7.jpg", "heading": "Samosas"},
    {"image": "assets/images/p8.jpg", "heading": "Icecreams"},
    {"image": "assets/images/p9.jpg", "heading": "Gulab Jamun"},
    {"image": "assets/images/p10.jpg", "heading": "Tea"},
    {"image": "assets/images/p11.jpg", "heading": "Coffee Latte"},
  ];

  void getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=3397aecf&app_key=a6987d0d860e04f4a905c11184eb143c";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);

      setState(() {
        isLoading = false;
      });
    });
  }

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
                      child: Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "When you eat food with your family and friends,",
                                style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "It always tastes better!",
                                style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))),

                  Container(
                    child:ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: popularRecipeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>Search(popularRecipeList[index]["heading"])));
                            },
                            child:
                            Card(
                              margin: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 0.0,
                              child: Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                     popularRecipeList[index]["image"],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200),
                                ),
                                Positioned(
                                    left: 0,
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        decoration: const BoxDecoration(
                                          color: Colors.black45,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              popularRecipeList[index]["heading"],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ))),

                              ]),
                            ),
                          );
                        }),
                  ),

                ],
              ))
        ]));
  }
}
