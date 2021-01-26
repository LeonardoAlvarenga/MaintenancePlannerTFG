/*
  Models para conversão de unidades Físicas
    > Ordem do Código: Acceleration, ElectricCurrent, Energy, Force, Length, Mass, Power, Pressure, Temperature, Time, Torque, Velocity
    
    Para copiar: Aceleração, Comprimento, Corrente Elétrica, Energia, Força, Massa, Potência, Pressão, Temperatura, Tempo, Torque, Velocidade

*/
import 'package:flutter/foundation.dart';

// Compilado
class AllUnitsTypes {
  static const Map<String, Map<String, Object>> allUnitsTypes = {
    'Aceleração': symbolAndUnitAcceleration,
    'Comprimento': symbolAndUnitLength,
    'Corrente Elétrica': symbolAndUnitElectricCurrent,
    'Energia': symbolAndUnitEnergy,
    'Força': symbolAndUnitForce,
    'Massa': symbolAndUnitMass,
    'Potência': symbolAndUnitPower,
    'Pressão': symbolAndUnitPressure,
    'Temperatura': symbolAndUnitTemperature,
    'Tempo': symbolAndUnitTime,
    'Torque': symbolAndUnitTorque,
    'Velocidade': symbolAndUnitVelocity,
    'Outra...': symbolAndUnitOther,
  };

  static const Map<String, AccelerationUnit> symbolAndUnitAcceleration = {
    'm/s²': AccelerationUnit.MetersPerSecond_2,
    'mm/s²': AccelerationUnit.MilimetersPerSecond_2,
    'km/h': AccelerationUnit.KilometersPerHour_2,
  };
  static const Map<String, ElectricCurrentUnit> symbolAndUnitElectricCurrent = {
    'A': ElectricCurrentUnit.Ampere,
    'dA': ElectricCurrentUnit.DeciAmpere,
    'cA': ElectricCurrentUnit.CentiAmpere,
    'mA': ElectricCurrentUnit.MiliAmpere,
    'μA': ElectricCurrentUnit.MicroAmpere,
    'nA': ElectricCurrentUnit.NanoAmpere,
    'pA': ElectricCurrentUnit.PicoAmpere,
  };
  static const Map<String, EnergyUnit> symbolAndUnitEnergy = {
    'J': EnergyUnit.Joule,
    'kWh': EnergyUnit.KiloWattHour,
  };
  static const Map<String, ForceUnit> symbolAndUnitForce = {
    'N': ForceUnit.Newton,
  };
  static const Map<String, LengthUnit> symbolAndUnitLength = {
    'm': LengthUnit.Meters,
    'cm': LengthUnit.Centimeters,
    'mm': LengthUnit.Milimeters,
    'km': LengthUnit.Kilometers,
    'pés': LengthUnit.Feet,
    'polegadas': LengthUnit.Inches,
  };
  static const Map<String, MassUnit> symbolAndUnitMass = {
    'kg': MassUnit.Kilogram,
    'Ton': MassUnit.Ton,
    'g': MassUnit.Gram,
    'lb': MassUnit.Pound,
  };
  static const Map<String, PowerUnit> symbolAndUnitPower = {
    'watt': PowerUnit.Watt,
    'kW': PowerUnit.KiloWatt,
    'CV': PowerUnit.CV,
  };
  static const Map<String, PressureUnit> symbolAndUnitPressure = {
    'atm': PressureUnit.Atm,
    'bar': PressureUnit.Bar,
    'Pa': PressureUnit.Pascal,
    'kPa': PressureUnit.KiloPascal,
    'MPa': PressureUnit.MegaPascal,
    'GPa': PressureUnit.GigaPascal,
    'psi': PressureUnit.Psi,
    'ksi': PressureUnit.Ksi,
    'm.c.a.': PressureUnit.MH2O,
    'mmHg': PressureUnit.MmHg,
    'kgf/cm²': PressureUnit.KgFCm2,
  };
  static const Map<String, TemperatureUnit> symbolAndUnitTemperature = {
    'ºC': TemperatureUnit.Celsius,
    'ºF': TemperatureUnit.Fahrenheit,
    'K': TemperatureUnit.Kelvin,
  };
  static const Map<String, TimeUnit> symbolAndUnitTime = {
    's': TimeUnit.Seconds,
    'h': TimeUnit.Hour,
  };
  static const Map<String, TorqueUnit> symbolAndUnitTorque = {
    'N.w': TorqueUnit.NewtonMetro,
  };
  static const Map<String, VelocityUnit> symbolAndUnitVelocity = {
    'm/s': VelocityUnit.MetersPerSecond,
    'mm/s': VelocityUnit.MilimetersPerSecond,
    'km/h': VelocityUnit.KilometersPerHour,
  };
  static const Map<String, OtherUnit> symbolAndUnitOther = {
    'none': OtherUnit.None,
  };
}

