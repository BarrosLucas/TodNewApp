import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:mobx/mobx.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tod/model/erro.dart';
import 'package:tod/utils/compiler.dart';
import 'package:tod/utils/exceptions/exceptions.dart';

part 'ide_controller.g.dart';
class IDEController = ControllerBase with _$IDEController;

abstract class ControllerBase with Store{
  @observable
  bool visibleErrorDialog = false;

  @observable
  String msgErrorDialog = "";

  @observable
  String generatedCod = "";

  @observable
  String nameFile = "";


  @observable
  FlutterBluetoothSerial flutterBlue = FlutterBluetoothSerial.instance;

  @observable
  TextEditingController code = TextEditingController();

  @observable
  bool isConnected = false;

  @observable
  BluetoothDevice? connectedDevice;

  @observable
  BluetoothConnection? connection;

  @observable
  String deviceName = "HC-05"; // nome do dispositivo Bluetooth

  @action
  Future<void> connectToDevice() async {
    if(!(await checkPermissions())){
      return;
    }

    BluetoothDevice ? hc05Device;

    // Setup a list of the bonded devices
    await flutterBlue.getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
          bondedDevices.forEach((element) {
            print("\n");
            print(element.name);
            print(element.address);
          });
         hc05Device = bondedDevices.firstWhere((element) => element.name=="HC-05");
      });

    print("\n");

    print("HC05 is null? ${hc05Device == null}");
    print("Conectando:");
    try {
      connection = await BluetoothConnection.toAddress(hc05Device!.address);
      print("Conectado: ${connection!.isConnected}");

      if(connection!.isConnected){
        connectedDevice = hc05Device;
        isConnected = true;

        connection!.input!.listen((Uint8List data) {
          print('Data incoming: ${ascii.decode(data)}');
          connection!.output.add(data); // Sending data

          if (ascii.decode(data).contains('!')) {
            connection!.finish(); // Closing connection
            connectedDevice = null;
            isConnected = false;
            print('Disconnecting by local host');
          }
        }).onDone(() {
          connectedDevice = null;
          isConnected = false;
          print('Disconnected by remote request');
        });
      }


    }
    catch (exception) {
      print('Cannot connect, exception occured: ${exception}');
    }
  }

  @action
  Future<void> disconnectFromDevice() async {
    if (connectedDevice != null) {
      //await connectedDevice!.disconnect();
      isConnected = false;
      connectedDevice = null;
    }
  }

  @action
  Future<void> sendString(String code) async {
    if (!isConnected || connectedDevice == null || connection == null) {
      throw Exception("Não há dispositivo conectado");
    }

    // Envia uma string para o dispositivo
    connection!.output.add(Uint8List.fromList(code.codeUnits));
    await connection!.output.allSent;

  }

  @action
  newCode(){
    code.text = "";
  }

  // Verifica se a permissão de Bluetooth foi concedida
  Future<bool> checkPermissions() async {
    bool permOne = await Permission.bluetoothScan.request().isGranted;
    bool permTwo = await Permission.bluetoothAdvertise.request().isGranted;
    bool permThree = await Permission.bluetoothConnect.request().isGranted;

    //This will only bring up one permission pop-up, but will only grant the permissions you have been requested here
    //in this method.

    //Return your boolean here
    return permOne && permTwo && permThree? true : false;
  }

  @action
  compile() async{
    String c = await checkCode();
    print(c);
    if(c.isNotEmpty){
      sendString(c);
    }
  }

  @action
  Future<String> checkCode() async{
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the 'counter' key. If it doesn't exist, returns null.
    final int invalidParamException = prefs.getInt('invalidParamException') ?? 0;
    final int missingParamException = prefs.getInt('missingParamException') ?? 0;
    final int missCloseParenthesesException = prefs.getInt('missCloseParenthesesException') ?? 0;
    final int missSemicolonException = prefs.getInt('missSemicolonException') ?? 0;
    final int missOpenParenthesesException = prefs.getInt('missOpenParenthesesException') ?? 0;
    final int missConditionException = prefs.getInt('missConditionException') ?? 0;
    final int missOpenBraceException = prefs.getInt('missOpenBraceException') ?? 0;
    final int invalidConditionException = prefs.getInt('invalidConditionException') ?? 0;
    final int missConditionalBlockException = prefs.getInt('missConditionalBlockException') ?? 0;
    final int unexpectedCloseBraceException = prefs.getInt('unexpectedCloseBraceException') ?? 0;
    final int invalidInstructionException = prefs.getInt('invalidInstructionException') ?? 0;
    final int otherException = prefs.getInt('otherException') ?? 0;

    try{
      return Compiler().getCommands(code.text);
    }catch(e){
      visibleErrorDialog  = true;
      if(e is InvalidParamException){
        msgErrorDialog = e.message;
        await prefs.setInt('invalidParamException', invalidParamException+1);
      }else if(e is MissingParamException){
        msgErrorDialog = e.message;
        await prefs.setInt('missingParamException', missingParamException+1);
      }else if(e is MissCloseParenthesesException){
        msgErrorDialog = e.message;
        await prefs.setInt('missCloseParenthesesException', missCloseParenthesesException+1);
      }else if(e is MissSemicolonException){
        msgErrorDialog = e.message;
        await prefs.setInt('missSemicolonException', missSemicolonException+1);
      }else if(e is MissOpenParenthesesException){
        msgErrorDialog = e.message;
        await prefs.setInt('missOpenParenthesesException', missOpenParenthesesException+1);
      }else if(e is MissConditionException){
        msgErrorDialog = e.message;
        await prefs.setInt('missConditionException', missConditionException+1);
      }else if(e is MissOpenBraceException){
        msgErrorDialog = e.message;
        await prefs.setInt('missOpenBraceException', missOpenBraceException+1);
      }else if(e is InvalidConditionException){
        msgErrorDialog = e.message;
        await prefs.setInt('invalidConditionException', invalidConditionException+1);
      }else if(e is MissConditionalBlockException){
        msgErrorDialog = e.message;
        await prefs.setInt('missConditionalBlockException', missConditionalBlockException+1);
      }else if(e is UnexpectedCloseBraceException){
        msgErrorDialog = e.message;
        await prefs.setInt('unexpectedCloseBraceException', unexpectedCloseBraceException+1);
      }else if(e is InvalidInstructionException){
        msgErrorDialog = e.message;
        await prefs.setInt('invalidInstructionException', invalidInstructionException+1);
      }else{
        msgErrorDialog = "Verifique seu código e tente novamente";
        await prefs.setInt('otherException', otherException+1);
        print(e);
      }
      print(msgErrorDialog);
      return "";
    }
  }

  @action
  disableDialog(){
    visibleErrorDialog = false;
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    }
    final path = result.files.single.path!;
    return File(path);
  }

  @action
  saveFile() async{
    // Abre a tela de seleção de arquivo ou pasta
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      return;
    }

    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch ~/ 1000;
    File newFile = File('${selectedDirectory}/TOD-$timestamp}');
    newFile.writeAsString(code.text);
  }

  @action
  openFile() async{
    File? file = await pickFile();
    if(file == null){
      return;
    }
    code.text = await file.readAsString();
  }

  Future<List<Erro>> getListToStatistics() async{
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the 'counter' key. If it doesn't exist, returns null.
    final int invalidParamException = prefs.getInt('invalidParamException') ?? 0;
    final int missingParamException = prefs.getInt('missingParamException') ?? 0;
    final int missCloseParenthesesException = prefs.getInt('missCloseParenthesesException') ?? 0;
    final int missSemicolonException = prefs.getInt('missSemicolonException') ?? 0;
    final int missOpenParenthesesException = prefs.getInt('missOpenParenthesesException') ?? 0;
    final int missConditionException = prefs.getInt('missConditionException') ?? 0;
    final int missOpenBraceException = prefs.getInt('missOpenBraceException') ?? 0;
    final int invalidConditionException = prefs.getInt('invalidConditionException') ?? 0;
    final int missConditionalBlockException = prefs.getInt('missConditionalBlockException') ?? 0;
    final int unexpectedCloseBraceException = prefs.getInt('unexpectedCloseBraceException') ?? 0;
    final int invalidInstructionException = prefs.getInt('invalidInstructionException') ?? 0;
    final int otherException = prefs.getInt('otherException') ?? 0;

    return [
      Erro(title: "Parâmetro errado",many: invalidParamException, barColor: charts.ColorUtil.fromDartColor(Colors.pink)),
      Erro(title: "Sem parâmetro",many: missingParamException, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      Erro(title: "Ausências de )",many: missCloseParenthesesException, barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      Erro(title: "Ausências de ;",many: missSemicolonException, barColor: charts.ColorUtil.fromDartColor(Colors.grey)),
      Erro(title: "Ausências de (",many: missOpenParenthesesException, barColor: charts.ColorUtil.fromDartColor(Colors.yellow)),
      Erro(title: "Sem condição",many: missConditionException, barColor: charts.ColorUtil.fromDartColor(Colors.red)),
      Erro(title: "Ausências de {",many: missOpenBraceException, barColor: charts.ColorUtil.fromDartColor(Colors.black)),
      Erro(title: "Condição errada",many: invalidConditionException, barColor: charts.ColorUtil.fromDartColor(Colors.cyan)),
      Erro(title: "Faltou um \"se\"",many: missConditionalBlockException, barColor: charts.ColorUtil.fromDartColor(Colors.brown)),
      Erro(title: "Uso inesperado {",many: unexpectedCloseBraceException, barColor: charts.ColorUtil.fromDartColor(Colors.orange)),
      Erro(title: "Instrução inválida",many: invalidInstructionException, barColor: charts.ColorUtil.fromDartColor(Colors.teal)),
      Erro(title: "Outros erros",many: otherException, barColor: charts.ColorUtil.fromDartColor(Colors.purple)),
    ];
  }
}