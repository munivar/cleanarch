import 'package:cleanarch/features/weather/data/data_sources/remote_data_source.dart';
import 'package:cleanarch/features/weather/domain/repositories/weather_repository.dart';
import 'package:cleanarch/features/weather/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [WeatherRepository, WeatherRemoteDataSource, GetCurrentWeatherUseCase],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