// ################################################################################################################
// ###############################################  ACCELERATION  #################################################
// ################################################################################################################

enum OtherUnit {
  None,
}

enum AccelerationUnit {
  MetersPerSecond_2,
  MilimetersPerSecond_2,
  KilometersPerHour_2,
}

class Acceleration {
  final double accelValue;
  final AccelerationUnit accelUnit;

  Acceleration({
    @required this.accelValue,
    @required this.accelUnit,
  });
}

// ################################################################################################################
// #############################################  ELECTRIC CURRENT  ###############################################
// ################################################################################################################

enum ElectricCurrentUnit {
  Ampere,
  DeciAmpere,
  CentiAmpere,
  MiliAmpere,
  MicroAmpere,
  NanoAmpere,
  PicoAmpere,
}

class ElectricCurrent {
  final double eleCuValue;
  final ElectricCurrentUnit eleCuUnit;

  ElectricCurrent({
    @required this.eleCuValue,
    @required this.eleCuUnit,
  });
}

// ################################################################################################################
// ##################################################  ENERGY  ####################################################
// ################################################################################################################

enum EnergyUnit {
  Joule,
  KiloWattHour,
}

class Energy {
  final double enerValue;
  final TorqueUnit enerUnit;

  Energy({
    @required this.enerValue,
    @required this.enerUnit,
  });
}

// ################################################################################################################
// ###################################################  FORCE  ####################################################
// ################################################################################################################

enum ForceUnit {
  Newton,
}

class Force {
  final double forceValue;
  final ForceUnit forceUnit;

  Force({
    @required this.forceValue,
    @required this.forceUnit,
  });
}

// ################################################################################################################
// ###################################################  LENGTH  ###################################################
// ################################################################################################################

enum LengthUnit {
  Meters,
  Centimeters,
  Milimeters,
  Kilometers,
  Feet,
  Inches,
}

class Length {
  final double lengValue;
  final LengthUnit lengUnit;

  Length({
    @required this.lengValue,
    @required this.lengUnit,
  });
}

// ################################################################################################################
// ###################################################  MASS  #####################################################
// ################################################################################################################

enum MassUnit {
  Kilogram,
  Ton,
  Gram,
  Pound,
}

class Mass {
  final double massValue;
  final MassUnit massUnit;

  Mass({
    @required this.massValue,
    @required this.massUnit,
  });

  double massInKilogram() {
    if (massUnit == MassUnit.Ton) {
      return massValue * 1000;
    } else if (massUnit == MassUnit.Gram) {
      return massValue / 1000;
    } else if (massUnit == MassUnit.Pound) {
      return massValue / 2.20462;
    } else {
      return massValue;
    }
  }

  double massInTon() {
    if (massUnit == MassUnit.Kilogram) {
      return massValue / 1000;
    } else if (massUnit == MassUnit.Gram) {
      return massValue / 1000000;
    } else if (massUnit == MassUnit.Pound) {
      return massValue / 2204.62;
    } else {
      return massValue;
    }
  }

