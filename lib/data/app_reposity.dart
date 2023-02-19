import 'package:mi_commerce/data/connection_helper.dart';

class AppRepository {
  final baseUrl = "https://panel.supplyline.network/api";
  final ConnectionHelper _connectionHelper = ConnectionHelper();

  _getSearchResult({searchPattern, offsetLimit = 10}) async {
    try {
      final response = await _connectionHelper.getData(
          "$baseUrl//search-suggestions/?limit=10&offset=$offsetLimit&search=$searchPattern");
    } catch (e) {
      Exception(e);
    }
  }
}
