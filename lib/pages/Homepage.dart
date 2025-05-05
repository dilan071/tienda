import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda/widgets/CategoriesWidgets.dart';
import 'package:tienda/widgets/HomeAppBar.dart';
import 'package:tienda/widgets/ItemsWidget.dart';

class HomePage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: ListView(
                children: [
                    HomeAppBar(),
                    Container( 
                      // temporary height
                      //height: 500, 
                      padding: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: Color(0xFFFEDCF2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Column(children: [
                        //search widget
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 50, 
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(children: [
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 50,
                              width: 300,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "search here..."
                                ),
                              ) ,
                            ),
                            Spacer(),
                            Icon(
                              Icons.camera_alt,
                              size: 27,
                              color: Color(0xFF4C53A5),
                            ),
                          ],)
                          ),
                          //categories
                          Container(
                            //alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(
                            vertical: 20, 
                            horizontal: 10),
                            child: Text("categories",
                              style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5)),
                               ),
                          ),
                          //categories widgets
                          CategoriesWidgets(),
                          //item

                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            child: Text(
                              "best seling",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4C53A5),
                              ),
                              ),
                          ),
                          ItemsWidget(),  
                      ],
                      ),
                    ),
                    
                ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              onTap: (index){},
              height: 70,
              color: Color(0xFF4C53A5),
              items: [
                Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  CupertinoIcons.car_fill,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.list,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
        ); 
    }
}