  double massInGram() {
    if (massUnit == MassUnit.Ton) {
      return massValue * 1000000;
    } else if (massUnit == MassUnit.Kilogram) {
      return massValue * 1000;
    } else if (massUnit == MassUnit.Pound) {
      return massValue / 2204.62;
    } else {
      return massValue;
    }
  }

  double massInPound() {
    if (massUnit == MassUnit.Kilogram) {
      return massValue * 2.20462;
    } else if (massUnit == MassUnit.Gram) {
      return massValue * 0.00220462;
    } else if (massUnit == MassUnit.Ton) {
      return massValue * 2204.62;
    } else {
      return massValue;
    }
  }
}

// ################################################################################################################
// ###################################################  POWER  ####################################################
// ################################################################################################################

enum PowerUnit {
  Watt,
  KiloWatt,
  CV,
}

class Power {
  final double powerValue;
  final PowerUnit powerUnit;

  Power({
    @required this.powerValue,
    @required this.powerUnit,
  });
}

// ################################################################################################################
// #################################################  PRESSURE  ###################################################
// ################################################################################################################

enum PressureUnit {
  GigaPascal,
  MegaPascal,
  KiloPascal,
  Pascal,
  MH2O, // metros de coluna d'água
  Bar,
  Atm,
  MmHg, // mm mercúrio
  Psi,
  Ksi,
  KgFCm2, // kilograma força/cm²
}

class Pressure {
  final double pressValue;
  final PressureUnit pressUnit;

  Pressure({
    @required this.pressValue,
    @required this.pressUnit,
  });

  double pressInPascal() {
    if (pressUnit == PressureUnit.Atm) {
      return pressValue * 101325.00000;
    } else if (pressUnit == PressureUnit.Bar) {
      return pressValue * 100000.00000;
    } else if (pressUnit == PressureUnit.KgFCm2) {
      return pressValue * 98066.52;
    } else if (pressUnit == PressureUnit.MH2O) {
      return pressValue * 9806.38;
    } else if (pressUnit == PressureUnit.Psi) {
      return pressValue * 6894.7572932;
    } else if (pressUnit == PressureUnit.Ksi) {
      return pressValue * 6894757.2932;
    } else if (pressUnit == PressureUnit.MmHg) {
      return pressValue * 133.322000;
    } else if (pressUnit == PressureUnit.GigaPascal) {
      return pressValue / 1000000000.0;
    } else if (pressUnit == PressureUnit.MegaPascal) {
      return pressValue / 1000000.0;
    } else if (pressUnit == PressureUnit.KiloPascal) {
      return pressValue / 1000.0;
    } else {
      return pressValue;
    }
  }

  double pressInKiloPascal() {
    if (pressUnit == PressureUnit.Atm) {
      return pressValue * 101.32500000;
    } else if (pressUnit == PressureUnit.Bar) {
      return pressValue * 100.00000000;
    } else if (pressUnit == PressureUnit.KgFCm2) {
      return pressValue * 98.06652;
    } else if (pressUnit == PressureUnit.MH2O) {
      return pressValue * 9.80638;
    } else if (pressUnit == PressureUnit.Psi) {
      return pressValue * 6.8947572932;
    } else if (pressUnit == PressureUnit.Ksi) {
      return pressValue * 6894.7572932;
    } else if (pressUnit == PressureUnit.MmHg) {
      return pressValue * 0.133322000;
    } else if (pressUnit == PressureUnit.GigaPascal) {
      return pressValue / 1000000.0000;
    } else if (pressUnit == PressureUnit.MegaPascal) {
      return pressValue / 1000.0000;
    } else if (pressUnit == PressureUnit.Pascal) {
      return pressValue * 1000.0;
    } else
      return pressValue;
  }

