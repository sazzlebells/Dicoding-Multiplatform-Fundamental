import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/restaurant.dart';
import 'package:restaurant_api/data/model/search.dart';
import 'package:restaurant_api/provider/restaurant_provider.dart';

class MockApiService extends Mock implements ApiService {}

const apiResult = {
  'error': false,
  'message': 'success',
  'count': 1,
  'restaurants': [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
  ]
};

const testResto = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};

const searchResponse = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
  ]
};

void main() {
  group('Restaurant Provider Test', () {
    RestaurantProvider? provider;
    ApiService? apiService;
    setUp(() {
      apiService = MockApiService();
      when(apiService!.restaurantName()).thenAnswer(
          (realInvocation) async => RestaurantResult.fromJson(apiResult));
      provider = RestaurantProvider(service: apiService!);
    });

    test('should verify that fetching restaurant json parse run as expected',
        () async {
      var result = provider!.result!.restaurants![0];
      var jsonResto = Restaurant.fromJson(testResto);

      expect(result.id == jsonResto.id, true);
      expect(result.name == jsonResto.name, true);
      expect(result.description == jsonResto.description, true);
      expect(result.pictureId == jsonResto.pictureId, true);
      expect(result.city == jsonResto.city, true);
      expect(result.rating == jsonResto.rating, true);
    });

    test('should verify that restaurant search run as expected', () async {
      when(apiService!.search('melting')).thenAnswer(
          (realInvocation) async => SearchResult.fromJson(searchResponse));
      var result = provider!.result!.restaurants![0];
      var jsonResto = Restaurant.fromJson(testResto);

      expect(result.id == jsonResto.id, true);
      expect(result.name == jsonResto.name, true);
      expect(result.description == jsonResto.description, true);
      expect(result.pictureId == jsonResto.pictureId, true);
      expect(result.city == jsonResto.city, true);
      expect(result.rating == jsonResto.rating, true);
    });
  });
}
