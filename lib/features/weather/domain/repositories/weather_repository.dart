import 'package:cleanarch/core/error/failure.dart';
import 'package:cleanarch/features/weather/domain/entities/weather_entity.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
