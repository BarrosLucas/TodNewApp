import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tod/model/erro.dart';
import 'package:tod/view/ide/ide_controller.dart';
import 'package:tod/view/statistics.dart';
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
                controller.openFile();
                _scaffoldKey.currentState!.closeDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.create_new_folder_sharp,color: Colors.white,),
              title: Text('New'.toUpperCase(),style: const TextStyle(color: Colors.white, fontSize: 17),),
              onTap: () {
                // Implementar ação ao selecionar o item 2
                controller.newCode();
                _scaffoldKey.currentState!.closeDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.save, color: Colors.white,),
              title: Text('Save'.toUpperCase(),style: const TextStyle(color: Colors.white, fontSize: 17),),
              onTap: () {
                // Implementar ação ao selecionar o item 1
                controller.saveFile();
                _scaffoldKey.currentState!.closeDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.area_chart,color: Colors.white,),
              title: Text('Statistics'.toUpperCase(),style: const TextStyle(color: Colors.white, fontSize: 17),),
              onTap: () async{
                controller.getListToStatistics().then((value){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => PieChart(value)));
                });
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
            left: 15,child: InkWell(
              child: Container(
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
              ),
              onTap: (){
                controller.saveFile();
              },
            ),),
          Positioned(bottom: 50, left: 100, right: 100,child: InkWell(
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
              child: Icon(
                Icons.play_arrow,
                color: (controller.isConnected)? Color(0xFFD9D9D9) : Colors.grey,
                size: 50,
              ),
            ),
            onTap: (){
              controller.compile();
            },
          )),
          Visibility(child: Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: InkWell(
              child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xD9000000),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 350,horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.warning,size: 40,),
                        Text('${controller.msgErrorDialog}')
                      ],
                    ),
                  )
              ),
              onTap: (){
                controller.disableDialog();
              },
            ),
          ),visible: controller.visibleErrorDialog,)
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
