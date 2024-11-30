import 'package:flutter/material.dart';

class CarDataModel extends ChangeNotifier {
  int _odometer = 0;
  double _temperatureGauge = 0.0;
  double _temperatureOutside = 0.0;
  String _lightDirection = '';
  int _tachometer = 0;
  int _speedometer = 0;
  double _oilPressure = 0.0;
  String _clock = '';
  int _climateControl = 0;
  String _drivingMode = '';
  bool _warningLights = false;
  int _fuelGauge = 0;
  String _turnDirection = '';
  bool _turnSignal = false;
  bool _brakeStatus = false;
  int _tirePressure = 0;
  bool _parkingSensorStatus = false;
  bool _stabilityControlStatus = false;
  double _averageFuelConsumption = 0.0;
  int _engineTemperature = 0;
  int _batteryStatus = 0;
  bool _errorLightStatus = false;

  CarDataModel({
    int? odometer,
    double? temperatureGauge,
    double? temperatureOutside,
    String? lightDirection,
    int? tachometer,
    int? speedometer,
    double? oilPressure,
    String? clock,
    int? climateControl,
    String? drivingMode,
    bool? warningLights,
    int? fuelGauge,
    String? turnDirection,
    bool? turnSignal,
    bool? brakeStatus,
    int? tirePressure,
    bool? parkingSensorStatus,
    bool? stabilityControlStatus,
    double? averageFuelConsumption,
    int? engineTemperature,
    int? batteryStatus,
    bool? errorLightStatus,
  })  : _odometer = odometer ?? 0,
        _temperatureGauge = temperatureGauge ?? 0.0,
        _temperatureOutside = temperatureOutside ?? 0.0,
        _lightDirection = lightDirection ?? '',
        _tachometer = tachometer ?? 0,
        _speedometer = speedometer ?? 0,
        _oilPressure = oilPressure ?? 0.0,
        _clock = clock ?? '',
        _climateControl = climateControl ?? 0,
        _drivingMode = drivingMode ?? '',
        _warningLights = warningLights ?? false,
        _fuelGauge = fuelGauge ?? 0,
        _turnDirection = turnDirection ?? '',
        _turnSignal = turnSignal ?? false,
        _brakeStatus = brakeStatus ?? false,
        _tirePressure = tirePressure ?? 0,
        _parkingSensorStatus = parkingSensorStatus ?? false,
        _stabilityControlStatus = stabilityControlStatus ?? false,
        _averageFuelConsumption = averageFuelConsumption ?? 0.0,
        _engineTemperature = engineTemperature ?? 0,
        _batteryStatus = batteryStatus ?? 0,
        _errorLightStatus = errorLightStatus ?? false;

  // Getter methods
  int get odometer => _odometer;
  double get temperatureGauge => _temperatureGauge;
  double get temperatureOutside => _temperatureOutside;
  String get lightDirection => _lightDirection;
  int get tachometer => _tachometer;
  int get speedometer => _speedometer;
  double get oilPressure => _oilPressure;
  String get clock => _clock;
  int get climateControl => _climateControl;
  String get drivingMode => _drivingMode;
  bool get warningLights => _warningLights;
  int get fuelGauge => _fuelGauge;
  String get turnDirection => _turnDirection;
  bool get turnSignal => _turnSignal;
  bool get brakeStatus => _brakeStatus;
  int get tirePressure => _tirePressure;
  bool get parkingSensorStatus => _parkingSensorStatus;
  bool get stabilityControlStatus => _stabilityControlStatus;
  double get averageFuelConsumption => _averageFuelConsumption;
  int get engineTemperature => _engineTemperature;
  int get batteryStatus => _batteryStatus;
  bool get errorLightStatus => _errorLightStatus;