  double pressInMegaPascal() {
    if (pressUnit == PressureUnit.Atm) {
      return pressValue * 0.101325;
    } else if (pressUnit == PressureUnit.Bar) {
      return pressValue * 0.100;
    } else if (pressUnit == PressureUnit.KgFCm2) {
      return pressValue * .09806652;
    } else if (pressUnit == PressureUnit.MH2O) {
      return pressValue * 0.00980638;
    } else if (pressUnit == PressureUnit.Psi) {
      return pressValue * 0.0068947572932;
    } else if (pressUnit == PressureUnit.Ksi) {
      return pressValue * 6.8947572932;
    } else if (pressUnit == PressureUnit.MmHg) {
      return pressValue * 0.000133322000;
    } else if (pressUnit == PressureUnit.GigaPascal) {
      return pressValue / 1000.000;
    } else if (pressUnit == PressureUnit.KiloPascal) {
      return pressValue * 1000.0;
    } else if (pressUnit == PressureUnit.Pascal) {
      return pressValue * 1000000.0;
    } else
      return pressValue;
  }

  double pressInGigaPascal() {
    if (pressUnit == PressureUnit.Atm) {
      return pressValue * 0.0000101325;
    } else if (pressUnit == PressureUnit.Bar) {
      return pressValue * 0.0000100;
    } else if (pressUnit == PressureUnit.KgFCm2) {
      return pressValue * 0.00009806652;
    } else if (pressUnit == PressureUnit.MH2O) {
      return pressValue * 0.000000980638;
    } else if (pressUnit == PressureUnit.Psi) {
      return pressValue * 0.00000068947572932;
    } else if (pressUnit == PressureUnit.Ksi) {
      return pressValue * 0.00068947572932;
    } else if (pressUnit == PressureUnit.MmHg) {
      return pressValue * 0.0000000133322000;
    } else if (pressUnit == PressureUnit.MegaPascal) {
      return pressValue * 1000.000;
    } else if (pressUnit == PressureUnit.KiloPascal) {
      return pressValue * 1000000.0;
    } else if (pressUnit == PressureUnit.Pascal) {
      return pressValue * 1000000000.0;
    } else
      return pressValue;
  }

  double pressInAtm() {
    if (pressUnit == PressureUnit.Pascal) {
      return pressValue / 101325.00;
    } else if (pressUnit == PressureUnit.Bar) {
      return pressValue * 0.986923;
    } else if (pressUnit == PressureUnit.KgFCm2) {
      return pressValue * 0.967841;
    } else if (pressUnit == PressureUnit.MH2O) {
      return pressValue * 0.096781;
    } else if (pressUnit == PressureUnit.Psi) {
      return pressValue / 14.69594;
    } else if (pressUnit == PressureUnit.Ksi) {
      return pressValue / (1000 * 14.69594);
    } else if (pressUnit == PressureUnit.MmHg) {
      return pressValue * 0.00131579;
    } else if (pressUnit == PressureUnit.GigaPascal) {
      return (pressValue / 101325.00) * 1000000000.0;
    } else if (pressUnit == PressureUnit.MegaPascal) {
      return (pressValue / 101325.00) * 1000000.0;
    } else if (pressUnit == PressureUnit.KiloPascal) {
      return (pressValue / 101325.00) * 1000.0;
    } else {
      return pressValue;
    }
  }

  double pressInBar() {
    if (pressUnit == PressureUnit.Pascal) {
      return pressValue / 101325.00;
    } else if (pressUnit == PressureUnit.Atm) {
      return pressValue * 1.01325;
    } else if (pressUnit == PressureUnit.KgFCm2) {
      return pressValue / 1.01972;
    } else if (pressUnit == PressureUnit.MH2O) {
      return pressValue * .0980665;
    } else if (pressUnit == PressureUnit.Psi) {
      return pressValue * 0.0689476;
    } else if (pressUnit == PressureUnit.Ksi) {
      return pressValue * 68.9476;
    } else if (pressUnit == PressureUnit.MmHg) {
      return pressValue * 0.00133322;
    } else if (pressUnit == PressureUnit.GigaPascal) {
      return pressValue * 0.0001;
    } else if (pressUnit == PressureUnit.MegaPascal) {
      return pressValue * 0.1;
    } else if (pressUnit == PressureUnit.KiloPascal) {
      return pressValue * 100;
    } else {
      return pressValue;
    }
  }

