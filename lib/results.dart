import 'dart:convert';
// import 'dart:html';
import 'package:task2/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyResult extends StatefulWidget {
  const MyResult({super.key});

  @override
  State<MyResult> createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {

  var decode=[];

  var country='';

  var listC=0;

  @override
  void initState() {
    country=MyHome.country;
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async{
    var url = Uri.parse('http://universities.hipolabs.com/search?country=$country');
    var response = await http.get(url);
    
    if(response.statusCode == 200){
      decode = jsonDecode(response.body);

      setState(() {
        listC=decode.length;
      });
    }
    else{
      print('404 Error Not Found');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Results", style: (TextStyle(color:Colors.white,)),),
        centerTitle: true,
        leading: BackButton(color: Colors.white,),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img_1.png"),
            fit: BoxFit.cover
          ),
        ),
        child: ListView.builder(
          itemCount: listC,
            itemBuilder: (BuildContext contex, int index){
          return Container(
            margin: EdgeInsets.only(top: 10,right: 20, left: 20,),
            height: 200,
            child: Container(
              child: Card(
                color: Color.fromRGBO(254, 255, 255, 0.8),
                
                child: Container(
                  margin: EdgeInsets.only(top: 10,right: 20, left: 20,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        
                        child: ImageIcon(AssetImage("assets/img.png"),),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(decode[index]['name'] ?? "", style: TextStyle(color: Colors.black),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(decode[index]['state-province'] ?? "", style: TextStyle(color: Colors.black),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(decode[index]['country'] ?? "", style: TextStyle(color: Colors.black),),
                            SizedBox(
                              height: 8,
                            ),
                            if(decode[index]['web_pages'] !=null)
                              InkWell(
                                onTap:(){
                                  launchUrl(Uri.parse(decode[index]['web_pages'][0]
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', '')));
                                },
                                child: Text(
                                  decode[index]['web_pages'][0]
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', ''),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 8, 31, 180),
                                      
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                          ],
                        ),
                      ),
            
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