  // Method to update the CarDataModel with new data
  void updateData(Map<String, dynamic> jsonData) {
    _odometer = jsonData['Odometer'] ?? _odometer;
    _temperatureGauge =
        jsonData['Temperature gauge']?.toDouble() ?? _temperatureGauge;
    _temperatureOutside =
        jsonData['Temperature outside']?.toDouble() ?? _temperatureOutside;
    _lightDirection = jsonData['Light Direction'] ?? _lightDirection;
    _tachometer = jsonData['Tachometer'] ?? _tachometer;
    _speedometer = jsonData['Speedometer'] ?? _speedometer;
    _oilPressure = jsonData['Oil Pressure']?.toDouble() ?? _oilPressure;
    _clock = jsonData['Clock'] ?? _clock;
    _climateControl = jsonData['Climate Control'] ?? _climateControl;
    _drivingMode = jsonData['Driving Mode'] ?? _drivingMode;
    _warningLights = jsonData['Warning Lights'] ?? _warningLights;
    _fuelGauge = jsonData['Fuel Gauge'] ?? _fuelGauge;
    _turnDirection = jsonData['Turn Direction'] ?? _turnDirection;
    _turnSignal = jsonData['Turn Signal'] ?? _turnSignal;
    _brakeStatus = jsonData['Brake Status'] ?? _brakeStatus;
    _tirePressure = jsonData['Tire Pressure'] ?? _tirePressure;
    _parkingSensorStatus =
        jsonData['Parking Sensor Status'] ?? _parkingSensorStatus;
    _stabilityControlStatus =
        jsonData['Stability Control Status'] ?? _stabilityControlStatus;
    _averageFuelConsumption =
        jsonData['Average Fuel Consumption']?.toDouble() ??
            _averageFuelConsumption;
    _engineTemperature = jsonData['Engine Temperature'] ?? _engineTemperature;
    _batteryStatus = jsonData['Battery Status'] ?? _batteryStatus;
    _errorLightStatus = jsonData['Error Light Status'] ?? _errorLightStatus;

    // Notify listeners to update the UI
    notifyListeners();
  }

  // Factory constructor for JSON deserialization
  factory CarDataModel.fromJson(Map<String, dynamic> json) {
    return CarDataModel(
      odometer: json['Odometer'],
      temperatureGauge: json['Temperature gauge'].toDouble(),
      temperatureOutside: json['Temperature outside'].toDouble(),
      lightDirection: json['Light Direction'],
      tachometer: json['Tachometer'],
      speedometer: json['Speedometer'],
      oilPressure: json['Oil Pressure'].toDouble(),
      clock: json['Clock'],
      climateControl: json['Climate Control'],
      drivingMode: json['Driving Mode'],
      warningLights: json['Warning Lights'],
      fuelGauge: json['Fuel Gauge'],
      turnDirection: json['Turn Direction'],
      turnSignal: json['Turn Signal'],
      brakeStatus: json['Brake Status'],
      tirePressure: json['Tire Pressure'],
      parkingSensorStatus: json['Parking Sensor Status'],
      stabilityControlStatus: json['Stability Control Status'],
      averageFuelConsumption: json['Average Fuel Consumption'].toDouble(),
      engineTemperature: json['Engine Temperature'],
      batteryStatus: json['Battery Status'],
      errorLightStatus: json['Error Light Status'],
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'Odometer': _odometer,
      'Temperature gauge': _temperatureGauge,
      'Temperature outside': _temperatureOutside,
      'Light Direction': _lightDirection,
      'Tachometer': _tachometer,
      'Speedometer': _speedometer,
      'Oil Pressure': _oilPressure,
      'Clock': _clock,
      'Climate Control': _climateControl,
      'Driving Mode': _drivingMode,
      'Warning Lights': _warningLights,
      'Fuel Gauge': _fuelGauge,
      'Turn Direction': _turnDirection,
      'Turn Signal': _turnSignal,
      'Brake Status': _brakeStatus,
      'Tire Pressure': _tirePressure,
      'Parking Sensor Status': _parkingSensorStatus,
      'Stability Control Status': _stabilityControlStatus,
      'Average Fuel Consumption': _averageFuelConsumption,
      'Engine Temperature': _engineTemperature,
      'Battery Status': _batteryStatus,
      'Error Light Status': _errorLightStatus,
    };
  }
}
