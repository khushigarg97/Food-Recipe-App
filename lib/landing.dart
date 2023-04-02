import 'package:flutter/material.dart';
import 'package:food_mania/home.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset("assets/images/img_landing.jpg",),
              decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff071938),
                  Color(0xff071938),
                ],
              ),
            ),
          ),
            SafeArea(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 80),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Cooking Experience Like a Chef",style: TextStyle(color: Colors.white, fontSize: 34),),
                              Container(
                                margin: EdgeInsets.all(10),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("You as a cook must bring soul to the recipe....",style: TextStyle(color: Colors.white, fontSize: 14),),
                                    Text("Let's make the delicious recipes",style: TextStyle(color: Colors.white, fontSize: 14),),
                                  ],
                                )
                              ),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                                  width: 160,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xff213A50),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                            Icon(Icons.arrow_circle_right_rounded, color:Colors.white, size: 34,),
                                        SizedBox(width:8),
                                        Center(child: Text('Get Started',style: TextStyle(color: Colors.white,fontSize: 16))),
                                          ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                )),
        ],
      ),
    );
  }
}
