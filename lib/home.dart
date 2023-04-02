import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_mania/more_recommendations.dart';
import 'package:food_mania/popular_cuisine.dart';
import 'package:food_mania/search.dart';
import 'package:http/http.dart';

import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  List recipeCatList = [
    {"image": "assets/images/c1.jpg", "heading": "Breakfast"},
    {"image": "assets/images/c2.jpg", "heading": "Indian Cuisine"},
    {"image": "assets/images/c3.jpg", "heading": "South Indian"},
    {"image": "assets/images/c4.jpg", "heading": "Veg"},
    {"image": "assets/images/c5.jpg", "heading": "Diet Food"},
    {"image": "assets/images/c6.jpg", "heading": "Salads"},
    {"image": "assets/images/c7.jpeg", "heading": "Specials"},
    {"image": "assets/images/c8.jpg", "heading": "Sweets"},
    {"image": "assets/images/c9.jpg", "heading": "Summer Drinks"},
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
                  margin: EdgeInsets.all(14),
                  child: Text(
                    "What would you like to cook Today?",
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if ((searchController.text).replaceAll((" "), ("")) == "") {
                      print("Blank Search");
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Search(searchController.text)));
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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Row(
                      children: [
                        Text("Popular Cuisines",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Container(
                            margin: EdgeInsets.fromLTRB(120, 0, 0, 0),
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PopularCuisinePage()));
                                },
                                child: Icon(Icons.arrow_circle_right_rounded,
                                    color: Colors.white))),
                      ],
                    )),
                Container(
                    height: 150,
                    child: ListView.builder(
                      itemCount: popularRecipeList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Search(
                                        popularRecipeList[index]["heading"])));
                          },
                          child: Card(
                            margin: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.asset(
                                  popularRecipeList[index]["image"],
                                  fit: BoxFit.cover,
                                  width: 200,
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 2, 0, 2),
                                          child: Text(
                                            popularRecipeList[index]["heading"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ]),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text("Category",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recipeCatList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Search(recipeCatList[index]["heading"])));
                        },
                        child: Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(recipeCatList[index]["image"],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200),
                            ),
                            Positioned(
                                left: 10,
                                bottom: 10,
                                right: 0,
                                child: Text(
                                  recipeCatList[index]["heading"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // ),
                          ]),
                        ),
                      );
                    }),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20, 10, 0, 20),
              child:
                    Row(
                          children: [
                            Text("More Recommendations",
                                style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                            Container(
                                margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MoreRecommnedations()));
                                    },
                                    child: Icon(Icons.arrow_circle_right_rounded,
                                        color: Colors.white))),
                          ],
                        ),

              ),
        ],
      ))
    ]));
  }
}
