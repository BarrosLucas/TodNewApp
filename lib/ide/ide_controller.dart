import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

part 'ide_controller.g.dart';
class IDEController = ControllerBase with _$IDEController;

abstract class ControllerBase with Store{

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
  Future<void> sendString() async {
    if (!isConnected || connectedDevice == null || connection == null) {
      throw Exception("Não há dispositivo conectado");
    }

    // Envia uma string para o dispositivo
    connection!.output.add(Uint8List.fromList(code.text.codeUnits));
    await connection!.output.allSent;

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
}