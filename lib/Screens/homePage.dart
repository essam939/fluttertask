import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mytask/component/imagePicker.dart';
import 'package:mytask/provider/mainProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TextEditingController comment = new TextEditingController();
  List favorite = [], bookmark = [];
  File userImage;
  String userEmail="";
String  postImage="",myCommint="";
  var userId;
  TabController _tabController;
  final FirebaseAuth auth= FirebaseAuth.instance;
  final StorageReference storageReference = FirebaseStorage().ref();
  final FirebaseDatabase mDatabaseReference=FirebaseDatabase.instance;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
    auth.signInWithEmailAndPassword(email: "m@m.com", password: "123456789").then((res){
      userEmail=res.user.email.toString();
      userId=res.user.uid;
    });
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
          Tab(child: Text("حسابى", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          Tab(child: Text("الرئيسية", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),),
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
                    Text("$userEmail"),
                  ],
                ),
              ),
              Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    Text("المفضلة", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("الإعدادات", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("تعديل بياناتى", style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: 1,
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
                                  color: favorite.contains(index) ? Colors.red : Colors.grey,),
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
                                color: bookmark.contains(index) ? Colors.green : Colors.grey,), onPressed: () {
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
                                icon: Icon(Icons.share,color: Colors.grey,), onPressed: () {
                                share();
                              },),
                              Text("أسم المستخدم"),
                              CircleAvatar(),
                            ],
                          ),
                        ),
                        Container(
                          child: Image.network(postImage,height: 200,fit: BoxFit.fitWidth,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 17.0, left: 16.0, top: 12, bottom: 12),
                          child: Container(child: Text(myCommint, textAlign: TextAlign.right,),),
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
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height / 1.5,
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Column(
                  children: [
                    InkWell(
                      child: Container(
                          width: MediaQuery.of(context).size.width - 5,
                          height: MediaQuery.of(context).size.height / 3,
                          color: Colors.grey,
                          child:
                              userImage==null?Container(
                                child: Icon(Icons.camera_alt),
                              ):
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Image.file(userImage,fit: BoxFit.cover,),
                            ),
                          )
                      ),
                      onTap: ()async  {
                        userImage = await showAlert(context);
                         setState(() {

                         });
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
                                Consumer(
                                  builder: (context, snapshot,_) {
                                    return RaisedButton(
                                      onPressed: ()  {
                                        Navigator.of(context).pop();
                                        List<String> data=[comment.text];
                                        storageReference.child(userId).getDownloadURL().then((res){
                                          postImage=res;
                                        });
                                      },
                                      child: Text("نشر", style: TextStyle(color: Colors.white),),
                                      color: MainProvider().secondColor,);
                                  }
                                ),
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
  share()async{
    var request = await HttpClient().getUrl(Uri.parse('https://shop.esys.eu/media/image/6f/8f/af/amlog_transport-berwachung.jpg'));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
  }
  }