  double pressInPsi() {
    if (pressUnit == PressureUnit.Pascal) {
      return pressValue / 6894.7572931783;
    } else if (pressUnit == PressureUnit.Atm) {
      return pressValue / 0.0680459639;
    } else if (pressUnit == PressureUnit.KgFCm2) {
      return pressValue / 0.070306958;
    } else if (pressUnit == PressureUnit.MH2O) {
      return pressValue / 0.7035466625683673;
    } else if (pressUnit == PressureUnit.Bar) {
      return pressValue / 0.0689475729;
    } else if (pressUnit == PressureUnit.Ksi) {
      return pressValue / 0.001;
    } else if (pressUnit == PressureUnit.MmHg) {
      return pressValue / 51.7150754803;
    } else if (pressUnit == PressureUnit.GigaPascal) {
      return pressValue / 0.0000068947573;
    } else if (pressUnit == PressureUnit.MegaPascal) {
      return pressValue / 0.0068947573;
    } else if (pressUnit == PressureUnit.KiloPascal) {
      return pressValue / 6.8947572932;
    } else {
      return pressValue;
    }
  }

  double pressInKsi() {
    if (pressUnit == PressureUnit.Pascal) {
      return pressValue / 6894757.2931783;
    } else if (pressUnit == PressureUnit.Atm) {
      return pressValue / 68.04596391;
    } else if (pressUnit == PressureUnit.KgFCm2) {
      return pressValue / 70.306957964;
    } else if (pressUnit == PressureUnit.MH2O) {
      return pressValue * 703.5466625683673;
    } else if (pressUnit == PressureUnit.Psi) {
      return pressValue / 1000;
    } else if (pressUnit == PressureUnit.Bar) {
      return pressValue / 68.9475729318;
    } else if (pressUnit == PressureUnit.MmHg) {
      return pressValue / 51715.075480253;
    } else if (pressUnit == PressureUnit.GigaPascal) {
      return pressValue / 0.0068947573;
    } else if (pressUnit == PressureUnit.MegaPascal) {
      return pressValue / 6.8947572932;
    } else if (pressUnit == PressureUnit.KiloPascal) {
      return pressValue / 6894.7572931783;
    } else {
      return pressValue;
    }
  }

  double pressInMH2O() {
    if (pressUnit == PressureUnit.Pascal) {
      return pressValue / 9800;
    } else if (pressUnit == PressureUnit.Atm) {
      return pressValue / 0.09671821878659459;
    } else if (pressUnit == PressureUnit.KgFCm2) {
      return pressValue / 0.099997;
    } else if (pressUnit == PressureUnit.Bar) {
      return pressValue / 0.0980665;
    } else if (pressUnit == PressureUnit.Psi) {
      return pressValue / 1.4213698297557125;
    } else if (pressUnit == PressureUnit.Ksi) {
      return pressValue / 0.0014213698297557125;
    } else if (pressUnit == PressureUnit.MmHg) {
      return pressValue / 73.50604490503765;
    } else if (pressUnit == PressureUnit.GigaPascal) {
      return pressValue * 0.0000098;
    } else if (pressUnit == PressureUnit.MegaPascal) {
      return pressValue / 0.0098;
    } else if (pressUnit == PressureUnit.KiloPascal) {
      return pressValue / 9.8;
    } else {
      return pressValue;
    }
  }

  double pressInMmHg() {
    if (pressUnit == PressureUnit.Pascal) {
      return pressValue / 133.322368421;
    } else if (pressUnit == PressureUnit.Atm) {
      return pressValue / 0.0013157859181723722;
    } else if (pressUnit == PressureUnit.KgFCm2) {
      return pressValue / 0.00135951;
    } else if (pressUnit == PressureUnit.MH2O) {
      return pressValue / 0.013604323308265305;
    } else if (pressUnit == PressureUnit.Psi) {
      return pressValue / 0.01933677470461073;
    } else if (pressUnit == PressureUnit.Ksi) {
      return pressValue / 0.00001933677470461073;
    } else if (pressUnit == PressureUnit.Bar) {
      return pressValue / 0.0013604323308265306;
    } else if (pressUnit == PressureUnit.GigaPascal) {
      return pressValue / 0.000000133322368421;
    } else if (pressUnit == PressureUnit.MegaPascal) {
      return pressValue / 0.000133322368421;
    } else if (pressUnit == PressureUnit.KiloPascal) {
      return pressValue / 0.13332236842099998;
    } else {
      return pressValue;
    }
  }

