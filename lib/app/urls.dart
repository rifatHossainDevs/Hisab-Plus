class Urls {
  static const String _baseUrl = 'https://www.hisabplus.com/Values';
  static const String imageUrl = 'https://www.Hisabplus.com/';

  static String loginUrl(String username, String password) =>
      '$_baseUrl/login?UserName=$username&Password=$password&ComId=1';

  static String customerListUrl(int pageNo, int pageSize) =>
      '$_baseUrl/GetCustomerList?searchquery&pageNo=$pageNo&pageSize=$pageSize&SortyBy=Balance';
}
