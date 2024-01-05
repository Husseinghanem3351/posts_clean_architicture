import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectDevice{
  Future<bool> get isDeviceConnected;
}

class ConnectDeviceImpl implements ConnectDevice{
  final InternetConnectionChecker isConnected;
  ConnectDeviceImpl({required this.isConnected});
  @override
  Future<bool> get isDeviceConnected async {
      return  await isConnected.hasConnection;
  }

}