  double pressInKgFCm2() {
    if (pressUnit == PressureUnit.Pascal) {
      return pressValue / 98066.5204821735;
    } else if (pressUnit == PressureUnit.Atm) {
      return pressValue / 0.9678413401;
    } else if (pressUnit == PressureUnit.Bar) {
      return pressValue / 0.9806652048;
    } else if (pressUnit == PressureUnit.MH2O) {
      return pressValue / 10.00027742;
    } else if (pressUnit == PressureUnit.Psi) {
      return pressValue * 14.2233425777;
    } else if (pressUnit == PressureUnit.Ksi) {
      return pressValue * 0.0142233425777;
    } else if (pressUnit == PressureUnit.MmHg) {
      return pressValue / 735.5614700564;
    } else if (pressUnit == PressureUnit.GigaPascal) {
      return pressValue * 0.0000980665204821735;
    } else if (pressUnit == PressureUnit.MegaPascal) {
      return pressValue * 0.0980665204821735;
    } else if (pressUnit == PressureUnit.KiloPascal) {
      return pressValue / 98.0665204821735;
    } else {
      return pressValue;
    }
  }
}

// ################################################################################################################
// ################################################  TEMPERATURE  #################################################
// ################################################################################################################

enum TemperatureUnit {
  Celsius,
  Fahrenheit,
  Kelvin,
}

class Temperature {
  final double tempValue;
  final TemperatureUnit tempUnit;

  Temperature({
    @required this.tempUnit,
    @required this.tempValue,
  });

  double tempInKelvin() {
    if (tempUnit == TemperatureUnit.Celsius) {
      return 273.15 + tempValue;
    } else if (tempUnit == TemperatureUnit.Fahrenheit) {
      return (tempValue - 32) / 1.8 + 273.15;
    } else {
      return tempValue;
    }
  }

  double tempInFahrenheit() {
    if (tempUnit == TemperatureUnit.Celsius) {
      return 1.8 * tempValue + 32;
    } else if (tempUnit == TemperatureUnit.Kelvin) {
      return (tempValue - 273.15) * 1.8 + 32;
    } else {
      return tempValue;
    }
  }

  double tempInCelsius() {
    if (tempUnit == TemperatureUnit.Fahrenheit) {
      return (tempValue - 32) / 1.8;
    } else if (tempUnit == TemperatureUnit.Kelvin) {
      return tempValue - 273.15;
    } else {
      return tempValue;
    }
  }
}

// ################################################################################################################
// ####################################################  TIME  ####################################################
// ################################################################################################################

enum TimeUnit {
  Seconds,
  Hour,
}

class TimeMo {
  final double timeValue;
  final TimeUnit timeUnit;

  TimeMo({
    @required this.timeValue,
    @required this.timeUnit,
  });
}

// ################################################################################################################
// ###################################################  TORQUE  ###################################################
// ################################################################################################################

enum TorqueUnit { NewtonMetro }

class Torque {
  final double torqueValue;
  final TorqueUnit torqueUnit;

  Torque({
    @required this.torqueValue,
    @required this.torqueUnit,
  });
}

// ################################################################################################################
// ##################################################  VELOCITY  ##################################################
// ################################################################################################################

enum VelocityUnit {
  MetersPerSecond,
  MilimetersPerSecond,
  KilometersPerHour,
}

class Velocity {
  final double veloValue;
  final VelocityUnit veloUnit;

  Velocity({
    @required this.veloValue,
    @required this.veloUnit,
  });
}
