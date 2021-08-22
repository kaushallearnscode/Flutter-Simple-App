import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper/data/data.dart';
import 'dart:convert';
import 'package:wallpaper/models/categorie_model.dart';
import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/view/categorie_screen.dart';
import 'package:wallpaper/view/search_view.dart';
import 'package:wallpaper/widget/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = new List();

  int noOfImageToLoad = 30;
  List<PhotosModel> photos = new List();

  getTrendingWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1",
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //getWallpaper();
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getTrendingWallpaper();
      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "search wallpapers",
                          border: InputBorder.none),
                    )),
                    InkWell(
                        onTap: () {
                          if (searchController.text != "") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchView(
                                          search: searchController.text,
                                        )));
                          }
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),

              Container(
                height: 575,
                width: 550,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      /// Create List Item tile
                      return CategoriesTile(
                        imgUrls: categories[index].imgUrl,
                        categorie: categories[index].categorieName,
                      );
                    }),
              ),
              // wallPaper(photos, context),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Made By ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Overpass'),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              "https://www.linkedin.com/in/kkachhadiya/");
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 115,
                            child: Text(
                              "Kaushal Kachhadiya",
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 12,
                                  fontFamily: 'Overpass'),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              "https://www.linkedin.com/in/anukul-chauhan-0abb4a1a6/");
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 95,
                            child: Text(
                              "Anukul Chauhan",
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 12,
                                  fontFamily: 'Overpass'),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              "https://www.linkedin.com/in/deepak-parihari-594417192/");
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 95,
                            child: Text(
                              "Deepak Parihari",
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 12,
                                  fontFamily: 'Overpass'),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              "https://www.linkedin.com/in/manish-kumar-403b84175/");
                        },
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Manish Kumar",
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 12,
                                  fontFamily: 'Overpass'),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrls, categorie;

  CategoriesTile({@required this.imgUrls, @required this.categorie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategorieScreen(
                      categorie: categorie,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 7, left: 5, right: 5),
        child: kIsWeb
            ? Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 200,
                              width: 550,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 200,
                              width: 550,
                              fit: BoxFit.cover,
                            )),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: 550,
                      alignment: Alignment.center,
                      child: Text(
                        categorie,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Overpass'),
                      )),
                ],
              )
            : Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 200,
                              width: 550,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 200,
                              width: 550,
                              fit: BoxFit.cover,
                            )),
                  Container(
                    height: 200,
                    width: 550,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Container(
                  //   height: 200,
                  //   width: 550,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage('wallpaper_logo2.png'),
                  //         fit: BoxFit.cover),
                  //     color: Colors.transparent,
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  // ),
                  Container(
                      height: 200,
                      width: 550,
                      alignment: Alignment.center,
                      child: Text(
                        categorie ?? "Yo Yo",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Overpass'),
                      ))
                ],
              ),
      ),
    );
  }
}
