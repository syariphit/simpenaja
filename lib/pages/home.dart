import 'package:carousel_slider/carousel_slider.dart';
import 'package:eminovel/helpers/constants.dart';
import 'package:eminovel/helpers/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localstorage/localstorage.dart';

class Home extends StatefulWidget {
  final LocalStorage storage;

  Home({Key? key, required this.storage}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = 'Username';
  String name = 'Nama';
  String description = 'Description';
  String photo_url = 'https://www.showflipper.com/blog/images/default.jpg';
  List list_image = [
    'assets/images/slide-01.png',
    'assets/images/slide-02.png',
  ];
  int _current = 0;

  var list_novel = novels;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    get_profile();
  }
  
  void get_profile() async{
    LocalStorage storage = widget.storage;
    setState(() {
      username = storage.getItem('username') != null ? storage.getItem('username') : username;
      name = storage.getItem('name') != null ? storage.getItem('name') : name;
      description = storage.getItem('description') != null ? storage.getItem('description') : description;
      photo_url = storage.getItem('photo_url') != null ? storage.getItem('photo_url') : photo_url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: CustomColors.primaryColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      _user_info(name, photo_url),
                    ],
                  ),
                )
              ),
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                         decoration: new BoxDecoration(
                          color: CustomColors.primaryColor,
                            borderRadius: new BorderRadius.only(
                            bottomLeft: const Radius.circular(0.0),
                            bottomRight: const Radius.circular(0.0),
                          )
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .0,
                      right: 20.0,
                      left: 20.0
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      height: 110.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: _app_header()
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(5)),
                    // _slide_banner(list_image, (index, reason) {
                    //   setState(() {
                    //     _current = index;
                    //   });
                    // }),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: list_image.map((url) {
                    //     int index = list_image.indexOf(url);
                    //     return Container(
                    //       width: 8.0,
                    //       height: 8.0,
                    //       margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 2.0),
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: _current == index
                    //           ? Color.fromRGBO(0, 0, 0, 0.1)
                    //           : CustomColors.primaryColor,
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                    Padding(padding: EdgeInsets.all(5)),
                    _header_list(),
                    Padding(padding: EdgeInsets.all(3)),
                    Column(
                      children: list_novel.map((obj) {
                        List chapters = obj['chapters'] as List;
                        String subtitle = "";
                        String type = "";
                        String date = "";
                        for(var item in chapters){
                          subtitle = item['chapter'] as String;
                          type = item['tl_type'] as String;
                          date = item['post_on'] as String;
                        }

                        String title = obj['title'] as String;
                        String rating = obj['rating'] as String;
                        String cover = obj['cover'] as String;

                        return _card_item(
                          title,
                          subtitle,
                          type,
                          date,
                          rating,
                          cover
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

Widget _user_info(name, photo_url){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome', 
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            '${name}', 
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ]
      ),
      ClipOval(
        child: Image.network(
          '${photo_url}',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}

Widget _slide_banner(List list_image, dynamic onPageChanged){
  return  CarouselSlider(
    options: CarouselOptions(
      // height: 180,
      scrollDirection: Axis.horizontal,
      autoPlay: true,
      enableInfiniteScroll: true,
      autoPlayCurve: Curves.fastOutSlowIn,
      autoPlayInterval: Duration(seconds: 6),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      onPageChanged: onPageChanged,
      viewportFraction: 1,
      enlargeCenterPage: true,
    ),
    items: list_image.map((image) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset('${image}'),
          );
        },
      );
    }).toList(),
  );
}

Widget _header_list(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Browser', 
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'Show All', 
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: CustomColors.primaryColor,
        ),
      ),
    ],
  );
}

Widget _card_item(String? title, String? subtitle, String? type, String? date, String? rating, String? cover){
  return Padding(
    padding: EdgeInsets.only(top: 8, bottom: 8),
    child: Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
                cover != null ? cover : 'https://i.postimg.cc/90Kwhrdq/Group-7-1.png',
                height: 140,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 21, left: 11, right: 10),
                child: Text(
                  '${title}', 
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3, left: 11),
                child: Text(
                  '${subtitle}', 
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 11, bottom: 11),
                    child: Icon(
                      Ionicons.book_outline,
                      size: 13,
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 11),
                    child: Text(
                      '${type}', 
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 11, bottom: 11),
                    child: Icon(
                      Ionicons.calendar_outline,
                      size: 13,
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 11),
                    child: Text(
                      '${date}', 
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 11, bottom: 11),
                    child: Icon(
                      Ionicons.star_outline,
                      size: 13,
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 11),
                    child: Text(
                      '${rating}', 
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]
              )
            ]
          )
        ],
      )
    )
  );
}


Widget _app_header(){
  return Row(
    children: [
      Image.asset(
        'assets/images/bag.png',
        height: 250,
      ),
      Padding(padding: EdgeInsets.only(left: 5)),
      VerticalDivider(
        color: Colors.grey[300],
        thickness: 2,
        width: 20,
      ),
      Padding(padding: EdgeInsets.only(left: 5)),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Item Recorded',
            style: TextStyle(
              fontSize: 17
            ),
          ),
          Text(
            '30',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      )
    ],
  );
}