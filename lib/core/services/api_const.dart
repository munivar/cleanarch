class ApiConst {
  ApiConst();
  // base url
  static const String baseURL = "http://localhost:3001/api/v1/";
// api endpoints
  static const String loginEp = "user/login";
  // base url and api keys
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'cc95d932d5a45d33a9527d5019475f2c';
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
