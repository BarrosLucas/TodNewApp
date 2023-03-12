import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tod/ide/ide_controller.dart';
class IDE extends StatefulWidget {
  const IDE({Key? key}) : super(key: key);

  @override
  State<IDE> createState() => _IDEState();
}

class _IDEState extends State<IDE> {
  IDEController controller = IDEController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF464646),
      body: bodyScreen(),
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0xFF0B0B0D),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF0B0B0D),
              ),
              child: Container(child: Image.asset("assets/images/logo.png",scale: 1.7,),),
            ),
            ListTile(
              leading: const Icon(Icons.file_open, color: Colors.white,),
              title: Text('Open'.toUpperCase(),style: const TextStyle(color: Colors.white, fontSize: 17),),
              onTap: () {
                // Implementar ação ao selecionar o item 1
              },
            ),
            ListTile(
              leading: const Icon(Icons.create_new_folder_sharp,color: Colors.white,),
              title: Text('New'.toUpperCase(),style: const TextStyle(color: Colors.white, fontSize: 17),),
              onTap: () {
                // Implementar ação ao selecionar o item 2
              },
            ),
            ListTile(
              leading: const Icon(Icons.save, color: Colors.white,),
              title: Text('Save'.toUpperCase(),style: const TextStyle(color: Colors.white, fontSize: 17),),
              onTap: () {
                // Implementar ação ao selecionar o item 1
              },
            ),
            ListTile(
              leading: const Icon(Icons.area_chart,color: Colors.white,),
              title: Text('Statistics'.toUpperCase(),style: const TextStyle(color: Colors.white, fontSize: 17),),
              onTap: () {
                // Implementar ação ao selecionar o item 2
              },
            ),
            ListTile(
              leading: const Icon(Icons.keyboard_command_key,color: Colors.white,),
              title: Text('Commands'.toUpperCase(),style: const TextStyle(color: Colors.white, fontSize: 17),),
              onTap: () {
                // Implementar ação ao selecionar o item 2
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyScreen(){
    return Observer(builder: (_){
      return Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(),
              Expanded(child: textEditor(),)
            ],
          ),
          Positioned(bottom: 50,
            left: 15,child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF292525)
              ),
              padding: const EdgeInsets.all(9),
              child: const Icon(
                Icons.save,
                color: Color(0xFFD9D9D9),
                size: 50,
              ),
            ),),
          Positioned(bottom: 50, left: 0, right: 0,child: InkWell(
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF292525)
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(9),
              child: const Icon(
                Icons.bluetooth_audio,
                color: Color(0xFFD9D9D9),
                size: 50,
              ),
            ),
            onTap: (){
              controller.connectToDevice();
            },
          )),
          Positioned(bottom: 50, right: 15,child: InkWell(
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF292525)
              ),
              padding: const EdgeInsets.all(9),
              child: const Icon(
                Icons.play_arrow,
                color: Color(0xFFD9D9D9),
                size: 50,
              ),
            ),
            onTap: (){
              controller.sendString();
            },
          ))
        ],
      );
    });
  }

  Widget title(){
    return Row(
      children: [
        Container(
          margin:const  EdgeInsets.only(top: 40, left: 20, right: 20,bottom: 10),
          child: InkWell(
            child: const Icon(
              Icons.menu, color: Colors.white,size: 30,
            ),
            onTap: (){
              _scaffoldKey.currentState!.openDrawer();
            },
          )
        ),
        Container(
          margin: const EdgeInsets.only(top: 40, left: 10, bottom: 10),
          child: const Text(
            "TOD",
            style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget textEditor(){
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF908585),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 105,top: 10,left: 20,right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: controller.code,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Put your code here',
        ),
      ),
    );
  }
}
