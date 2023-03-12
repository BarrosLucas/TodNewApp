import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mobx/mobx.dart';

part 'ide_controller.g.dart';
class IDEController = ControllerBase with _$IDEController;

abstract class ControllerBase with Store{
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  @observable
  TextEditingController code = TextEditingController();

  @observable
  bool isConnected = false;

  @observable
  BluetoothDevice? connectedDevice;

  @observable
  String deviceName = "HC-05"; // nome do dispositivo Bluetooth

  @action
  Future<void> connectToDevice() async {
    // Procurar pelo dispositivo Bluetooth
    List<BluetoothDevice> devices = await flutterBlue.bondedDevices;
    BluetoothDevice hc05Device = devices.firstWhere((d) => d.name == deviceName);

    // Conectar ao dispositivo Bluetooth
    await hc05Device.connect(autoConnect: true);
    List<BluetoothService> services = await hc05Device.discoverServices();

    services.forEach((service) {
      List<BluetoothCharacteristic> characteristics = service.characteristics;
      characteristics.forEach((characteristic) {
        print("UUID: ${characteristic.uuid}\nID: ${characteristic.deviceId}");
      });
    });

    isConnected = true;
    connectedDevice = hc05Device;
  }

  @action
  Future<void> disconnectFromDevice() async {
    if (connectedDevice != null) {
      await connectedDevice!.disconnect();
      isConnected = false;
      connectedDevice = null;
    }
  }

  @action
  Future<void> sendString() async {
    if (!isConnected || connectedDevice == null) {
      throw Exception("Não há dispositivo conectado");
    }

    List<BluetoothService> services = await connectedDevice!.discoverServices();

    BluetoothCharacteristic characteristic = services
        .map((service) => service.characteristics)
        .expand((characteristics) => characteristics)
        .firstWhere((c) => c.uuid.toString() == "0000ffe1-0000-1000-8000-00805f9b34fb", orElse: () {
      throw Exception("Característica Bluetooth com UUID especificado não encontrada");
    });

    if (characteristic == null) {
      throw Exception("Característica não encontrada");
    }

    // Converter a string em um array de bytes
    final List<int> bytes = utf8.encode(code.text);

    // Enviar os dados ao dispositivo Bluetooth
    await characteristic.write(bytes, withoutResponse: true);
  }
}