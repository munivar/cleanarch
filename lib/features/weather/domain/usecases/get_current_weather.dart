import 'package:cleanarch/core/error/failure.dart';
import 'package:cleanarch/features/weather/domain/entities/weather_entity.dart';
import 'package:cleanarch/features/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
