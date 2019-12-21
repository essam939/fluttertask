import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mytask/component/imagePicker.dart';
import 'package:mytask/provider/mainProvider.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TextEditingController comment = new TextEditingController();
  List favorite = [],
      bookmark = [];
  File userImage;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainProvider().mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text("الرئيسية", textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ), bottom: TabBar(
        tabs: <Widget>[
          Tab(child: Text("حسابى",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          Tab(child: Text("الرئيسية",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),),
        ],),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.menu),),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 200,
                color: MainProvider().secondColor,
              ),
              Transform.translate(
                offset: Offset(0, -70),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            "https://images.clipartlogo.com/files/istock/previews/1020/102071463-flat-design-avatar-male-character-icon-vector.jpg"),
                      ),
                    ),
                    Text("أسم المستخدم"),
                    Text("user99@gmail.com"),
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(child: Icon(Icons.star),
                    radius: 25,
                    backgroundColor: MainProvider().mainColor,
                    foregroundColor: Colors.white,),
                  CircleAvatar(child: Icon(Icons.settings),
                    radius: 25,
                    backgroundColor: MainProvider().mainColor,
                    foregroundColor: Colors.white,),
                  CircleAvatar(child: Icon(Icons.edit),
                    radius: 25,
                    backgroundColor: MainProvider().mainColor,
                    foregroundColor: Colors.white,),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("المفضلة",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("الإعدادات",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("تعديل بياناتى",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Center(
                                child: IconButton(icon: Icon(Icons.favorite,
                                  color: favorite.contains(index)
                                      ? Colors.red
                                      : Colors.grey,),
                                  onPressed: () {
                                    setState(() {
                                      if (favorite.contains(index)) {
                                        favorite.remove(index);
                                      }
                                      else {
                                        favorite.add(index);
                                      }
                                    });
                                  },),
                              ),
                              IconButton(icon: Icon(Icons.bookmark,
                                color: bookmark.contains(index)
                                    ? Colors.green
                                    : Colors.grey,), onPressed: () {
                                setState(() {
                                  if (bookmark.contains(index)) {
                                    bookmark.remove(index);
                                  }
                                  else {
                                    bookmark.add(index);
                                  }
                                });
                              },),
                              IconButton(
                                icon: Icon(Icons.share), onPressed: () {},),
                              Text("أسم المستخدم"),
                              CircleAvatar(),
                            ],
                          ),
                        ),
                        Container(
                          child: Image.network(
                              "https://i.ytimg.com/vi/c7oV1T2j5mc/maxresdefault.jpg"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 17.0, left: 16.0, top: 12, bottom: 12),
                          child: Container(child: Text(
                            "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى. ",
                            textAlign: TextAlign.right,),),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],

      ),
      floatingActionButton: actionBotton(),

    );

  }

  void showModel() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Material(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 10,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.5,
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Column(
                  children: [
                    InkWell(
                      child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 5,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 3,
                          color: Colors.grey,
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.camera_alt, size: 40,),
                              Text("upload photo"),
                            ],
                          )
                      ),
                      onTap: () async {
                        userImage = await showAlert(context);
                        setState(() {});
                      },
                    ),
                    Container(
                      child: Expanded(
                        child: ListView(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("اكتب تعليقا حول الصورة"),
                              ],
                            ),
                            TextFormField(
                              maxLength: 120,
                              maxLines: 2,
                              controller: comment,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please input Text";
                                }
                                else
                                  return null;
                              },
                            ),
                            Row(
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("نشر",
                                    style: TextStyle(color: Colors.white),),
                                  color: MainProvider().secondColor,),
                                FlatButton(onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                  child: Text("تجاهل"),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
  Widget actionBotton(){
    return _tabController.index == 0
        ?null
        : FloatingActionButton(
      shape: StadiumBorder(),
      onPressed: showModel,
      backgroundColor: MainProvider().secondColor,
      child: Icon(
        Icons.add,
        size: 20.0,
      ),
    );
  }
  }

