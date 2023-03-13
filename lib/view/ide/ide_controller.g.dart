// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ide_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IDEController on ControllerBase, Store {
  late final _$codeAtom = Atom(name: 'ControllerBase.code', context: context);

  @override
  TextEditingController get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(TextEditingController value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  late final _$isConnectedAtom =
      Atom(name: 'ControllerBase.isConnected', context: context);

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  late final _$connectedDeviceAtom =
      Atom(name: 'ControllerBase.connectedDevice', context: context);

  @override
  BluetoothDevice? get connectedDevice {
    _$connectedDeviceAtom.reportRead();
    return super.connectedDevice;
  }

  @override
  set connectedDevice(BluetoothDevice? value) {
    _$connectedDeviceAtom.reportWrite(value, super.connectedDevice, () {
      super.connectedDevice = value;
    });
  }

  late final _$deviceNameAtom =
      Atom(name: 'ControllerBase.deviceName', context: context);

  @override
  String get deviceName {
    _$deviceNameAtom.reportRead();
    return super.deviceName;
  }

  @override
  set deviceName(String value) {
    _$deviceNameAtom.reportWrite(value, super.deviceName, () {
      super.deviceName = value;
    });
  }

  late final _$connectToDeviceAsyncAction =
      AsyncAction('ControllerBase.connectToDevice', context: context);

  @override
  Future<void> connectToDevice() {
    return _$connectToDeviceAsyncAction.run(() => super.connectToDevice());
  }

  late final _$disconnectFromDeviceAsyncAction =
      AsyncAction('ControllerBase.disconnectFromDevice', context: context);

  @override
  Future<void> disconnectFromDevice() {
    return _$disconnectFromDeviceAsyncAction
        .run(() => super.disconnectFromDevice());
  }

  late final _$sendStringAsyncAction =
      AsyncAction('ControllerBase.sendString', context: context);

  @override
  Future<void> sendString() {
    return _$sendStringAsyncAction.run(() => super.sendString());
  }

  @override
  String toString() {
    return '''
code: ${code},
isConnected: ${isConnected},
connectedDevice: ${connectedDevice},
deviceName: ${deviceName}
    ''';
  }
}
