import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_mania/recipe_view.dart';
import 'package:http/http.dart';

import 'model.dart';

class Search extends StatefulWidget {
  String query;
  Search(this.query);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = true;

  List<RecipeModel> recipeList = <RecipeModel>[];

  TextEditingController searchController = new TextEditingController();


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

      log(recipeList.toString());
    });

    recipeList.forEach((recipe) {
      print(recipe.applabel);
      print(recipe.appimgUrl);
    });
  }

  @override
  void initState() {
    super.initState();
    getRecipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text)
                                .replaceAll((" "), ("")) ==
                                "") {
                              print("Blank Search");
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Search(searchController.text)));
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                              child: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              )),
                        ),
                        Expanded(
                            child: TextField(
                              controller: searchController,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {
                                print(value);
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Let's cook the delicasies!",
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recipeList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                margin: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 0.0,
                                child: Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        recipeList[index].appimgUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 300),
                                  ),
                                  Positioned(
                                      left: 0,
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                recipeList[index].applabel,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                              ),

                                            ],
                                          ))),
                                 Positioned(
                                   left: 0,
                                   bottom: 0,
                                   right: 0,
                                   top: 0,
                                   child: Center(
                                       child: GestureDetector(
                                         onTap: () {
                                           Navigator.push(context,MaterialPageRoute(builder: (context)=> RecipeView(recipeList[index].appurl)));
                                         },
                                         child: Container(
                                           width: 150,
                                           height: 40,
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(50),
                                             color: Colors.black54,
                                           ),
                                           child: Container(
                                             margin: EdgeInsets.all(10),
                                             child: Row(
                                               children: [
                                                 Text('View Recipe',style: TextStyle(color: Colors.white,fontSize: 16)),
                                                 SizedBox(width: 5,),
                                                 Icon(Icons.arrow_circle_right_rounded, color:Colors.white, size: 24,),
                                               ],
                                             ),
                                           ),
                                         ),
                                       )
                                   ),
                                 ),
                                  Positioned(
                                      right: 0,
                                      height: 40,
                                      width: 80,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              )),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.local_fire_department,
                                                    size: 15),
                                                Text(recipeList[index]
                                                    .appcalories
                                                    .toString()
                                                    .substring(0, 6)),
                                              ],
                                            ),
                                          ))),
                                ]),
                              ),
                            ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
