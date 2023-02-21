import 'package:mi_commerce/data/connection_helper.dart';
import 'package:mi_commerce/data/models/products_model.dart';

class AppRepository {
  final baseUrl = "https://panel.supplyline.network/api";
  final ConnectionHelper _connectionHelper = ConnectionHelper();
  int offsetLimit = 10;

  Future<ProductsModel?> getSearchResult({searchPattern, limit}) async {
    offsetLimit += limit as int;
    try {
      final response = await _connectionHelper.getData(
          "$baseUrl/product/search-suggestions/?limit=$offsetLimit&offset=$offsetLimit&search=$searchPattern");

      if (response != null) {
        if (response.statusCode == 200) {
          return ProductsModel.fromJson(response.data);
        }
      }
      return null;
    } catch (e) {
      Exception(e);
      return null;
    }
  }
}
