// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ide_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IDEController on ControllerBase, Store {
  late final _$visibleErrorDialogAtom =
      Atom(name: 'ControllerBase.visibleErrorDialog', context: context);

  @override
  bool get visibleErrorDialog {
    _$visibleErrorDialogAtom.reportRead();
    return super.visibleErrorDialog;
  }

  @override
  set visibleErrorDialog(bool value) {
    _$visibleErrorDialogAtom.reportWrite(value, super.visibleErrorDialog, () {
      super.visibleErrorDialog = value;
    });
  }

  late final _$msgErrorDialogAtom =
      Atom(name: 'ControllerBase.msgErrorDialog', context: context);

  @override
  String get msgErrorDialog {
    _$msgErrorDialogAtom.reportRead();
    return super.msgErrorDialog;
  }

  @override
  set msgErrorDialog(String value) {
    _$msgErrorDialogAtom.reportWrite(value, super.msgErrorDialog, () {
      super.msgErrorDialog = value;
    });
  }

  late final _$generatedCodAtom =
      Atom(name: 'ControllerBase.generatedCod', context: context);

  @override
  String get generatedCod {
    _$generatedCodAtom.reportRead();
    return super.generatedCod;
  }

  @override
  set generatedCod(String value) {
    _$generatedCodAtom.reportWrite(value, super.generatedCod, () {
      super.generatedCod = value;
    });
  }

  late final _$nameFileAtom =
      Atom(name: 'ControllerBase.nameFile', context: context);

  @override
  String get nameFile {
    _$nameFileAtom.reportRead();
    return super.nameFile;
  }

  @override
  set nameFile(String value) {
    _$nameFileAtom.reportWrite(value, super.nameFile, () {
      super.nameFile = value;
    });
  }

  late final _$flutterBlueAtom =
      Atom(name: 'ControllerBase.flutterBlue', context: context);

  @override
  FlutterBluetoothSerial get flutterBlue {
    _$flutterBlueAtom.reportRead();
    return super.flutterBlue;
  }

  @override
  set flutterBlue(FlutterBluetoothSerial value) {
    _$flutterBlueAtom.reportWrite(value, super.flutterBlue, () {
      super.flutterBlue = value;
    });
  }

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

  late final _$connectionAtom =
      Atom(name: 'ControllerBase.connection', context: context);

  @override
  BluetoothConnection? get connection {
    _$connectionAtom.reportRead();
    return super.connection;
  }

  @override
  set connection(BluetoothConnection? value) {
    _$connectionAtom.reportWrite(value, super.connection, () {
      super.connection = value;
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
  Future<void> sendString(String code) {
    return _$sendStringAsyncAction.run(() => super.sendString(code));
  }

  late final _$compileAsyncAction =
      AsyncAction('ControllerBase.compile', context: context);

  @override
  Future compile() {
    return _$compileAsyncAction.run(() => super.compile());
  }

  late final _$checkCodeAsyncAction =
      AsyncAction('ControllerBase.checkCode', context: context);

  @override
  Future<String> checkCode() {
    return _$checkCodeAsyncAction.run(() => super.checkCode());
  }

  late final _$saveFileAsyncAction =
      AsyncAction('ControllerBase.saveFile', context: context);

  @override
  Future saveFile() {
    return _$saveFileAsyncAction.run(() => super.saveFile());
  }

  late final _$openFileAsyncAction =
      AsyncAction('ControllerBase.openFile', context: context);

  @override
  Future openFile() {
    return _$openFileAsyncAction.run(() => super.openFile());
  }

  late final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase', context: context);

  @override
  dynamic newCode() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.newCode');
    try {
      return super.newCode();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic disableDialog() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.disableDialog');
    try {
      return super.disableDialog();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
visibleErrorDialog: ${visibleErrorDialog},
msgErrorDialog: ${msgErrorDialog},
generatedCod: ${generatedCod},
nameFile: ${nameFile},
flutterBlue: ${flutterBlue},
code: ${code},
isConnected: ${isConnected},
connectedDevice: ${connectedDevice},
connection: ${connection},
deviceName: ${deviceName}
    ''';
  }
}
